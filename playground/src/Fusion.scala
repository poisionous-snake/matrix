package mac

import chisel3._
import chisel3.util._

class fracSum extends Module {
    val io = IO(new Bundle {
        val iAbs = Input(UInt(4.W))
        val frac = Input(UInt(10.W))
        val fracSum = Output(UInt(15.W))
    })
    val frac = Cat(1.U(1.W), io.frac)
    val fracSum = (0 until 4).map { i =>
        Mux(io.iAbs(i).asBool, frac << i, 0.U(15.W))
    }.reduce(_ + _)
    // or can be written as:
    // val fracSum = Wire(UInt(15.W))
    // fracSum := io.frac * io.iAbs
    io.fracSum := fracSum
}

class Norm extends Module {
    val io = IO(new Bundle {
        val originFp16 = Input(UInt(16.W))

        val fracSum = Input(UInt(19.W))
        val sign = Input(Bool())

        val fp16 = Output(UInt(16.W))
    })
    val originExp = io.originFp16(14, 10)

    val fracSum = io.fracSum
    val finalFrac = MuxCase(0.U, Seq(
        fracSum(18) -> Cat(fracSum(17, 8), fracSum(7), fracSum(6), fracSum(5, 0).orR),
        fracSum(17) -> Cat(fracSum(16, 7), fracSum(6), fracSum(5), fracSum(4, 0).orR),
        fracSum(16) -> Cat(fracSum(15, 6), fracSum(5), fracSum(4), fracSum(3, 0).orR),
        fracSum(15) -> Cat(fracSum(14, 5), fracSum(4), fracSum(3), fracSum(2, 0).orR),
        fracSum(14) -> Cat(fracSum(13, 4), fracSum(3), fracSum(2), fracSum(1, 0).orR),
        fracSum(13) -> Cat(fracSum(12, 3), fracSum(2), fracSum(1), fracSum(0)),
        fracSum(12) -> Cat(fracSum(11, 2), fracSum(1), fracSum(0), 0.U(1.W)),
        fracSum(11) -> Cat(fracSum(10, 1), fracSum(0), 0.U(2.W)),
        fracSum(10) -> Cat(fracSum(9, 0), 0.U(3.W))
    ))
    // round to Nearest, ties to even
    val lsb = finalFrac(3)
    val guard = finalFrac(2)
    val round = finalFrac(1)
    val sticky = finalFrac(0)

    val roundUp = guard && (round || sticky || lsb)
    val roundedFrac = (finalFrac(12, 3) +& roundUp).asUInt
    val fracOverflow = roundedFrac(10) // 11-bits -> (potential overflow, 10-bits)
    val normFrac = Mux(fracOverflow, roundedFrac(10,1), roundedFrac(9,0))

    val expAdjust = fracOverflow
    val expAdd = MuxCase(0.U, Seq(
        // fracSum(19) -> 9.U,
        fracSum(18) -> 8.U,
        fracSum(17) -> 7.U,
        fracSum(16) -> 6.U,
        fracSum(15) -> 5.U,
        fracSum(14) -> 4.U,
        fracSum(13) -> 3.U,
        fracSum(12) -> 2.U,
        fracSum(11) -> 1.U,
        fracSum(10) -> 0.U
    )) + expAdjust
    val exp = Wire(UInt(6.W))
    exp := originExp +& expAdd

    io.fp16 := Cat(io.sign, exp(4, 0), normFrac)
}

class Fusion extends Module {
    val io = IO(new Bundle {
        val int8 = Input(UInt(8.W))
        val fp16 = Input(Vec(2, UInt(16.W)))

        val fusion = Input(Bool())

        val output0 = Output(UInt(16.W))
        val output1 = Output(UInt(16.W))
    })
    val sign0 = io.int8(3) ^ io.fp16(0)(15)
    val sign1 = io.int8(7) ^ io.fp16(1)(15)

    // separate
    val iAbs0 = Mux(sign0, ~io.int8(3, 0) + 1.U, io.int8(3, 0))
    val iAbs1 = Mux(sign1, ~io.int8(7, 4) + 1.U, io.int8(7, 4))
    // fusion
    val iAbsFull = Mux(sign1, ~io.int8 + 1.U, io.int8)

    val fracSum0 = Module(new fracSum())
    val fracSum1 = Module(new fracSum())
    fracSum0.io.iAbs := Mux(io.fusion, iAbsFull(3, 0), iAbs0)
    fracSum0.io.frac := io.fp16(0)(9, 0)
    fracSum1.io.iAbs := iAbs1
    fracSum1.io.frac := io.fp16(1)(9, 0)

    val fusionFracSum = Wire(UInt(19.W))
    fusionFracSum := (fracSum1.io.fracSum << 4) +& fracSum0.io.fracSum

    val norm0 = Module(new Norm())
    val norm1 = Module(new Norm())
    norm0.io.originFp16 := io.fp16(0)
    norm0.io.fracSum := fracSum0.io.fracSum
    norm0.io.sign := sign0
    io.output0 := norm0.io.fp16

    norm1.io.originFp16 := io.fp16(1)
    norm1.io.fracSum := Mux(io.fusion, fusionFracSum, fracSum1.io.fracSum)
    norm1.io.sign := sign1
    io.output1 := norm1.io.fp16

    printf("%b %b\n", io.output0, io.output1)
}