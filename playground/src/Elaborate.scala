object Elaborate extends App {
  val firtoolOptions = Array(
    "--lowering-options=" + List(
      // make yosys happy
      // see https://github.com/llvm/circt/blob/main/docs/VerilogGeneration.md
      "disallowLocalVariables",
      "disallowPackedArrays",
      "locationInfoStyle=wrapInAtSquareBracket"
    ).reduce(_ + "," + _)
  )
  circt.stage.ChiselStage.emitSystemVerilogFile(new mac.Int4Fp16Mul(), args, firtoolOptions)
  // circt.stage.ChiselStage.emitSystemVerilogFile(new mac.Fp16Add(), args, firtoolOptions)
  // circt.stage.ChiselStage.emitSystemVerilogFile(new mac.Fp16Mul(), args, firtoolOptions)
  // circt.stage.ChiselStage.emitSystemVerilogFile(new mac.Systolic8x8Tile(), args, firtoolOptions)
}
