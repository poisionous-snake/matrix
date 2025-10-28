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
  chisel3.Driver.execute(Array("--target-dir", "./build"), () => new mac.InnerProduct())
  chisel3.Driver.execute(Array("--target-dir", "./build"), () => new exp_unit.ExpUnitFixPoint(16, 10, 8, 4))
}
