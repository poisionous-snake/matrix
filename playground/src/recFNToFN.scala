package hardfloat

import chisel3._
import chisel3.util._

class recFNToFN(val expWidth: Int, val sigWidth: Int) extends Module {
    val io = IO(new Bundle {
        val in  = Input(UInt((expWidth + sigWidth + 1).W))
        val out = Output(UInt((expWidth + sigWidth).W))
    })
    val minNormExp = Wire(SInt(expWidth.W))
    minNormExp := ((1.U << (expWidth - 1)) + 2.U).asSInt
    val normDistWidth = log2Ceil(sigWidth)

    val rawFloat = rawFloatFromRecFN(expWidth, sigWidth, io.in)
    val isNaN = rawFloat.isNaN
    val isInf = rawFloat.isInf
    val isZero = rawFloat.isZero
    val sign = rawFloat.sign
    val sExp = rawFloat.sExp
    val sig = rawFloat.sig

    val isSubnormal = (sExp < minNormExp)

    val denormShiftDist = (minNormExp - 1.S - sExp).asUInt(normDistWidth - 1, 0)

    val expOut = Mux(isSubnormal, 0.U, (sExp - minNormExp + 1.S).asUInt(expWidth - 1, 0)) | Mux(isNaN || isInf, Fill(expWidth, 1.U), 0.U)

    val fracOut = Wire(UInt((sigWidth - 1).W))
    fracOut := Mux(isSubnormal, 
                (sig >> 1) >> denormShiftDist,
                Mux(isInf, 0.U, sig))

    io.out := Cat(sign, expOut, fracOut)
}
