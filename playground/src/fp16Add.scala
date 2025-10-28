package mac

import chisel3._
import chisel3.util._

object countLeadingZeros
{
    def apply(in: UInt): UInt = PriorityEncoder(in.asBools.reverse)
}

class fp16Add extends Module {
    val io = IO(new Bundle{
        val a = Input(UInt(16.W))
        val b = Input(UInt(16.W))
        val out = Output(UInt(16.W))
    })
    val (a, b) = (io.a, io.b)

    val expDiff = Cat(0.U(1.W), a(14, 10)) + Cat(1.U(1.W), ~b(14, 10)) + 1.U(6.W)
    val manDiff = Cat(0.U(1.W), a(9, 0)) + Cat(1.U(1.W), ~b(9, 0)) + 1.U(11.W)

    val expDiffIsZero = !expDiff.orR
    val manDiffIsZero = !manDiff.orR 

    val bigSel = Mux(expDiffIsZero, manDiff(10), expDiff(5))

    val rawShiftRt = Mux(expDiff(5), (~expDiff(4, 0) + 1.U), expDiff(4, 0))
    val shiftRtAmt = Mux(rawShiftRt > 11.U, "b1011".U(4.W), rawShiftRt(3, 0))

    val operation = a(15) ^ b(15)
    
    val rawExp = Mux(bigSel, b(14, 10), a(14, 10))
    val signOut = Mux(bigSel, b(15), a(15))
    val bigMan = Cat(1.U(1.W), Mux(bigSel, b(9, 0), a(9, 0)))
    val lilMan = Cat(1.U(1.W), Mux(bigSel, a(9, 0), b(9, 0)))

    val shiftedMan = (lilMan >> shiftRtAmt)(10, 0)
    val guard = Mux(shiftRtAmt === 0.U || rawShiftRt > 11.U, 0.U(1.W), (lilMan >> shiftRtAmt - 1.U)(0))

    val mask = Wire(UInt(11.W))
    val casez_sel = Cat(shiftRtAmt, rawShiftRt > 11.U) // 5 bits
    mask := MuxCase(0.U, Seq(
        (casez_sel === "b00000".U) -> "b00000000000".U,
        (casez_sel === "b00010".U) -> "b00000000000".U,
        (casez_sel === "b00100".U) -> "b00000000001".U,
        (casez_sel === "b00110".U) -> "b00000000011".U,
        (casez_sel === "b01000".U) -> "b00000001111".U,
        (casez_sel === "b01010".U) -> "b00000001111".U,
        (casez_sel === "b01100".U) -> "b00000011111".U,
        (casez_sel === "b01110".U) -> "b00000111111".U,
        (casez_sel === "b10000".U) -> "b00001111111".U,
        (casez_sel === "b10010".U) -> "b00011111111".U,
        (casez_sel === "b10100".U) -> "b00111111111".U,
        (casez_sel === "b10110".U) -> "b01111111111".U,
        (casez_sel(0) === 1.U)   -> "b11111111111".U
    ))

    val sticky = (lilMan & mask).orR
    val alignedMan = Mux(operation, 
                        ~Cat(shiftedMan, guard, sticky), 
                         Cat(shiftedMan, guard, sticky)) // 11 + 1 + 1 bits
    // ////////////////////////////////////////////////////////////////////////////
    // Add Mantissas
    // ////////////////////////////////////////////////////////////////////////////
    val rawMan = (alignedMan + operation.asUInt) +& Cat(bigMan, 0.U(2.W))
    printf("alignedMan: %b, bigMan: %b, rawMan: %b\n", alignedMan, Cat(bigMan, 0.U(2.W)), rawMan)

    // In subtraction, we don’t want the carry-out, so we replace it with a zero
    val signedMan = Cat(rawMan(13) && !operation, rawMan(12, 0))

    // ////////////////////////////////////////////////////////////////////////////
    // Normalize / Package
    // ////////////////////////////////////////////////////////////////////////////

    // In normalization, we will either right-shift by 1, do nothing, or
    // left-shift by some variable amount. By biasing the normalization, we
    // either do nothing or we only left-shift.
    val normAmt = countLeadingZeros(signedMan)
    printf("normAmt: %b\n", normAmt)

    val biasExp = rawExp + 1.U // potential carry-out
    val biasMan = Cat(0.U(1.W), signedMan)
    val normExp = biasExp + (~Cat(0.U(2.W), normAmt) + 1.U)
    val expOut = normExp(4, 0)

    val normMan = (biasMan << normAmt)(14, 0)
    val manOut = normMan(12, 3)
    // Discard the guard/sticky bits (since we’re rounding down), discard
    // the two upper bits ( which are the overflow bit and the hidden 1), and
    // discard the bit just above the guard/sticky bits , which was added in when
    // we biased the mantissa.

    // Calculated output
    val numOut = Cat(expOut, manOut)

    // Input exception signals
    val expAIsOne = a(14, 10).andR
    val expBIsOne = b(14, 10).andR
    val expAIsZero = !a(14, 10).orR
    val expBIsZero = !b(14, 10).orR
    val manAIsZero = !a(9, 0).orR
    val manBIsZero = !b(9, 0).orR
    val AIsNaN = expAIsOne && !manAIsZero
    val BIsNaN = expBIsOne && !manBIsZero
    val AIsInf = expAIsOne && manAIsZero
    val BIsInf = expBIsOne && manBIsZero
    val inIsNaN = AIsNaN || BIsNaN || (AIsInf && BIsInf && operation)
    val inIsInf = AIsInf || BIsInf
    val inIsDenorm = expAIsZero || expBIsZero
    val zero = expDiffIsZero && manDiffIsZero && operation

    // Output exception signals
    val expOutIsOne = expOut.andR
    val expOutIsZero = !expOut.orR
    val manOutIsZero = !manOut.orR
    val outIsInf = expOutIsOne && !normExp(5)
    val outIsDenorm = expOutIsZero || normExp(5)

    // Final exception signals
    val overflow = ( inIsInf | outIsInf ) & ~ zero ;
    val NaN = inIsNaN ;
    val underflow = inIsDenorm | outIsDenorm | zero ;

    // Choose output from exception signals
    io.out := Mux(NaN, "b0111_1111_1111_1111".U,
                    Mux(overflow, Cat(signOut, "b111_1100_0000_0000".U),
                                Mux(underflow, "b0000_0000_0000_0000".U,
                                            Cat(signOut, numOut))))
    printf("io.a: %b, io.b: %b, io.out: %b_%b_%b\n",io.a, io.b, signOut, expOut, manOut)
}