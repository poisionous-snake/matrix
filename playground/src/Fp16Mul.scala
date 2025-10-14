package mac

import chisel3._
import chisel3.util._

class Fp16Mul extends Module {
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

    val fullMant1 = Cat(1.U(1.W), mant1).asUInt
    val fullMant2 = Cat(1.U(1.W), mant2).asUInt

    val realExp1 = exp1 - 15.U 
    val realExp2 = exp2 - 15.U 
    val finalExp = realExp1 + realExp2 + 15.U

    val mantMul = Wire(UInt(22.W)) // (10 + 1) * 2
    mantMul := fullMant1 * fullMant2

    val finalSign = sign1 ^ sign2

    val overflow = mantMul(21)

    val normalizedMant = Wire(UInt(10.W))
    val normalizedExp = Wire(UInt(5.W))

    when(overflow) {
        normalizedMant := mantMul(20, 11) // >> 11 
        normalizedExp := finalExp + 1.U
    } .otherwise {
        normalizedMant := mantMul(19, 10) // >> 10
        normalizedExp := finalExp
    }

    io.out := Cat(finalSign, normalizedExp, normalizedMant)

    // TODO: 特殊值处理
}
