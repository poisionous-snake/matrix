package mac

import chisel3._
import chisel3.util._

// import hardfloat._
// import consts._

class InnerProduct(val SIZE: Int = 32) extends Module {
    val io = IO(new Bundle{
        val int = Input(Vec(SIZE/2, UInt(8.W)))
        val fp = Input(Vec(SIZE, UInt(16.W)))
        val result = Output(UInt(16.W))
        val fusion = Input(Bool())
    })
    val fusionArray = Seq.fill(SIZE/2)(Module(new Fusion()))

    for (i <- 0 until SIZE/2) {
        fusionArray(i).io.int8 := io.int(i)
        fusionArray(i).io.fp16 := VecInit(io.fp(2*i + 1), io.fp(2*i))
        fusionArray(i).io.fusion := io.fusion
    }

    val outputs0 = fusionArray.map(_.io.output0).map(o => RegNext(o))
    val outputs1 = fusionArray.map(_.io.output1).map(o => RegNext(o))

    def pipelinedAdderTree(inputs: Seq[UInt]): UInt = {
        if (inputs.length == 1) inputs.head
        else {
            val nextLevel = inputs.grouped(2).map {
                case Seq(a, b) =>
                    // val adder = Module(new AddRecFN(expWidth = 5, sigWidth = 11))
                    // adder.io.subOp := false.B
                    // adder.io.a := a // TODO: fnToRecFn
                    // adder.io.b := b
                    // adder.io.roundingMode := round_near_even
                    // adder.io.detectTininess := true.B

                    val adder = Module(new Fp16Add())
                    printf("a = %b, b = %b\n", a, b)
                    adder.io.in1 := a
                    adder.io.in2 := b
                    RegNext(adder.io.out)
                case Seq(a) => RegNext(a)
            }.toSeq
            pipelinedAdderTree(nextLevel)
        }
    }

    val sum0 = pipelinedAdderTree(outputs0)
    val sum1 = pipelinedAdderTree(outputs1)
    when(io.fusion){
        io.result := sum1
    } .otherwise {
        io.result := RegNext(sum0 + sum1)
    } 

    printf("result = %b\n", io.result);
}