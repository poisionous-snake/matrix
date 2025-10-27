package hardfloat

import chisel3._
import chisel3.util._

class fNToRecFN(val expWidth: Int, val sigWidth: Int) extends Module{
    val io = IO(new Bundle {
        val in  = Input(UInt((expWidth + sigWidth).W))
        val out = Output(UInt((expWidth + sigWidth + 1).W))
    })
    val normDistWidth = log2Ceil(sigWidth)
    val sign = io.in(expWidth + sigWidth - 1)
    val expIn  = io.in(expWidth + sigWidth - 2, sigWidth - 1)
    val fracIn = io.in(sigWidth - 2, 0)

    val isZeroExpIn = (expIn === 0.U)
    val isZeroFracIn = (fracIn === 0.U)

    val normDist = countLeadingZeros(fracIn)
    val subnormalFract = Wire(UInt((sigWidth - 1).W))
    subnormalFract := (fracIn << normDist) << 1

    val adjustedExp = Wire(UInt((expWidth + 1).W))
    adjustedExp := Mux(isZeroExpIn, normDist ^ (1.U << (expWidth + 1)) - 1.U, expIn) + ((1.U << (expWidth - 1)) | Mux(isZeroExpIn, 2.U, 1.U))
    // printf("adjustedExp: %b\n", adjustedExp)
    val isZero = isZeroExpIn && isZeroFracIn
    val isSpecial = adjustedExp(expWidth, expWidth - 1) === "b11".U

    val exp = Wire(UInt((expWidth + 1).W))
    exp := Mux(isSpecial, 
              Cat("b11".U, !isZeroFracIn, adjustedExp(expWidth - 3, 0)), 
              Mux(isZero, 
                  Cat(0.U(3.W), adjustedExp(expWidth - 3, 0)), 
                  adjustedExp))
    // printf("isSpecial: %b, isZero: %b, exp: %b\n", isSpecial, isZero, exp)

    io.out := Cat(sign, exp, Mux(isZeroExpIn, subnormalFract, fracIn))
    
    // printf("isZeroExpIn: %b, subnormalFract: %b, fracIn: %b, io.out: %b\n", isZeroExpIn, subnormalFract, fracIn, io.out)
}
