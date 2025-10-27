package mac

import chisel3._
import chisel3.util._

import hardfloat._
import consts._

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

    val outputs0 = fusionArray.map(_.io.output0).map(o => RegNext(o)).map(fp => {
        val trans = Module(new fNToRecFN(expWidth = 5, sigWidth = 11))
        trans.io.in := fp
        trans.io.out
    })
    
    val outputs1 = fusionArray.map(_.io.output1).map(o => RegNext(o)).map(fp => {
        val trans = Module(new fNToRecFN(expWidth = 5, sigWidth = 11))
        trans.io.in := fp
        trans.io.out
    })
    
    printf("output0 = %b, output1 = %b\n", outputs0(0), outputs1(0))

    def pipelinedAdderTree(inputs: Seq[UInt]): UInt = {
        if (inputs.length == 1) inputs.head
        else {
            val nextLevel = inputs.grouped(2).map {
                case Seq(a, b) =>
                    val adder = Module(new AddRecFN(expWidth = 5, sigWidth = 11))
                    adder.io.subOp := false.B
                    adder.io.a := a
                    adder.io.b := b
                    printf("a: %b, b: %b\n", a, b)
                    adder.io.roundingMode := round_near_even
                    adder.io.detectTininess := true.B
                    RegNext(adder.io.out)
                case Seq(a) => a  
            }.toSeq
            pipelinedAdderTree(nextLevel)
        }
    }

    val sum0 = pipelinedAdderTree(outputs0)
    val sum1 = pipelinedAdderTree(outputs1)

    val finalAdder = Module(new AddRecFN(expWidth = 5, sigWidth = 11))
    finalAdder.io.subOp := false.B
    finalAdder.io.a := sum0
    finalAdder.io.b := sum1
    finalAdder.io.roundingMode := round_near_even
    finalAdder.io.detectTininess := true.B

    val transBack = Module(new recFNToFN(expWidth = 5, sigWidth = 11))
    transBack.io.in := Mux(io.fusion, sum1, RegNext(finalAdder.io.out))
    io.result := transBack.io.out

    printf("result = %b\n", io.result);
}