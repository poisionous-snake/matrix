package mac

import chisel3._
import chisel3.util._

class Int4ToFp16 extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))   // -8 .. +7
    val out = Output(UInt(16.W)) // IEEE-754 half
  })

  io.out := MuxLookup(io.in, 0.U)( 
    Seq(
      8.U  -> 0xC800.U, // -8
      9.U  -> 0xC700.U, // -7
      10.U -> 0xC600.U, // -6
      11.U -> 0xC500.U, // -5
      12.U -> 0xC400.U, // -4
      13.U -> 0xC340.U, // -3
      14.U -> 0xC200.U, // -2
      15.U -> 0xBC00.U, // -1
      0.U  -> 0x0000.U,
      1.U  -> 0x3C00.U,
      2.U  -> 0x4000.U,
      3.U  -> 0x4200.U,
      4.U  -> 0x4400.U,
      5.U  -> 0x4500.U,
      6.U  -> 0x4600.U,
      7.U  -> 0x4700.U 
    )
  )
}