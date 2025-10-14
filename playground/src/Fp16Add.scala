package mac 

import chisel3._
import chisel3.util._ 

class Fp16Add extends Module {
  val io = IO(new Bundle{
    val in1 = Input(UInt(16.W))
    val in2 = Input(UInt(16.W))
    val out = Output(UInt(16.W))
  })
    val sign1 = io.in1(15)
    val exp1 = io.in1(14, 10)
    val mant1 = io.in1(9, 0)

    val sign2 = io.in2(15)
    val exp2 = io.in2(14, 10)
    val mant2 = io.in2(9, 0)
    
    val fullMant1 = Cat(1.U(1.W), mant1).asSInt // 11-bit
    val fullMant2 = Cat(1.U(1.W), mant2).asSInt // 11-bit

    val expDiff = exp1.zext - exp2.zext
    val finalExp = Wire(UInt(5.W))
    val alignedMant1 = Wire(SInt(12.W)) // 12-bit
    val alignedMant2 = Wire(SInt(12.W))

    when(expDiff >= 0.S) { // exp1 >= exp2
        finalExp := exp1
        alignedMant1 := fullMant1
        alignedMant2 := fullMant1 >> expDiff.asUInt
    } .otherwise {
        finalExp := exp2
        alignedMant1 := fullMant1 >> (-expDiff).asUInt
        alignedMant2 := fullMant2
    }
    
    val mantSum = Mux(sign1, -alignedMant1, alignedMant1) + Mux(sign2, -alignedMant2, alignedMant2)
    
    val finalSign = mantSum(mantSum.getWidth - 1)
    val absMantSum = Mux(finalSign, -mantSum, mantSum).asUInt

    // 1.1 + 1.1 -> 11.0
    val overflow = absMantSum(11)

    val normalizedMant = Wire(UInt(10.W))
    val normalizedExp = Wire(UInt(5.W))

    when(overflow) {
        normalizedMant := absMantSum(10, 1)
        normalizedExp  := finalExp + 1.U
    } .otherwise {
        normalizedMant := absMantSum(9, 0)
        normalizedExp := finalExp
    }

    io.out := Cat(finalSign, normalizedExp, normalizedMant)

    // TODO: 特殊值处理
}