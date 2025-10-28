package mac

import chisel3._
import chisel3.util._

class Int4Fp16Mul extends Module {
    val io = IO(new Bundle {
        val i = Input(UInt(4.W))
        val f = Input(UInt(16.W))
        val result = Output(UInt(16.W))
    })
    val (i, f) = (io.i, io.f)

    val iAbs = Wire(UInt(4.W))
    iAbs := Mux(i(3), ~i(2, 0) +& 1.U, i(2, 0))

    // exp
    val exp = f(14, 10)
    val fZero = f(14, 0) === 0.U
    val addedExp = Wire(UInt(6.W))
    val bound = MuxLookup(iAbs, 0.U, (
        Seq(
            "b0000".U -> 0.U,
            "b0001".U -> 0.U,
            "b0010".U -> 1.U,
            "b0011".U -> 1.U,
            "b0100".U -> 2.U,
            "b0101".U -> 2.U,
            "b0110".U -> 2.U,
            "b0111".U -> 2.U,
            "b1000".U -> 3.U,
        )
    ))
    addedExp := exp +& bound

    // sign
    val finalSign = f(15) ^ i(3)

    // frac
    val frac = Cat(1.U(1.W), f(9, 0), 0.U(2.W)) // 13-bit 最后两位用于移位后暂时保留精度
    // 11
    //  11
    //   11
    val fracSum = Wire(UInt(14.W))
    fracSum := MuxLookup(iAbs, 0.U, (
        Seq(
            0.U -> 0.U,
            1.U -> frac,
            2.U -> frac,
            3.U -> (frac +& (frac >> 1)),
            4.U -> frac,
            5.U -> (frac +& (frac >> 2)),
            6.U -> (frac +& (frac >> 1)),
            7.U -> (frac +& (frac >> 1) +& (frac >> 2)),
            8.U -> frac
        )
    ))
    val fracShift = fracSum(13) // exp + 1
    val finalExp = addedExp + fracShift
    val expOverflow = finalExp(5) // INF
    // L - 最低保留位 (LSB)
    // G - 保护位 (Guard bit)
    // R - 舍入位 (Round bit)  
    // S - 粘滞位 (Sticky bit)
    val finalFrac = Wire(UInt(10.W))
    val lsb = Wire(UInt(1.W))
    val grs = Wire(UInt(3.W))
    when(fracShift) {
        finalFrac := fracSum(12, 3)
        grs := fracSum(2, 0)
        lsb := fracSum(3)
    } .otherwise {
        finalFrac := fracSum(11, 2)
        grs := Cat(fracSum(1, 0), 0.U)
        lsb := fracSum(2)
    }

    val fIsZero = (exp === 0.U) && (frac === 0.U)
    val iIsZero = i === 0.U

    // TODO: 非规范数

    val isINF = expOverflow || ((exp === "b11111".U) && (f(9, 0) === 0.U)) // 乘后溢出 || 原本就是INF

    val fisNaN = (exp === "b11111".U) && (f(9, 0) =/= 0.U)
    val QNaN = fisNaN && f(9)
    val SNaN = fisNaN && !f(9)

    when(fIsZero || iIsZero) {
        io.result := Cat(finalSign, 0.U(15.W))
    } .elsewhen(isINF) {
        io.result := Cat(finalSign, "b11111".U, 0.U(10.W))
    } .elsewhen (fisNaN) { // 传播
        io.result := Cat(0.U(1.W), "b11111".U, "b1000000000".U) // QNaN
    } .otherwise {
        io.result := Cat(finalSign, finalExp, finalFrac)
    }
}