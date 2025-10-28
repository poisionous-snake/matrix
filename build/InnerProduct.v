module fracSum(
  input  [3:0]  io_iAbs,
  input  [9:0]  io_frac,
  output [14:0] io_fracSum
);
  wire [10:0] frac = {1'h1,io_frac}; // @[Cat.scala 30:58]
  wire [14:0] _fracSum_T_3 = io_iAbs[0] ? {{4'd0}, frac} : 15'h0; // @[Fusion.scala 14:12]
  wire [11:0] _fracSum_T_6 = {frac, 1'h0}; // @[Fusion.scala 14:37]
  wire [14:0] _fracSum_T_7 = io_iAbs[1] ? {{3'd0}, _fracSum_T_6} : 15'h0; // @[Fusion.scala 14:12]
  wire [12:0] _fracSum_T_10 = {frac, 2'h0}; // @[Fusion.scala 14:37]
  wire [14:0] _fracSum_T_11 = io_iAbs[2] ? {{2'd0}, _fracSum_T_10} : 15'h0; // @[Fusion.scala 14:12]
  wire [13:0] _fracSum_T_14 = {frac, 3'h0}; // @[Fusion.scala 14:37]
  wire [14:0] _fracSum_T_15 = io_iAbs[3] ? {{1'd0}, _fracSum_T_14} : 15'h0; // @[Fusion.scala 14:12]
  wire [14:0] _fracSum_T_17 = _fracSum_T_3 + _fracSum_T_7; // @[Fusion.scala 15:16]
  wire [14:0] _fracSum_T_19 = _fracSum_T_17 + _fracSum_T_11; // @[Fusion.scala 15:16]
  assign io_fracSum = _fracSum_T_19 + _fracSum_T_15; // @[Fusion.scala 15:16]
endmodule
module Norm(
  input  [15:0] io_originFp16,
  input  [18:0] io_fracSum,
  input         io_sign,
  output [15:0] io_fp16
);
  wire [4:0] originExp = io_originFp16[14:10]; // @[Fusion.scala 31:34]
  wire [9:0] finalFrac_hi_hi = io_fracSum[17:8]; // @[Fusion.scala 35:35]
  wire  finalFrac_hi_lo = io_fracSum[7]; // @[Fusion.scala 35:51]
  wire  finalFrac_lo_hi = io_fracSum[6]; // @[Fusion.scala 35:63]
  wire  finalFrac_lo_lo = |io_fracSum[5:0]; // @[Fusion.scala 35:82]
  wire [12:0] _finalFrac_T_2 = {finalFrac_hi_hi,finalFrac_hi_lo,finalFrac_lo_hi,finalFrac_lo_lo}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_1 = io_fracSum[16:7]; // @[Fusion.scala 36:35]
  wire  finalFrac_lo_hi_1 = io_fracSum[5]; // @[Fusion.scala 36:63]
  wire  finalFrac_lo_lo_1 = |io_fracSum[4:0]; // @[Fusion.scala 36:82]
  wire [12:0] _finalFrac_T_5 = {finalFrac_hi_hi_1,finalFrac_lo_hi,finalFrac_lo_hi_1,finalFrac_lo_lo_1}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_2 = io_fracSum[15:6]; // @[Fusion.scala 37:35]
  wire  finalFrac_lo_hi_2 = io_fracSum[4]; // @[Fusion.scala 37:63]
  wire  finalFrac_lo_lo_2 = |io_fracSum[3:0]; // @[Fusion.scala 37:82]
  wire [12:0] _finalFrac_T_8 = {finalFrac_hi_hi_2,finalFrac_lo_hi_1,finalFrac_lo_hi_2,finalFrac_lo_lo_2}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_3 = io_fracSum[14:5]; // @[Fusion.scala 38:35]
  wire  finalFrac_lo_hi_3 = io_fracSum[3]; // @[Fusion.scala 38:63]
  wire  finalFrac_lo_lo_3 = |io_fracSum[2:0]; // @[Fusion.scala 38:82]
  wire [12:0] _finalFrac_T_11 = {finalFrac_hi_hi_3,finalFrac_lo_hi_2,finalFrac_lo_hi_3,finalFrac_lo_lo_3}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_4 = io_fracSum[13:4]; // @[Fusion.scala 39:35]
  wire  finalFrac_lo_hi_4 = io_fracSum[2]; // @[Fusion.scala 39:63]
  wire  finalFrac_lo_lo_4 = |io_fracSum[1:0]; // @[Fusion.scala 39:82]
  wire [12:0] _finalFrac_T_14 = {finalFrac_hi_hi_4,finalFrac_lo_hi_3,finalFrac_lo_hi_4,finalFrac_lo_lo_4}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_5 = io_fracSum[12:3]; // @[Fusion.scala 40:35]
  wire  finalFrac_lo_hi_5 = io_fracSum[1]; // @[Fusion.scala 40:63]
  wire  finalFrac_lo_lo_5 = io_fracSum[0]; // @[Fusion.scala 40:75]
  wire [12:0] _finalFrac_T_16 = {finalFrac_hi_hi_5,finalFrac_lo_hi_4,finalFrac_lo_hi_5,finalFrac_lo_lo_5}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_6 = io_fracSum[11:2]; // @[Fusion.scala 41:35]
  wire [12:0] _finalFrac_T_18 = {finalFrac_hi_hi_6,finalFrac_lo_hi_5,finalFrac_lo_lo_5,1'h0}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_hi_7 = io_fracSum[10:1]; // @[Fusion.scala 42:35]
  wire [12:0] _finalFrac_T_20 = {finalFrac_hi_hi_7,finalFrac_lo_lo_5,2'h0}; // @[Cat.scala 30:58]
  wire [9:0] finalFrac_hi_8 = io_fracSum[9:0]; // @[Fusion.scala 43:35]
  wire [12:0] _finalFrac_T_22 = {finalFrac_hi_8,3'h0}; // @[Cat.scala 30:58]
  wire [12:0] _finalFrac_T_23 = io_fracSum[10] ? _finalFrac_T_22 : 13'h0; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_24 = io_fracSum[11] ? _finalFrac_T_20 : _finalFrac_T_23; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_25 = io_fracSum[12] ? _finalFrac_T_18 : _finalFrac_T_24; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_26 = io_fracSum[13] ? _finalFrac_T_16 : _finalFrac_T_25; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_27 = io_fracSum[14] ? _finalFrac_T_14 : _finalFrac_T_26; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_28 = io_fracSum[15] ? _finalFrac_T_11 : _finalFrac_T_27; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_29 = io_fracSum[16] ? _finalFrac_T_8 : _finalFrac_T_28; // @[Mux.scala 98:16]
  wire [12:0] _finalFrac_T_30 = io_fracSum[17] ? _finalFrac_T_5 : _finalFrac_T_29; // @[Mux.scala 98:16]
  wire [12:0] finalFrac = io_fracSum[18] ? _finalFrac_T_2 : _finalFrac_T_30; // @[Mux.scala 98:16]
  wire  lsb = finalFrac[3]; // @[Fusion.scala 46:24]
  wire  guard = finalFrac[2]; // @[Fusion.scala 47:26]
  wire  round = finalFrac[1]; // @[Fusion.scala 48:26]
  wire  sticky = finalFrac[0]; // @[Fusion.scala 49:27]
  wire  roundUp = guard & (round | sticky | lsb); // @[Fusion.scala 51:25]
  wire [9:0] _GEN_0 = {{9'd0}, roundUp}; // @[Fusion.scala 52:41]
  wire [10:0] roundedFrac = finalFrac[12:3] + _GEN_0; // @[Fusion.scala 52:41]
  wire  expAdjust = roundedFrac[10]; // @[Fusion.scala 53:35]
  wire [9:0] normFrac = expAdjust ? roundedFrac[10:1] : roundedFrac[9:0]; // @[Fusion.scala 54:23]
  wire [1:0] _expAdd_T_11 = io_fracSum[12] ? 2'h2 : {{1'd0}, io_fracSum[11]}; // @[Mux.scala 98:16]
  wire [1:0] _expAdd_T_12 = io_fracSum[13] ? 2'h3 : _expAdd_T_11; // @[Mux.scala 98:16]
  wire [2:0] _expAdd_T_13 = io_fracSum[14] ? 3'h4 : {{1'd0}, _expAdd_T_12}; // @[Mux.scala 98:16]
  wire [2:0] _expAdd_T_14 = io_fracSum[15] ? 3'h5 : _expAdd_T_13; // @[Mux.scala 98:16]
  wire [2:0] _expAdd_T_15 = io_fracSum[16] ? 3'h6 : _expAdd_T_14; // @[Mux.scala 98:16]
  wire [2:0] _expAdd_T_16 = io_fracSum[17] ? 3'h7 : _expAdd_T_15; // @[Mux.scala 98:16]
  wire [3:0] _expAdd_T_17 = io_fracSum[18] ? 4'h8 : {{1'd0}, _expAdd_T_16}; // @[Mux.scala 98:16]
  wire [3:0] _GEN_1 = {{3'd0}, expAdjust}; // @[Fusion.scala 68:8]
  wire [3:0] expAdd = _expAdd_T_17 + _GEN_1; // @[Fusion.scala 68:8]
  wire [4:0] _GEN_2 = {{1'd0}, expAdd}; // @[Fusion.scala 70:22]
  wire [5:0] exp = originExp + _GEN_2; // @[Fusion.scala 70:22]
  wire [4:0] io_fp16_hi_lo = exp[4:0]; // @[Fusion.scala 72:32]
  wire [5:0] io_fp16_hi = {io_sign,io_fp16_hi_lo}; // @[Cat.scala 30:58]
  assign io_fp16 = {io_fp16_hi,normFrac}; // @[Cat.scala 30:58]
endmodule
module Fusion(
  input         clock,
  input         reset,
  input  [7:0]  io_int8,
  input  [15:0] io_fp16_0,
  input  [15:0] io_fp16_1,
  input         io_fusion,
  output [15:0] io_output0,
  output [15:0] io_output1
);
  wire [3:0] fracSum0_io_iAbs; // @[Fusion.scala 94:26]
  wire [9:0] fracSum0_io_frac; // @[Fusion.scala 94:26]
  wire [14:0] fracSum0_io_fracSum; // @[Fusion.scala 94:26]
  wire [3:0] fracSum1_io_iAbs; // @[Fusion.scala 95:26]
  wire [9:0] fracSum1_io_frac; // @[Fusion.scala 95:26]
  wire [14:0] fracSum1_io_fracSum; // @[Fusion.scala 95:26]
  wire [15:0] norm0_io_originFp16; // @[Fusion.scala 104:23]
  wire [18:0] norm0_io_fracSum; // @[Fusion.scala 104:23]
  wire  norm0_io_sign; // @[Fusion.scala 104:23]
  wire [15:0] norm0_io_fp16; // @[Fusion.scala 104:23]
  wire [15:0] norm1_io_originFp16; // @[Fusion.scala 105:23]
  wire [18:0] norm1_io_fracSum; // @[Fusion.scala 105:23]
  wire  norm1_io_sign; // @[Fusion.scala 105:23]
  wire [15:0] norm1_io_fp16; // @[Fusion.scala 105:23]
  wire  sign0 = io_int8[3] ^ io_fp16_0[15]; // @[Fusion.scala 85:28]
  wire  sign1 = io_int8[7] ^ io_fp16_1[15]; // @[Fusion.scala 86:28]
  wire [3:0] _iAbs0_T_1 = ~io_int8[3:0]; // @[Fusion.scala 89:28]
  wire [3:0] _iAbs0_T_3 = _iAbs0_T_1 + 4'h1; // @[Fusion.scala 89:43]
  wire [3:0] iAbs0 = sign0 ? _iAbs0_T_3 : io_int8[3:0]; // @[Fusion.scala 89:20]
  wire [3:0] _iAbs1_T_1 = ~io_int8[7:4]; // @[Fusion.scala 90:28]
  wire [3:0] _iAbs1_T_3 = _iAbs1_T_1 + 4'h1; // @[Fusion.scala 90:43]
  wire [7:0] _iAbsFull_T = ~io_int8; // @[Fusion.scala 92:31]
  wire [7:0] _iAbsFull_T_2 = _iAbsFull_T + 8'h1; // @[Fusion.scala 92:40]
  wire [7:0] iAbsFull = sign1 ? _iAbsFull_T_2 : io_int8; // @[Fusion.scala 92:23]
  wire [18:0] _fusionFracSum_T = {fracSum1_io_fracSum, 4'h0}; // @[Fusion.scala 102:43]
  wire [18:0] _GEN_0 = {{4'd0}, fracSum0_io_fracSum}; // @[Fusion.scala 102:49]
  wire [19:0] _fusionFracSum_T_1 = _fusionFracSum_T + _GEN_0; // @[Fusion.scala 102:49]
  wire [18:0] fusionFracSum = _fusionFracSum_T_1[18:0]; // @[Fusion.scala 101:29 Fusion.scala 102:19]
  fracSum fracSum0 ( // @[Fusion.scala 94:26]
    .io_iAbs(fracSum0_io_iAbs),
    .io_frac(fracSum0_io_frac),
    .io_fracSum(fracSum0_io_fracSum)
  );
  fracSum fracSum1 ( // @[Fusion.scala 95:26]
    .io_iAbs(fracSum1_io_iAbs),
    .io_frac(fracSum1_io_frac),
    .io_fracSum(fracSum1_io_fracSum)
  );
  Norm norm0 ( // @[Fusion.scala 104:23]
    .io_originFp16(norm0_io_originFp16),
    .io_fracSum(norm0_io_fracSum),
    .io_sign(norm0_io_sign),
    .io_fp16(norm0_io_fp16)
  );
  Norm norm1 ( // @[Fusion.scala 105:23]
    .io_originFp16(norm1_io_originFp16),
    .io_fracSum(norm1_io_fracSum),
    .io_sign(norm1_io_sign),
    .io_fp16(norm1_io_fp16)
  );
  assign io_output0 = norm0_io_fp16; // @[Fusion.scala 109:16]
  assign io_output1 = norm1_io_fp16; // @[Fusion.scala 114:16]
  assign fracSum0_io_iAbs = io_fusion ? iAbsFull[3:0] : iAbs0; // @[Fusion.scala 96:28]
  assign fracSum0_io_frac = io_fp16_0[9:0]; // @[Fusion.scala 97:35]
  assign fracSum1_io_iAbs = sign1 ? _iAbs1_T_3 : io_int8[7:4]; // @[Fusion.scala 90:20]
  assign fracSum1_io_frac = io_fp16_1[9:0]; // @[Fusion.scala 99:35]
  assign norm0_io_originFp16 = io_fp16_0; // @[Fusion.scala 106:25]
  assign norm0_io_fracSum = {{4'd0}, fracSum0_io_fracSum}; // @[Fusion.scala 107:22]
  assign norm0_io_sign = io_int8[3] ^ io_fp16_0[15]; // @[Fusion.scala 85:28]
  assign norm1_io_originFp16 = io_fp16_1; // @[Fusion.scala 111:25]
  assign norm1_io_fracSum = io_fusion ? fusionFracSum : {{4'd0}, fracSum1_io_fracSum}; // @[Fusion.scala 112:28]
  assign norm1_io_sign = io_int8[7] ^ io_fp16_1[15]; // @[Fusion.scala 86:28]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"%b %b\n",io_output0,io_output1); // @[Fusion.scala 116:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module fp16Add(
  input         clock,
  input         reset,
  input  [15:0] io_a,
  input  [15:0] io_b,
  output [15:0] io_out
);
  wire [4:0] expDiff_lo = io_a[14:10]; // @[fp16Add.scala 19:34]
  wire [5:0] _expDiff_T = {1'h0,expDiff_lo}; // @[Cat.scala 30:58]
  wire [4:0] expDiff_lo_1 = ~io_b[14:10]; // @[fp16Add.scala 19:60]
  wire [5:0] _expDiff_T_2 = {1'h1,expDiff_lo_1}; // @[Cat.scala 30:58]
  wire [5:0] _expDiff_T_4 = _expDiff_T + _expDiff_T_2; // @[fp16Add.scala 19:44]
  wire [5:0] expDiff = _expDiff_T_4 + 6'h1; // @[fp16Add.scala 19:72]
  wire [9:0] manDiff_lo = io_a[9:0]; // @[fp16Add.scala 20:34]
  wire [10:0] _manDiff_T = {1'h0,manDiff_lo}; // @[Cat.scala 30:58]
  wire [9:0] manDiff_lo_1 = ~io_b[9:0]; // @[fp16Add.scala 20:58]
  wire [10:0] _manDiff_T_2 = {1'h1,manDiff_lo_1}; // @[Cat.scala 30:58]
  wire [10:0] _manDiff_T_4 = _manDiff_T + _manDiff_T_2; // @[fp16Add.scala 20:42]
  wire [10:0] manDiff = _manDiff_T_4 + 11'h1; // @[fp16Add.scala 20:68]
  wire  expDiffIsZero = ~(|expDiff); // @[fp16Add.scala 22:25]
  wire  manDiffIsZero = ~(|manDiff); // @[fp16Add.scala 23:25]
  wire  bigSel = expDiffIsZero ? manDiff[10] : expDiff[5]; // @[fp16Add.scala 25:21]
  wire [4:0] _rawShiftRt_T_2 = ~expDiff[4:0]; // @[fp16Add.scala 27:39]
  wire [4:0] _rawShiftRt_T_4 = _rawShiftRt_T_2 + 5'h1; // @[fp16Add.scala 27:54]
  wire [4:0] rawShiftRt = expDiff[5] ? _rawShiftRt_T_4 : expDiff[4:0]; // @[fp16Add.scala 27:25]
  wire  _shiftRtAmt_T = rawShiftRt > 5'hb; // @[fp16Add.scala 28:37]
  wire [3:0] shiftRtAmt = rawShiftRt > 5'hb ? 4'hb : rawShiftRt[3:0]; // @[fp16Add.scala 28:25]
  wire  operation = io_a[15] ^ io_b[15]; // @[fp16Add.scala 30:27]
  wire [4:0] rawExp = bigSel ? io_b[14:10] : expDiff_lo; // @[fp16Add.scala 32:21]
  wire  signOut = bigSel ? io_b[15] : io_a[15]; // @[fp16Add.scala 33:22]
  wire [9:0] bigMan_lo = bigSel ? io_b[9:0] : manDiff_lo; // @[fp16Add.scala 34:35]
  wire [9:0] lilMan_lo = bigSel ? manDiff_lo : io_b[9:0]; // @[fp16Add.scala 35:35]
  wire [10:0] lilMan = {1'h1,lilMan_lo}; // @[Cat.scala 30:58]
  wire [10:0] shiftedMan = lilMan >> shiftRtAmt; // @[fp16Add.scala 37:30]
  wire [3:0] _guard_T_4 = shiftRtAmt - 4'h1; // @[fp16Add.scala 38:94]
  wire [10:0] _guard_T_5 = lilMan >> _guard_T_4; // @[fp16Add.scala 38:80]
  wire  guard = shiftRtAmt == 4'h0 | _shiftRtAmt_T ? 1'h0 : _guard_T_5[0]; // @[fp16Add.scala 38:20]
  wire [4:0] casez_sel = {shiftRtAmt,_shiftRtAmt_T}; // @[Cat.scala 30:58]
  wire  _mask_T = casez_sel == 5'h0; // @[fp16Add.scala 43:20]
  wire  _mask_T_1 = casez_sel == 5'h2; // @[fp16Add.scala 44:20]
  wire  _mask_T_2 = casez_sel == 5'h4; // @[fp16Add.scala 45:20]
  wire  _mask_T_3 = casez_sel == 5'h6; // @[fp16Add.scala 46:20]
  wire  _mask_T_4 = casez_sel == 5'h8; // @[fp16Add.scala 47:20]
  wire  _mask_T_5 = casez_sel == 5'ha; // @[fp16Add.scala 48:20]
  wire  _mask_T_6 = casez_sel == 5'hc; // @[fp16Add.scala 49:20]
  wire  _mask_T_7 = casez_sel == 5'he; // @[fp16Add.scala 50:20]
  wire  _mask_T_8 = casez_sel == 5'h10; // @[fp16Add.scala 51:20]
  wire  _mask_T_9 = casez_sel == 5'h12; // @[fp16Add.scala 52:20]
  wire  _mask_T_10 = casez_sel == 5'h14; // @[fp16Add.scala 53:20]
  wire  _mask_T_11 = casez_sel == 5'h16; // @[fp16Add.scala 54:20]
  wire [10:0] _mask_T_14 = casez_sel[0] ? 11'h7ff : 11'h0; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_15 = _mask_T_11 ? 11'h3ff : _mask_T_14; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_16 = _mask_T_10 ? 11'h1ff : _mask_T_15; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_17 = _mask_T_9 ? 11'hff : _mask_T_16; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_18 = _mask_T_8 ? 11'h7f : _mask_T_17; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_19 = _mask_T_7 ? 11'h3f : _mask_T_18; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_20 = _mask_T_6 ? 11'h1f : _mask_T_19; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_21 = _mask_T_5 ? 11'hf : _mask_T_20; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_22 = _mask_T_4 ? 11'hf : _mask_T_21; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_23 = _mask_T_3 ? 11'h3 : _mask_T_22; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_24 = _mask_T_2 ? 11'h1 : _mask_T_23; // @[Mux.scala 98:16]
  wire [10:0] _mask_T_25 = _mask_T_1 ? 11'h0 : _mask_T_24; // @[Mux.scala 98:16]
  wire [10:0] mask = _mask_T ? 11'h0 : _mask_T_25; // @[Mux.scala 98:16]
  wire [10:0] _sticky_T = lilMan & mask; // @[fp16Add.scala 58:26]
  wire  sticky = |_sticky_T; // @[fp16Add.scala 58:34]
  wire [12:0] _alignedMan_T = {shiftedMan,guard,sticky}; // @[Cat.scala 30:58]
  wire [12:0] _alignedMan_T_1 = ~_alignedMan_T; // @[fp16Add.scala 60:25]
  wire [12:0] alignedMan = operation ? _alignedMan_T_1 : _alignedMan_T; // @[fp16Add.scala 59:25]
  wire [12:0] _GEN_0 = {{12'd0}, operation}; // @[fp16Add.scala 65:30]
  wire [12:0] _rawMan_T_1 = alignedMan + _GEN_0; // @[fp16Add.scala 65:30]
  wire [12:0] _rawMan_T_2 = {1'h1,bigMan_lo,2'h0}; // @[Cat.scala 30:58]
  wire [13:0] rawMan = _rawMan_T_1 + _rawMan_T_2; // @[fp16Add.scala 65:50]
  wire  _T_2 = ~reset; // @[fp16Add.scala 66:11]
  wire  signedMan_hi = rawMan[13] & ~operation; // @[fp16Add.scala 69:36]
  wire [12:0] signedMan_lo = rawMan[12:0]; // @[fp16Add.scala 69:57]
  wire [13:0] signedMan = {signedMan_hi,signedMan_lo}; // @[Cat.scala 30:58]
  wire [3:0] _normAmt_T_14 = signedMan[1] ? 4'hc : 4'hd; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_15 = signedMan[2] ? 4'hb : _normAmt_T_14; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_16 = signedMan[3] ? 4'ha : _normAmt_T_15; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_17 = signedMan[4] ? 4'h9 : _normAmt_T_16; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_18 = signedMan[5] ? 4'h8 : _normAmt_T_17; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_19 = signedMan[6] ? 4'h7 : _normAmt_T_18; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_20 = signedMan[7] ? 4'h6 : _normAmt_T_19; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_21 = signedMan[8] ? 4'h5 : _normAmt_T_20; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_22 = signedMan[9] ? 4'h4 : _normAmt_T_21; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_23 = signedMan[10] ? 4'h3 : _normAmt_T_22; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_24 = signedMan[11] ? 4'h2 : _normAmt_T_23; // @[Mux.scala 47:69]
  wire [3:0] _normAmt_T_25 = signedMan[12] ? 4'h1 : _normAmt_T_24; // @[Mux.scala 47:69]
  wire [3:0] normAmt = signedMan[13] ? 4'h0 : _normAmt_T_25; // @[Mux.scala 47:69]
  wire [4:0] biasExp = rawExp + 5'h1; // @[fp16Add.scala 81:26]
  wire [14:0] biasMan = {1'h0,signedMan_hi,signedMan_lo}; // @[Cat.scala 30:58]
  wire [5:0] _normExp_T = {2'h0,normAmt}; // @[Cat.scala 30:58]
  wire [5:0] _normExp_T_1 = ~_normExp_T; // @[fp16Add.scala 83:30]
  wire [5:0] _normExp_T_3 = _normExp_T_1 + 6'h1; // @[fp16Add.scala 83:54]
  wire [5:0] _GEN_1 = {{1'd0}, biasExp}; // @[fp16Add.scala 83:27]
  wire [5:0] normExp = _GEN_1 + _normExp_T_3; // @[fp16Add.scala 83:27]
  wire [4:0] expOut = normExp[4:0]; // @[fp16Add.scala 84:25]
  wire [29:0] _GEN_2 = {{15'd0}, biasMan}; // @[fp16Add.scala 86:28]
  wire [29:0] _normMan_T = _GEN_2 << normAmt; // @[fp16Add.scala 86:28]
  wire [14:0] normMan = _normMan_T[14:0]; // @[fp16Add.scala 86:39]
  wire [9:0] manOut = normMan[12:3]; // @[fp16Add.scala 87:25]
  wire  expAIsOne = &expDiff_lo; // @[fp16Add.scala 97:31]
  wire  expBIsOne = &io_b[14:10]; // @[fp16Add.scala 98:31]
  wire  expAIsZero = ~(|expDiff_lo); // @[fp16Add.scala 99:22]
  wire  expBIsZero = ~(|io_b[14:10]); // @[fp16Add.scala 100:22]
  wire  manAIsZero = ~(|manDiff_lo); // @[fp16Add.scala 101:22]
  wire  manBIsZero = ~(|io_b[9:0]); // @[fp16Add.scala 102:22]
  wire  AIsNaN = expAIsOne & ~manAIsZero; // @[fp16Add.scala 103:28]
  wire  BIsNaN = expBIsOne & ~manBIsZero; // @[fp16Add.scala 104:28]
  wire  AIsInf = expAIsOne & manAIsZero; // @[fp16Add.scala 105:28]
  wire  BIsInf = expBIsOne & manBIsZero; // @[fp16Add.scala 106:28]
  wire  NaN = AIsNaN | BIsNaN | AIsInf & BIsInf & operation; // @[fp16Add.scala 107:36]
  wire  inIsInf = AIsInf | BIsInf; // @[fp16Add.scala 108:26]
  wire  inIsDenorm = expAIsZero | expBIsZero; // @[fp16Add.scala 109:33]
  wire  zero = expDiffIsZero & manDiffIsZero & operation; // @[fp16Add.scala 110:47]
  wire  expOutIsOne = &expOut; // @[fp16Add.scala 113:30]
  wire  expOutIsZero = ~(|expOut); // @[fp16Add.scala 114:24]
  wire  outIsInf = expOutIsOne & ~normExp[5]; // @[fp16Add.scala 116:32]
  wire  outIsDenorm = expOutIsZero | normExp[5]; // @[fp16Add.scala 117:36]
  wire  overflow = (inIsInf | outIsInf) & ~zero; // @[fp16Add.scala 120:43]
  wire  underflow = inIsDenorm | outIsDenorm | zero; // @[fp16Add.scala 122:46]
  wire [15:0] _io_out_T = {signOut,15'h7c00}; // @[Cat.scala 30:58]
  wire [15:0] _io_out_T_1 = {signOut,expOut,manOut}; // @[Cat.scala 30:58]
  wire [15:0] _io_out_T_2 = underflow ? 16'h0 : _io_out_T_1; // @[fp16Add.scala 127:36]
  wire [15:0] _io_out_T_3 = overflow ? _io_out_T : _io_out_T_2; // @[fp16Add.scala 126:24]
  assign io_out = NaN ? 16'h7fff : _io_out_T_3; // @[fp16Add.scala 125:18]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"alignedMan: %b, bigMan: %b, rawMan: %b\n",alignedMan,_rawMan_T_2,rawMan); // @[fp16Add.scala 66:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"normAmt: %b\n",normAmt); // @[fp16Add.scala 79:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2) begin
          $fwrite(32'h80000002,"io.a: %b, io.b: %b, io.out: %b_%b_%b\n",io_a,io_b,signOut,expOut,manOut); // @[fp16Add.scala 129:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module InnerProduct(
  input         clock,
  input         reset,
  input  [7:0]  io_int_0,
  input  [7:0]  io_int_1,
  input  [7:0]  io_int_2,
  input  [7:0]  io_int_3,
  input  [7:0]  io_int_4,
  input  [7:0]  io_int_5,
  input  [7:0]  io_int_6,
  input  [7:0]  io_int_7,
  input  [7:0]  io_int_8,
  input  [7:0]  io_int_9,
  input  [7:0]  io_int_10,
  input  [7:0]  io_int_11,
  input  [7:0]  io_int_12,
  input  [7:0]  io_int_13,
  input  [7:0]  io_int_14,
  input  [7:0]  io_int_15,
  input  [15:0] io_fp_0,
  input  [15:0] io_fp_1,
  input  [15:0] io_fp_2,
  input  [15:0] io_fp_3,
  input  [15:0] io_fp_4,
  input  [15:0] io_fp_5,
  input  [15:0] io_fp_6,
  input  [15:0] io_fp_7,
  input  [15:0] io_fp_8,
  input  [15:0] io_fp_9,
  input  [15:0] io_fp_10,
  input  [15:0] io_fp_11,
  input  [15:0] io_fp_12,
  input  [15:0] io_fp_13,
  input  [15:0] io_fp_14,
  input  [15:0] io_fp_15,
  input  [15:0] io_fp_16,
  input  [15:0] io_fp_17,
  input  [15:0] io_fp_18,
  input  [15:0] io_fp_19,
  input  [15:0] io_fp_20,
  input  [15:0] io_fp_21,
  input  [15:0] io_fp_22,
  input  [15:0] io_fp_23,
  input  [15:0] io_fp_24,
  input  [15:0] io_fp_25,
  input  [15:0] io_fp_26,
  input  [15:0] io_fp_27,
  input  [15:0] io_fp_28,
  input  [15:0] io_fp_29,
  input  [15:0] io_fp_30,
  input  [15:0] io_fp_31,
  output [15:0] io_result,
  input         io_fusion
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
`endif // RANDOMIZE_REG_INIT
  wire  fusionArray_0_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_0_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_0_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_0_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_0_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_0_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_0_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_0_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_1_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_1_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_1_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_1_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_1_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_1_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_1_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_1_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_2_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_2_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_2_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_2_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_2_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_2_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_2_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_2_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_3_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_3_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_3_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_3_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_3_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_3_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_3_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_3_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_4_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_4_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_4_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_4_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_4_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_4_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_4_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_4_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_5_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_5_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_5_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_5_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_5_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_5_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_5_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_5_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_6_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_6_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_6_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_6_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_6_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_6_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_6_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_6_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_7_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_7_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_7_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_7_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_7_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_7_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_7_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_7_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_8_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_8_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_8_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_8_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_8_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_8_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_8_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_8_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_9_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_9_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_9_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_9_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_9_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_9_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_9_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_9_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_10_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_10_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_10_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_10_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_10_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_10_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_10_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_10_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_11_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_11_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_11_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_11_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_11_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_11_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_11_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_11_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_12_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_12_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_12_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_12_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_12_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_12_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_12_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_12_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_13_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_13_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_13_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_13_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_13_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_13_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_13_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_13_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_14_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_14_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_14_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_14_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_14_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_14_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_14_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_14_io_output1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_15_clock; // @[InnerProduct.scala 13:46]
  wire  fusionArray_15_reset; // @[InnerProduct.scala 13:46]
  wire [7:0] fusionArray_15_io_int8; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_15_io_fp16_0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_15_io_fp16_1; // @[InnerProduct.scala 13:46]
  wire  fusionArray_15_io_fusion; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_15_io_output0; // @[InnerProduct.scala 13:46]
  wire [15:0] fusionArray_15_io_output1; // @[InnerProduct.scala 13:46]
  wire  sum0_nextLevel_adder_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_1_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_1_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_1_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_1_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_1_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_2_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_2_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_2_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_2_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_2_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_3_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_3_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_3_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_3_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_3_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_4_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_4_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_4_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_4_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_4_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_5_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_5_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_5_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_5_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_5_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_6_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_6_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_6_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_6_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_6_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_1_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_1_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_1_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_1_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_1_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_7_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_7_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_7_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_7_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_7_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_8_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_8_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_8_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_8_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_8_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_9_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_9_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_9_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_9_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_9_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_2_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_2_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_2_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_2_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_2_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_10_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_adder_10_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_10_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_10_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_adder_10_io_out; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_3_clock; // @[InnerProduct.scala 31:39]
  wire  sum0_nextLevel_adder_3_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_3_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_3_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum0_nextLevel_adder_3_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_1_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_1_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_1_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_1_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_1_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_2_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_2_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_2_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_2_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_2_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_3_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_3_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_3_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_3_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_3_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_4_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_4_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_4_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_4_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_4_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_5_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_5_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_5_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_5_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_5_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_6_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_6_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_6_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_6_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_6_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_1_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_1_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_1_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_1_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_1_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_7_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_7_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_7_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_7_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_7_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_8_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_8_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_8_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_8_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_8_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_9_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_9_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_9_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_9_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_9_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_2_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_2_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_2_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_2_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_2_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_10_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_adder_10_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_10_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_10_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_adder_10_io_out; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_3_clock; // @[InnerProduct.scala 31:39]
  wire  sum1_nextLevel_adder_3_reset; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_3_io_a; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_3_io_b; // @[InnerProduct.scala 31:39]
  wire [15:0] sum1_nextLevel_adder_3_io_out; // @[InnerProduct.scala 31:39]
  wire  finalAdder_clock; // @[InnerProduct.scala 45:28]
  wire  finalAdder_reset; // @[InnerProduct.scala 45:28]
  wire [15:0] finalAdder_io_a; // @[InnerProduct.scala 45:28]
  wire [15:0] finalAdder_io_b; // @[InnerProduct.scala 45:28]
  wire [15:0] finalAdder_io_out; // @[InnerProduct.scala 45:28]
  reg [15:0] outputs0_0; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_1; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_2; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_3; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_4; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_5; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_6; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_7; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_8; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_9; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_10; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_11; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_12; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_13; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_14; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs0_15; // @[InnerProduct.scala 21:66]
  reg [15:0] outputs1_0; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_1; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_2; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_3; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_4; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_5; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_6; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_7; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_8; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_9; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_10; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_11; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_12; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_13; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_14; // @[InnerProduct.scala 22:66]
  reg [15:0] outputs1_15; // @[InnerProduct.scala 22:66]
  wire  _T_1 = ~reset; // @[InnerProduct.scala 24:11]
  reg [15:0] sum0_nextLevel_REG; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_1; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_2; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_3; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_4; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_5; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_6; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_nextLevel_REG_1; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_7; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_8; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_9; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_nextLevel_REG_2; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0_REG_10; // @[InnerProduct.scala 35:28]
  reg [15:0] sum0; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_nextLevel_REG; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_1; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_2; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_3; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_4; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_5; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_6; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_nextLevel_REG_1; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_7; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_8; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_9; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_nextLevel_REG_2; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1_REG_10; // @[InnerProduct.scala 35:28]
  reg [15:0] sum1; // @[InnerProduct.scala 35:28]
  reg [15:0] io_result_REG; // @[InnerProduct.scala 49:46]
  Fusion fusionArray_0 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_0_clock),
    .reset(fusionArray_0_reset),
    .io_int8(fusionArray_0_io_int8),
    .io_fp16_0(fusionArray_0_io_fp16_0),
    .io_fp16_1(fusionArray_0_io_fp16_1),
    .io_fusion(fusionArray_0_io_fusion),
    .io_output0(fusionArray_0_io_output0),
    .io_output1(fusionArray_0_io_output1)
  );
  Fusion fusionArray_1 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_1_clock),
    .reset(fusionArray_1_reset),
    .io_int8(fusionArray_1_io_int8),
    .io_fp16_0(fusionArray_1_io_fp16_0),
    .io_fp16_1(fusionArray_1_io_fp16_1),
    .io_fusion(fusionArray_1_io_fusion),
    .io_output0(fusionArray_1_io_output0),
    .io_output1(fusionArray_1_io_output1)
  );
  Fusion fusionArray_2 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_2_clock),
    .reset(fusionArray_2_reset),
    .io_int8(fusionArray_2_io_int8),
    .io_fp16_0(fusionArray_2_io_fp16_0),
    .io_fp16_1(fusionArray_2_io_fp16_1),
    .io_fusion(fusionArray_2_io_fusion),
    .io_output0(fusionArray_2_io_output0),
    .io_output1(fusionArray_2_io_output1)
  );
  Fusion fusionArray_3 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_3_clock),
    .reset(fusionArray_3_reset),
    .io_int8(fusionArray_3_io_int8),
    .io_fp16_0(fusionArray_3_io_fp16_0),
    .io_fp16_1(fusionArray_3_io_fp16_1),
    .io_fusion(fusionArray_3_io_fusion),
    .io_output0(fusionArray_3_io_output0),
    .io_output1(fusionArray_3_io_output1)
  );
  Fusion fusionArray_4 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_4_clock),
    .reset(fusionArray_4_reset),
    .io_int8(fusionArray_4_io_int8),
    .io_fp16_0(fusionArray_4_io_fp16_0),
    .io_fp16_1(fusionArray_4_io_fp16_1),
    .io_fusion(fusionArray_4_io_fusion),
    .io_output0(fusionArray_4_io_output0),
    .io_output1(fusionArray_4_io_output1)
  );
  Fusion fusionArray_5 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_5_clock),
    .reset(fusionArray_5_reset),
    .io_int8(fusionArray_5_io_int8),
    .io_fp16_0(fusionArray_5_io_fp16_0),
    .io_fp16_1(fusionArray_5_io_fp16_1),
    .io_fusion(fusionArray_5_io_fusion),
    .io_output0(fusionArray_5_io_output0),
    .io_output1(fusionArray_5_io_output1)
  );
  Fusion fusionArray_6 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_6_clock),
    .reset(fusionArray_6_reset),
    .io_int8(fusionArray_6_io_int8),
    .io_fp16_0(fusionArray_6_io_fp16_0),
    .io_fp16_1(fusionArray_6_io_fp16_1),
    .io_fusion(fusionArray_6_io_fusion),
    .io_output0(fusionArray_6_io_output0),
    .io_output1(fusionArray_6_io_output1)
  );
  Fusion fusionArray_7 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_7_clock),
    .reset(fusionArray_7_reset),
    .io_int8(fusionArray_7_io_int8),
    .io_fp16_0(fusionArray_7_io_fp16_0),
    .io_fp16_1(fusionArray_7_io_fp16_1),
    .io_fusion(fusionArray_7_io_fusion),
    .io_output0(fusionArray_7_io_output0),
    .io_output1(fusionArray_7_io_output1)
  );
  Fusion fusionArray_8 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_8_clock),
    .reset(fusionArray_8_reset),
    .io_int8(fusionArray_8_io_int8),
    .io_fp16_0(fusionArray_8_io_fp16_0),
    .io_fp16_1(fusionArray_8_io_fp16_1),
    .io_fusion(fusionArray_8_io_fusion),
    .io_output0(fusionArray_8_io_output0),
    .io_output1(fusionArray_8_io_output1)
  );
  Fusion fusionArray_9 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_9_clock),
    .reset(fusionArray_9_reset),
    .io_int8(fusionArray_9_io_int8),
    .io_fp16_0(fusionArray_9_io_fp16_0),
    .io_fp16_1(fusionArray_9_io_fp16_1),
    .io_fusion(fusionArray_9_io_fusion),
    .io_output0(fusionArray_9_io_output0),
    .io_output1(fusionArray_9_io_output1)
  );
  Fusion fusionArray_10 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_10_clock),
    .reset(fusionArray_10_reset),
    .io_int8(fusionArray_10_io_int8),
    .io_fp16_0(fusionArray_10_io_fp16_0),
    .io_fp16_1(fusionArray_10_io_fp16_1),
    .io_fusion(fusionArray_10_io_fusion),
    .io_output0(fusionArray_10_io_output0),
    .io_output1(fusionArray_10_io_output1)
  );
  Fusion fusionArray_11 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_11_clock),
    .reset(fusionArray_11_reset),
    .io_int8(fusionArray_11_io_int8),
    .io_fp16_0(fusionArray_11_io_fp16_0),
    .io_fp16_1(fusionArray_11_io_fp16_1),
    .io_fusion(fusionArray_11_io_fusion),
    .io_output0(fusionArray_11_io_output0),
    .io_output1(fusionArray_11_io_output1)
  );
  Fusion fusionArray_12 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_12_clock),
    .reset(fusionArray_12_reset),
    .io_int8(fusionArray_12_io_int8),
    .io_fp16_0(fusionArray_12_io_fp16_0),
    .io_fp16_1(fusionArray_12_io_fp16_1),
    .io_fusion(fusionArray_12_io_fusion),
    .io_output0(fusionArray_12_io_output0),
    .io_output1(fusionArray_12_io_output1)
  );
  Fusion fusionArray_13 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_13_clock),
    .reset(fusionArray_13_reset),
    .io_int8(fusionArray_13_io_int8),
    .io_fp16_0(fusionArray_13_io_fp16_0),
    .io_fp16_1(fusionArray_13_io_fp16_1),
    .io_fusion(fusionArray_13_io_fusion),
    .io_output0(fusionArray_13_io_output0),
    .io_output1(fusionArray_13_io_output1)
  );
  Fusion fusionArray_14 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_14_clock),
    .reset(fusionArray_14_reset),
    .io_int8(fusionArray_14_io_int8),
    .io_fp16_0(fusionArray_14_io_fp16_0),
    .io_fp16_1(fusionArray_14_io_fp16_1),
    .io_fusion(fusionArray_14_io_fusion),
    .io_output0(fusionArray_14_io_output0),
    .io_output1(fusionArray_14_io_output1)
  );
  Fusion fusionArray_15 ( // @[InnerProduct.scala 13:46]
    .clock(fusionArray_15_clock),
    .reset(fusionArray_15_reset),
    .io_int8(fusionArray_15_io_int8),
    .io_fp16_0(fusionArray_15_io_fp16_0),
    .io_fp16_1(fusionArray_15_io_fp16_1),
    .io_fusion(fusionArray_15_io_fusion),
    .io_output0(fusionArray_15_io_output0),
    .io_output1(fusionArray_15_io_output1)
  );
  fp16Add sum0_nextLevel_adder ( // @[InnerProduct.scala 31:39]
    .clock(sum0_nextLevel_adder_clock),
    .reset(sum0_nextLevel_adder_reset),
    .io_a(sum0_nextLevel_adder_io_a),
    .io_b(sum0_nextLevel_adder_io_b),
    .io_out(sum0_nextLevel_adder_io_out)
  );
  fp16Add sum0_adder ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_clock),
    .reset(sum0_adder_reset),
    .io_a(sum0_adder_io_a),
    .io_b(sum0_adder_io_b),
    .io_out(sum0_adder_io_out)
  );
  fp16Add sum0_adder_1 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_1_clock),
    .reset(sum0_adder_1_reset),
    .io_a(sum0_adder_1_io_a),
    .io_b(sum0_adder_1_io_b),
    .io_out(sum0_adder_1_io_out)
  );
  fp16Add sum0_adder_2 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_2_clock),
    .reset(sum0_adder_2_reset),
    .io_a(sum0_adder_2_io_a),
    .io_b(sum0_adder_2_io_b),
    .io_out(sum0_adder_2_io_out)
  );
  fp16Add sum0_adder_3 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_3_clock),
    .reset(sum0_adder_3_reset),
    .io_a(sum0_adder_3_io_a),
    .io_b(sum0_adder_3_io_b),
    .io_out(sum0_adder_3_io_out)
  );
  fp16Add sum0_adder_4 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_4_clock),
    .reset(sum0_adder_4_reset),
    .io_a(sum0_adder_4_io_a),
    .io_b(sum0_adder_4_io_b),
    .io_out(sum0_adder_4_io_out)
  );
  fp16Add sum0_adder_5 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_5_clock),
    .reset(sum0_adder_5_reset),
    .io_a(sum0_adder_5_io_a),
    .io_b(sum0_adder_5_io_b),
    .io_out(sum0_adder_5_io_out)
  );
  fp16Add sum0_adder_6 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_6_clock),
    .reset(sum0_adder_6_reset),
    .io_a(sum0_adder_6_io_a),
    .io_b(sum0_adder_6_io_b),
    .io_out(sum0_adder_6_io_out)
  );
  fp16Add sum0_nextLevel_adder_1 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_nextLevel_adder_1_clock),
    .reset(sum0_nextLevel_adder_1_reset),
    .io_a(sum0_nextLevel_adder_1_io_a),
    .io_b(sum0_nextLevel_adder_1_io_b),
    .io_out(sum0_nextLevel_adder_1_io_out)
  );
  fp16Add sum0_adder_7 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_7_clock),
    .reset(sum0_adder_7_reset),
    .io_a(sum0_adder_7_io_a),
    .io_b(sum0_adder_7_io_b),
    .io_out(sum0_adder_7_io_out)
  );
  fp16Add sum0_adder_8 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_8_clock),
    .reset(sum0_adder_8_reset),
    .io_a(sum0_adder_8_io_a),
    .io_b(sum0_adder_8_io_b),
    .io_out(sum0_adder_8_io_out)
  );
  fp16Add sum0_adder_9 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_9_clock),
    .reset(sum0_adder_9_reset),
    .io_a(sum0_adder_9_io_a),
    .io_b(sum0_adder_9_io_b),
    .io_out(sum0_adder_9_io_out)
  );
  fp16Add sum0_nextLevel_adder_2 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_nextLevel_adder_2_clock),
    .reset(sum0_nextLevel_adder_2_reset),
    .io_a(sum0_nextLevel_adder_2_io_a),
    .io_b(sum0_nextLevel_adder_2_io_b),
    .io_out(sum0_nextLevel_adder_2_io_out)
  );
  fp16Add sum0_adder_10 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_adder_10_clock),
    .reset(sum0_adder_10_reset),
    .io_a(sum0_adder_10_io_a),
    .io_b(sum0_adder_10_io_b),
    .io_out(sum0_adder_10_io_out)
  );
  fp16Add sum0_nextLevel_adder_3 ( // @[InnerProduct.scala 31:39]
    .clock(sum0_nextLevel_adder_3_clock),
    .reset(sum0_nextLevel_adder_3_reset),
    .io_a(sum0_nextLevel_adder_3_io_a),
    .io_b(sum0_nextLevel_adder_3_io_b),
    .io_out(sum0_nextLevel_adder_3_io_out)
  );
  fp16Add sum1_nextLevel_adder ( // @[InnerProduct.scala 31:39]
    .clock(sum1_nextLevel_adder_clock),
    .reset(sum1_nextLevel_adder_reset),
    .io_a(sum1_nextLevel_adder_io_a),
    .io_b(sum1_nextLevel_adder_io_b),
    .io_out(sum1_nextLevel_adder_io_out)
  );
  fp16Add sum1_adder ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_clock),
    .reset(sum1_adder_reset),
    .io_a(sum1_adder_io_a),
    .io_b(sum1_adder_io_b),
    .io_out(sum1_adder_io_out)
  );
  fp16Add sum1_adder_1 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_1_clock),
    .reset(sum1_adder_1_reset),
    .io_a(sum1_adder_1_io_a),
    .io_b(sum1_adder_1_io_b),
    .io_out(sum1_adder_1_io_out)
  );
  fp16Add sum1_adder_2 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_2_clock),
    .reset(sum1_adder_2_reset),
    .io_a(sum1_adder_2_io_a),
    .io_b(sum1_adder_2_io_b),
    .io_out(sum1_adder_2_io_out)
  );
  fp16Add sum1_adder_3 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_3_clock),
    .reset(sum1_adder_3_reset),
    .io_a(sum1_adder_3_io_a),
    .io_b(sum1_adder_3_io_b),
    .io_out(sum1_adder_3_io_out)
  );
  fp16Add sum1_adder_4 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_4_clock),
    .reset(sum1_adder_4_reset),
    .io_a(sum1_adder_4_io_a),
    .io_b(sum1_adder_4_io_b),
    .io_out(sum1_adder_4_io_out)
  );
  fp16Add sum1_adder_5 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_5_clock),
    .reset(sum1_adder_5_reset),
    .io_a(sum1_adder_5_io_a),
    .io_b(sum1_adder_5_io_b),
    .io_out(sum1_adder_5_io_out)
  );
  fp16Add sum1_adder_6 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_6_clock),
    .reset(sum1_adder_6_reset),
    .io_a(sum1_adder_6_io_a),
    .io_b(sum1_adder_6_io_b),
    .io_out(sum1_adder_6_io_out)
  );
  fp16Add sum1_nextLevel_adder_1 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_nextLevel_adder_1_clock),
    .reset(sum1_nextLevel_adder_1_reset),
    .io_a(sum1_nextLevel_adder_1_io_a),
    .io_b(sum1_nextLevel_adder_1_io_b),
    .io_out(sum1_nextLevel_adder_1_io_out)
  );
  fp16Add sum1_adder_7 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_7_clock),
    .reset(sum1_adder_7_reset),
    .io_a(sum1_adder_7_io_a),
    .io_b(sum1_adder_7_io_b),
    .io_out(sum1_adder_7_io_out)
  );
  fp16Add sum1_adder_8 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_8_clock),
    .reset(sum1_adder_8_reset),
    .io_a(sum1_adder_8_io_a),
    .io_b(sum1_adder_8_io_b),
    .io_out(sum1_adder_8_io_out)
  );
  fp16Add sum1_adder_9 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_9_clock),
    .reset(sum1_adder_9_reset),
    .io_a(sum1_adder_9_io_a),
    .io_b(sum1_adder_9_io_b),
    .io_out(sum1_adder_9_io_out)
  );
  fp16Add sum1_nextLevel_adder_2 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_nextLevel_adder_2_clock),
    .reset(sum1_nextLevel_adder_2_reset),
    .io_a(sum1_nextLevel_adder_2_io_a),
    .io_b(sum1_nextLevel_adder_2_io_b),
    .io_out(sum1_nextLevel_adder_2_io_out)
  );
  fp16Add sum1_adder_10 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_adder_10_clock),
    .reset(sum1_adder_10_reset),
    .io_a(sum1_adder_10_io_a),
    .io_b(sum1_adder_10_io_b),
    .io_out(sum1_adder_10_io_out)
  );
  fp16Add sum1_nextLevel_adder_3 ( // @[InnerProduct.scala 31:39]
    .clock(sum1_nextLevel_adder_3_clock),
    .reset(sum1_nextLevel_adder_3_reset),
    .io_a(sum1_nextLevel_adder_3_io_a),
    .io_b(sum1_nextLevel_adder_3_io_b),
    .io_out(sum1_nextLevel_adder_3_io_out)
  );
  fp16Add finalAdder ( // @[InnerProduct.scala 45:28]
    .clock(finalAdder_clock),
    .reset(finalAdder_reset),
    .io_a(finalAdder_io_a),
    .io_b(finalAdder_io_b),
    .io_out(finalAdder_io_out)
  );
  assign io_result = io_fusion ? sum1 : io_result_REG; // @[InnerProduct.scala 49:21]
  assign fusionArray_0_clock = clock;
  assign fusionArray_0_reset = reset;
  assign fusionArray_0_io_int8 = io_int_0; // @[InnerProduct.scala 16:32]
  assign fusionArray_0_io_fp16_0 = io_fp_1; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_0_io_fp16_1 = io_fp_0; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_0_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_1_clock = clock;
  assign fusionArray_1_reset = reset;
  assign fusionArray_1_io_int8 = io_int_1; // @[InnerProduct.scala 16:32]
  assign fusionArray_1_io_fp16_0 = io_fp_3; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_1_io_fp16_1 = io_fp_2; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_1_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_2_clock = clock;
  assign fusionArray_2_reset = reset;
  assign fusionArray_2_io_int8 = io_int_2; // @[InnerProduct.scala 16:32]
  assign fusionArray_2_io_fp16_0 = io_fp_5; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_2_io_fp16_1 = io_fp_4; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_2_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_3_clock = clock;
  assign fusionArray_3_reset = reset;
  assign fusionArray_3_io_int8 = io_int_3; // @[InnerProduct.scala 16:32]
  assign fusionArray_3_io_fp16_0 = io_fp_7; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_3_io_fp16_1 = io_fp_6; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_3_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_4_clock = clock;
  assign fusionArray_4_reset = reset;
  assign fusionArray_4_io_int8 = io_int_4; // @[InnerProduct.scala 16:32]
  assign fusionArray_4_io_fp16_0 = io_fp_9; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_4_io_fp16_1 = io_fp_8; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_4_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_5_clock = clock;
  assign fusionArray_5_reset = reset;
  assign fusionArray_5_io_int8 = io_int_5; // @[InnerProduct.scala 16:32]
  assign fusionArray_5_io_fp16_0 = io_fp_11; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_5_io_fp16_1 = io_fp_10; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_5_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_6_clock = clock;
  assign fusionArray_6_reset = reset;
  assign fusionArray_6_io_int8 = io_int_6; // @[InnerProduct.scala 16:32]
  assign fusionArray_6_io_fp16_0 = io_fp_13; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_6_io_fp16_1 = io_fp_12; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_6_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_7_clock = clock;
  assign fusionArray_7_reset = reset;
  assign fusionArray_7_io_int8 = io_int_7; // @[InnerProduct.scala 16:32]
  assign fusionArray_7_io_fp16_0 = io_fp_15; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_7_io_fp16_1 = io_fp_14; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_7_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_8_clock = clock;
  assign fusionArray_8_reset = reset;
  assign fusionArray_8_io_int8 = io_int_8; // @[InnerProduct.scala 16:32]
  assign fusionArray_8_io_fp16_0 = io_fp_17; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_8_io_fp16_1 = io_fp_16; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_8_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_9_clock = clock;
  assign fusionArray_9_reset = reset;
  assign fusionArray_9_io_int8 = io_int_9; // @[InnerProduct.scala 16:32]
  assign fusionArray_9_io_fp16_0 = io_fp_19; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_9_io_fp16_1 = io_fp_18; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_9_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_10_clock = clock;
  assign fusionArray_10_reset = reset;
  assign fusionArray_10_io_int8 = io_int_10; // @[InnerProduct.scala 16:32]
  assign fusionArray_10_io_fp16_0 = io_fp_21; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_10_io_fp16_1 = io_fp_20; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_10_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_11_clock = clock;
  assign fusionArray_11_reset = reset;
  assign fusionArray_11_io_int8 = io_int_11; // @[InnerProduct.scala 16:32]
  assign fusionArray_11_io_fp16_0 = io_fp_23; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_11_io_fp16_1 = io_fp_22; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_11_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_12_clock = clock;
  assign fusionArray_12_reset = reset;
  assign fusionArray_12_io_int8 = io_int_12; // @[InnerProduct.scala 16:32]
  assign fusionArray_12_io_fp16_0 = io_fp_25; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_12_io_fp16_1 = io_fp_24; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_12_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_13_clock = clock;
  assign fusionArray_13_reset = reset;
  assign fusionArray_13_io_int8 = io_int_13; // @[InnerProduct.scala 16:32]
  assign fusionArray_13_io_fp16_0 = io_fp_27; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_13_io_fp16_1 = io_fp_26; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_13_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_14_clock = clock;
  assign fusionArray_14_reset = reset;
  assign fusionArray_14_io_int8 = io_int_14; // @[InnerProduct.scala 16:32]
  assign fusionArray_14_io_fp16_0 = io_fp_29; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_14_io_fp16_1 = io_fp_28; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_14_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign fusionArray_15_clock = clock;
  assign fusionArray_15_reset = reset;
  assign fusionArray_15_io_int8 = io_int_15; // @[InnerProduct.scala 16:32]
  assign fusionArray_15_io_fp16_0 = io_fp_31; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_15_io_fp16_1 = io_fp_30; // @[InnerProduct.scala 17:42 InnerProduct.scala 17:42]
  assign fusionArray_15_io_fusion = io_fusion; // @[InnerProduct.scala 18:34]
  assign sum0_nextLevel_adder_clock = clock;
  assign sum0_nextLevel_adder_reset = reset;
  assign sum0_nextLevel_adder_io_a = outputs0_0; // @[InnerProduct.scala 32:32]
  assign sum0_nextLevel_adder_io_b = outputs0_1; // @[InnerProduct.scala 33:32]
  assign sum0_adder_clock = clock;
  assign sum0_adder_reset = reset;
  assign sum0_adder_io_a = outputs0_2; // @[InnerProduct.scala 32:32]
  assign sum0_adder_io_b = outputs0_3; // @[InnerProduct.scala 33:32]
  assign sum0_adder_1_clock = clock;
  assign sum0_adder_1_reset = reset;
  assign sum0_adder_1_io_a = outputs0_4; // @[InnerProduct.scala 32:32]
  assign sum0_adder_1_io_b = outputs0_5; // @[InnerProduct.scala 33:32]
  assign sum0_adder_2_clock = clock;
  assign sum0_adder_2_reset = reset;
  assign sum0_adder_2_io_a = outputs0_6; // @[InnerProduct.scala 32:32]
  assign sum0_adder_2_io_b = outputs0_7; // @[InnerProduct.scala 33:32]
  assign sum0_adder_3_clock = clock;
  assign sum0_adder_3_reset = reset;
  assign sum0_adder_3_io_a = outputs0_8; // @[InnerProduct.scala 32:32]
  assign sum0_adder_3_io_b = outputs0_9; // @[InnerProduct.scala 33:32]
  assign sum0_adder_4_clock = clock;
  assign sum0_adder_4_reset = reset;
  assign sum0_adder_4_io_a = outputs0_10; // @[InnerProduct.scala 32:32]
  assign sum0_adder_4_io_b = outputs0_11; // @[InnerProduct.scala 33:32]
  assign sum0_adder_5_clock = clock;
  assign sum0_adder_5_reset = reset;
  assign sum0_adder_5_io_a = outputs0_12; // @[InnerProduct.scala 32:32]
  assign sum0_adder_5_io_b = outputs0_13; // @[InnerProduct.scala 33:32]
  assign sum0_adder_6_clock = clock;
  assign sum0_adder_6_reset = reset;
  assign sum0_adder_6_io_a = outputs0_14; // @[InnerProduct.scala 32:32]
  assign sum0_adder_6_io_b = outputs0_15; // @[InnerProduct.scala 33:32]
  assign sum0_nextLevel_adder_1_clock = clock;
  assign sum0_nextLevel_adder_1_reset = reset;
  assign sum0_nextLevel_adder_1_io_a = sum0_nextLevel_REG; // @[InnerProduct.scala 32:32]
  assign sum0_nextLevel_adder_1_io_b = sum0_REG; // @[InnerProduct.scala 33:32]
  assign sum0_adder_7_clock = clock;
  assign sum0_adder_7_reset = reset;
  assign sum0_adder_7_io_a = sum0_REG_1; // @[InnerProduct.scala 32:32]
  assign sum0_adder_7_io_b = sum0_REG_2; // @[InnerProduct.scala 33:32]
  assign sum0_adder_8_clock = clock;
  assign sum0_adder_8_reset = reset;
  assign sum0_adder_8_io_a = sum0_REG_3; // @[InnerProduct.scala 32:32]
  assign sum0_adder_8_io_b = sum0_REG_4; // @[InnerProduct.scala 33:32]
  assign sum0_adder_9_clock = clock;
  assign sum0_adder_9_reset = reset;
  assign sum0_adder_9_io_a = sum0_REG_5; // @[InnerProduct.scala 32:32]
  assign sum0_adder_9_io_b = sum0_REG_6; // @[InnerProduct.scala 33:32]
  assign sum0_nextLevel_adder_2_clock = clock;
  assign sum0_nextLevel_adder_2_reset = reset;
  assign sum0_nextLevel_adder_2_io_a = sum0_nextLevel_REG_1; // @[InnerProduct.scala 32:32]
  assign sum0_nextLevel_adder_2_io_b = sum0_REG_7; // @[InnerProduct.scala 33:32]
  assign sum0_adder_10_clock = clock;
  assign sum0_adder_10_reset = reset;
  assign sum0_adder_10_io_a = sum0_REG_8; // @[InnerProduct.scala 32:32]
  assign sum0_adder_10_io_b = sum0_REG_9; // @[InnerProduct.scala 33:32]
  assign sum0_nextLevel_adder_3_clock = clock;
  assign sum0_nextLevel_adder_3_reset = reset;
  assign sum0_nextLevel_adder_3_io_a = sum0_nextLevel_REG_2; // @[InnerProduct.scala 32:32]
  assign sum0_nextLevel_adder_3_io_b = sum0_REG_10; // @[InnerProduct.scala 33:32]
  assign sum1_nextLevel_adder_clock = clock;
  assign sum1_nextLevel_adder_reset = reset;
  assign sum1_nextLevel_adder_io_a = outputs1_0; // @[InnerProduct.scala 32:32]
  assign sum1_nextLevel_adder_io_b = outputs1_1; // @[InnerProduct.scala 33:32]
  assign sum1_adder_clock = clock;
  assign sum1_adder_reset = reset;
  assign sum1_adder_io_a = outputs1_2; // @[InnerProduct.scala 32:32]
  assign sum1_adder_io_b = outputs1_3; // @[InnerProduct.scala 33:32]
  assign sum1_adder_1_clock = clock;
  assign sum1_adder_1_reset = reset;
  assign sum1_adder_1_io_a = outputs1_4; // @[InnerProduct.scala 32:32]
  assign sum1_adder_1_io_b = outputs1_5; // @[InnerProduct.scala 33:32]
  assign sum1_adder_2_clock = clock;
  assign sum1_adder_2_reset = reset;
  assign sum1_adder_2_io_a = outputs1_6; // @[InnerProduct.scala 32:32]
  assign sum1_adder_2_io_b = outputs1_7; // @[InnerProduct.scala 33:32]
  assign sum1_adder_3_clock = clock;
  assign sum1_adder_3_reset = reset;
  assign sum1_adder_3_io_a = outputs1_8; // @[InnerProduct.scala 32:32]
  assign sum1_adder_3_io_b = outputs1_9; // @[InnerProduct.scala 33:32]
  assign sum1_adder_4_clock = clock;
  assign sum1_adder_4_reset = reset;
  assign sum1_adder_4_io_a = outputs1_10; // @[InnerProduct.scala 32:32]
  assign sum1_adder_4_io_b = outputs1_11; // @[InnerProduct.scala 33:32]
  assign sum1_adder_5_clock = clock;
  assign sum1_adder_5_reset = reset;
  assign sum1_adder_5_io_a = outputs1_12; // @[InnerProduct.scala 32:32]
  assign sum1_adder_5_io_b = outputs1_13; // @[InnerProduct.scala 33:32]
  assign sum1_adder_6_clock = clock;
  assign sum1_adder_6_reset = reset;
  assign sum1_adder_6_io_a = outputs1_14; // @[InnerProduct.scala 32:32]
  assign sum1_adder_6_io_b = outputs1_15; // @[InnerProduct.scala 33:32]
  assign sum1_nextLevel_adder_1_clock = clock;
  assign sum1_nextLevel_adder_1_reset = reset;
  assign sum1_nextLevel_adder_1_io_a = sum1_nextLevel_REG; // @[InnerProduct.scala 32:32]
  assign sum1_nextLevel_adder_1_io_b = sum1_REG; // @[InnerProduct.scala 33:32]
  assign sum1_adder_7_clock = clock;
  assign sum1_adder_7_reset = reset;
  assign sum1_adder_7_io_a = sum1_REG_1; // @[InnerProduct.scala 32:32]
  assign sum1_adder_7_io_b = sum1_REG_2; // @[InnerProduct.scala 33:32]
  assign sum1_adder_8_clock = clock;
  assign sum1_adder_8_reset = reset;
  assign sum1_adder_8_io_a = sum1_REG_3; // @[InnerProduct.scala 32:32]
  assign sum1_adder_8_io_b = sum1_REG_4; // @[InnerProduct.scala 33:32]
  assign sum1_adder_9_clock = clock;
  assign sum1_adder_9_reset = reset;
  assign sum1_adder_9_io_a = sum1_REG_5; // @[InnerProduct.scala 32:32]
  assign sum1_adder_9_io_b = sum1_REG_6; // @[InnerProduct.scala 33:32]
  assign sum1_nextLevel_adder_2_clock = clock;
  assign sum1_nextLevel_adder_2_reset = reset;
  assign sum1_nextLevel_adder_2_io_a = sum1_nextLevel_REG_1; // @[InnerProduct.scala 32:32]
  assign sum1_nextLevel_adder_2_io_b = sum1_REG_7; // @[InnerProduct.scala 33:32]
  assign sum1_adder_10_clock = clock;
  assign sum1_adder_10_reset = reset;
  assign sum1_adder_10_io_a = sum1_REG_8; // @[InnerProduct.scala 32:32]
  assign sum1_adder_10_io_b = sum1_REG_9; // @[InnerProduct.scala 33:32]
  assign sum1_nextLevel_adder_3_clock = clock;
  assign sum1_nextLevel_adder_3_reset = reset;
  assign sum1_nextLevel_adder_3_io_a = sum1_nextLevel_REG_2; // @[InnerProduct.scala 32:32]
  assign sum1_nextLevel_adder_3_io_b = sum1_REG_10; // @[InnerProduct.scala 33:32]
  assign finalAdder_clock = clock;
  assign finalAdder_reset = reset;
  assign finalAdder_io_a = sum0; // @[InnerProduct.scala 46:21]
  assign finalAdder_io_b = sum1; // @[InnerProduct.scala 47:21]
  always @(posedge clock) begin
    outputs0_0 <= fusionArray_0_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_1 <= fusionArray_1_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_2 <= fusionArray_2_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_3 <= fusionArray_3_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_4 <= fusionArray_4_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_5 <= fusionArray_5_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_6 <= fusionArray_6_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_7 <= fusionArray_7_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_8 <= fusionArray_8_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_9 <= fusionArray_9_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_10 <= fusionArray_10_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_11 <= fusionArray_11_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_12 <= fusionArray_12_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_13 <= fusionArray_13_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_14 <= fusionArray_14_io_output0; // @[InnerProduct.scala 21:66]
    outputs0_15 <= fusionArray_15_io_output0; // @[InnerProduct.scala 21:66]
    outputs1_0 <= fusionArray_0_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_1 <= fusionArray_1_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_2 <= fusionArray_2_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_3 <= fusionArray_3_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_4 <= fusionArray_4_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_5 <= fusionArray_5_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_6 <= fusionArray_6_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_7 <= fusionArray_7_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_8 <= fusionArray_8_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_9 <= fusionArray_9_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_10 <= fusionArray_10_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_11 <= fusionArray_11_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_12 <= fusionArray_12_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_13 <= fusionArray_13_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_14 <= fusionArray_14_io_output1; // @[InnerProduct.scala 22:66]
    outputs1_15 <= fusionArray_15_io_output1; // @[InnerProduct.scala 22:66]
    sum0_nextLevel_REG <= sum0_nextLevel_adder_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG <= sum0_adder_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_1 <= sum0_adder_1_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_2 <= sum0_adder_2_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_3 <= sum0_adder_3_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_4 <= sum0_adder_4_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_5 <= sum0_adder_5_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_6 <= sum0_adder_6_io_out; // @[InnerProduct.scala 35:28]
    sum0_nextLevel_REG_1 <= sum0_nextLevel_adder_1_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_7 <= sum0_adder_7_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_8 <= sum0_adder_8_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_9 <= sum0_adder_9_io_out; // @[InnerProduct.scala 35:28]
    sum0_nextLevel_REG_2 <= sum0_nextLevel_adder_2_io_out; // @[InnerProduct.scala 35:28]
    sum0_REG_10 <= sum0_adder_10_io_out; // @[InnerProduct.scala 35:28]
    sum0 <= sum0_nextLevel_adder_3_io_out; // @[InnerProduct.scala 35:28]
    sum1_nextLevel_REG <= sum1_nextLevel_adder_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG <= sum1_adder_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_1 <= sum1_adder_1_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_2 <= sum1_adder_2_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_3 <= sum1_adder_3_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_4 <= sum1_adder_4_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_5 <= sum1_adder_5_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_6 <= sum1_adder_6_io_out; // @[InnerProduct.scala 35:28]
    sum1_nextLevel_REG_1 <= sum1_nextLevel_adder_1_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_7 <= sum1_adder_7_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_8 <= sum1_adder_8_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_9 <= sum1_adder_9_io_out; // @[InnerProduct.scala 35:28]
    sum1_nextLevel_REG_2 <= sum1_nextLevel_adder_2_io_out; // @[InnerProduct.scala 35:28]
    sum1_REG_10 <= sum1_adder_10_io_out; // @[InnerProduct.scala 35:28]
    sum1 <= sum1_nextLevel_adder_3_io_out; // @[InnerProduct.scala 35:28]
    io_result_REG <= finalAdder_io_out; // @[InnerProduct.scala 49:46]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"output0 = %b, output1 = %b\n",outputs0_0,outputs1_0); // @[InnerProduct.scala 24:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_0,outputs0_1); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_2,outputs0_3); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_4,outputs0_5); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_6,outputs0_7); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_8,outputs0_9); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_10,outputs0_11); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_12,outputs0_13); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs0_14,outputs0_15); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_nextLevel_REG,sum0_REG); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_REG_1,sum0_REG_2); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_REG_3,sum0_REG_4); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_REG_5,sum0_REG_6); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_nextLevel_REG_1,sum0_REG_7); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_REG_8,sum0_REG_9); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum0_nextLevel_REG_2,sum0_REG_10); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_0,outputs1_1); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_2,outputs1_3); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_4,outputs1_5); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_6,outputs1_7); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_8,outputs1_9); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_10,outputs1_11); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_12,outputs1_13); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",outputs1_14,outputs1_15); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_nextLevel_REG,sum1_REG); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_REG_1,sum1_REG_2); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_REG_3,sum1_REG_4); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_REG_5,sum1_REG_6); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_nextLevel_REG_1,sum1_REG_7); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_REG_8,sum1_REG_9); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"a: %b, b: %b\n",sum1_nextLevel_REG_2,sum1_REG_10); // @[InnerProduct.scala 34:27]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"io.result = %b\n",io_result); // @[InnerProduct.scala 50:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  outputs0_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  outputs0_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  outputs0_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  outputs0_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  outputs0_4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  outputs0_5 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  outputs0_6 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  outputs0_7 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  outputs0_8 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  outputs0_9 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  outputs0_10 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  outputs0_11 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  outputs0_12 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  outputs0_13 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  outputs0_14 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  outputs0_15 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  outputs1_0 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  outputs1_1 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  outputs1_2 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  outputs1_3 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  outputs1_4 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  outputs1_5 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  outputs1_6 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  outputs1_7 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  outputs1_8 = _RAND_24[15:0];
  _RAND_25 = {1{`RANDOM}};
  outputs1_9 = _RAND_25[15:0];
  _RAND_26 = {1{`RANDOM}};
  outputs1_10 = _RAND_26[15:0];
  _RAND_27 = {1{`RANDOM}};
  outputs1_11 = _RAND_27[15:0];
  _RAND_28 = {1{`RANDOM}};
  outputs1_12 = _RAND_28[15:0];
  _RAND_29 = {1{`RANDOM}};
  outputs1_13 = _RAND_29[15:0];
  _RAND_30 = {1{`RANDOM}};
  outputs1_14 = _RAND_30[15:0];
  _RAND_31 = {1{`RANDOM}};
  outputs1_15 = _RAND_31[15:0];
  _RAND_32 = {1{`RANDOM}};
  sum0_nextLevel_REG = _RAND_32[15:0];
  _RAND_33 = {1{`RANDOM}};
  sum0_REG = _RAND_33[15:0];
  _RAND_34 = {1{`RANDOM}};
  sum0_REG_1 = _RAND_34[15:0];
  _RAND_35 = {1{`RANDOM}};
  sum0_REG_2 = _RAND_35[15:0];
  _RAND_36 = {1{`RANDOM}};
  sum0_REG_3 = _RAND_36[15:0];
  _RAND_37 = {1{`RANDOM}};
  sum0_REG_4 = _RAND_37[15:0];
  _RAND_38 = {1{`RANDOM}};
  sum0_REG_5 = _RAND_38[15:0];
  _RAND_39 = {1{`RANDOM}};
  sum0_REG_6 = _RAND_39[15:0];
  _RAND_40 = {1{`RANDOM}};
  sum0_nextLevel_REG_1 = _RAND_40[15:0];
  _RAND_41 = {1{`RANDOM}};
  sum0_REG_7 = _RAND_41[15:0];
  _RAND_42 = {1{`RANDOM}};
  sum0_REG_8 = _RAND_42[15:0];
  _RAND_43 = {1{`RANDOM}};
  sum0_REG_9 = _RAND_43[15:0];
  _RAND_44 = {1{`RANDOM}};
  sum0_nextLevel_REG_2 = _RAND_44[15:0];
  _RAND_45 = {1{`RANDOM}};
  sum0_REG_10 = _RAND_45[15:0];
  _RAND_46 = {1{`RANDOM}};
  sum0 = _RAND_46[15:0];
  _RAND_47 = {1{`RANDOM}};
  sum1_nextLevel_REG = _RAND_47[15:0];
  _RAND_48 = {1{`RANDOM}};
  sum1_REG = _RAND_48[15:0];
  _RAND_49 = {1{`RANDOM}};
  sum1_REG_1 = _RAND_49[15:0];
  _RAND_50 = {1{`RANDOM}};
  sum1_REG_2 = _RAND_50[15:0];
  _RAND_51 = {1{`RANDOM}};
  sum1_REG_3 = _RAND_51[15:0];
  _RAND_52 = {1{`RANDOM}};
  sum1_REG_4 = _RAND_52[15:0];
  _RAND_53 = {1{`RANDOM}};
  sum1_REG_5 = _RAND_53[15:0];
  _RAND_54 = {1{`RANDOM}};
  sum1_REG_6 = _RAND_54[15:0];
  _RAND_55 = {1{`RANDOM}};
  sum1_nextLevel_REG_1 = _RAND_55[15:0];
  _RAND_56 = {1{`RANDOM}};
  sum1_REG_7 = _RAND_56[15:0];
  _RAND_57 = {1{`RANDOM}};
  sum1_REG_8 = _RAND_57[15:0];
  _RAND_58 = {1{`RANDOM}};
  sum1_REG_9 = _RAND_58[15:0];
  _RAND_59 = {1{`RANDOM}};
  sum1_nextLevel_REG_2 = _RAND_59[15:0];
  _RAND_60 = {1{`RANDOM}};
  sum1_REG_10 = _RAND_60[15:0];
  _RAND_61 = {1{`RANDOM}};
  sum1 = _RAND_61[15:0];
  _RAND_62 = {1{`RANDOM}};
  io_result_REG = _RAND_62[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
