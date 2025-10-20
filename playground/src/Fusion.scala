package mac

import chisel3._
import chisel3.util._

class fracSum extends Module {
    val io = IO(new Bundle {
        val iAbs = Input(UInt(4.W))
        val frac = Input(UInt(10.W))
        val fracSum = Output(UInt(15.W))
        val expAdd = Output(UInt(2.W))
    })
    val frac = Cat(1.U(1.W), io.frac)
    val fracSum = (0 until 4).map { i =>
        Mux(io.iAbs(i).asBool, frac << i, 0.U(15.W))
    }.reduce(_ + _)
    // or can be written as:
    // val fracSum = Wire(UInt(15.W))
    // fracSum := io.frac * io.iAbs
    io.fracSum := fracSum
    
    val bound = MuxCase(0.U, Seq(
        (io.iAbs(3)) -> 3.U,
        (io.iAbs(2)) -> 2.U,
        (io.iAbs(1)) -> 1.U,
        (io.iAbs(0)) -> 0.U,
    ))
    io.expAdd := bound
}

class Norm extends Module {
    val io = IO(new Bundle {
        val originFp16 = Input(UInt(16.W))

        val fracSum = Input(UInt(19.W))
        val expAdd = Input(UInt(3.W))
        val sign = Input(Bool())

        val fp16 = Output(UInt(16.W))
    })
    val originExp = io.originFp16(14, 10)
    val exp = Wire(UInt(6.W)) // 6-bit: include overflow
    val fracOverflowIdx = Wire(UInt(5.W))
    fracOverflowIdx := io.expAdd +& 15.U
    exp := originExp + io.expAdd + io.fracSum(fracOverflowIdx)

    printf("%d %d\n", io.expAdd, io.fracSum(fracOverflowIdx))
    val finalFrac = MuxCase(0.U, Seq(
        io.fracSum(18) -> io.fracSum(17, 8),
        io.fracSum(17) -> io.fracSum(16, 7),
        io.fracSum(16) -> io.fracSum(15, 6),
        io.fracSum(15) -> io.fracSum(14, 5),
        io.fracSum(14) -> io.fracSum(13, 4),
        io.fracSum(13) -> io.fracSum(12, 3),
        io.fracSum(12) -> io.fracSum(11, 2),
        io.fracSum(11) -> io.fracSum(10, 1),
        io.fracSum(10) -> io.fracSum(9, 0)
    ))
    
    io.fp16 := Cat(io.sign, exp(4, 0), finalFrac)
}

class Fusion extends Module {
    val io = IO(new Bundle {
        val int8 = Input(UInt(8.W))
        val fp16 = Input(UInt(16.W))

        val fusion = Input(Bool())

        val output0 = Output(UInt(16.W))
        val output1 = Output(UInt(16.W))
    })
    val sign0 = io.int8(3) ^ io.fp16(15)
    val sign1 = io.int8(7) ^ io.fp16(15)

    // separate
    val iAbs0 = Mux(sign0, ~io.int8(3, 0) + 1.U, io.int8(3, 0))
    val iAbs1 = Mux(sign1, ~io.int8(7, 4) + 1.U, io.int8(7, 4))
    // fusion
    val iAbsFull = Mux(sign1, ~io.int8 + 1.U, io.int8)

    val fracSum0 = Module(new fracSum())
    val fracSum1 = Module(new fracSum())
    fracSum0.io.iAbs := Mux(io.fusion, iAbsFull(3, 0), iAbs0)
    fracSum0.io.frac := io.fp16(9, 0)
    fracSum1.io.iAbs := Mux(io.fusion, iAbsFull(7, 4), iAbs1)
    fracSum1.io.frac := io.fp16(9, 0)

    val fusionFracSum = Wire(UInt(19.W))
    fusionFracSum := (fracSum1.io.fracSum << 4) + fracSum0.io.fracSum

    val fusionExpAdd = Wire(UInt(3.W))
    fusionExpAdd := fracSum0.io.expAdd + 4.U

    val norm0 = Module(new Norm())
    val norm1 = Module(new Norm())
    norm0.io.originFp16 := io.fp16
    norm0.io.fracSum := fracSum0.io.fracSum << 4
    norm0.io.expAdd := fracSum0.io.expAdd
    norm0.io.sign := sign0
    io.output0 := norm0.io.fp16

    norm1.io.originFp16 := io.fp16
    norm1.io.fracSum := Mux(io.fusion, fusionFracSum, fracSum1.io.fracSum << 4)
    norm1.io.expAdd := Mux(io.fusion, fusionExpAdd, fracSum1.io.expAdd)
    norm1.io.sign := sign1
    io.output1 := norm1.io.fp16

    printf("%b %b\n", io.output0, io.output1)
}