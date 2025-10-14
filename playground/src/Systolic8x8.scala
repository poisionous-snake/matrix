package mac

import chisel3._
import chisel3.util._

class PeMac extends Module {
  val io = IO(new Bundle {
    val valid_in = Input(Bool())
    val A_in = Input(UInt(16.W))
    val B_in = Input(UInt(4.W))

    val A_out = Output(UInt(16.W))
    val B_out = Output(UInt(4.W))
    val valid_out = Output(Bool())

    val acc_out = Output(UInt(16.W))
  })

  val acc_reg = RegInit(0.U(16.W))
  val a_reg = RegInit(0.U(16.W))
  val b_reg = RegInit(0.U(4.W))
  val v_reg = RegInit(false.B)

  // convert int4 -> fp16, multiply, then add to acc when valid
  val conv = Module(new Int4ToFp16())
  val mul = Module(new Fp16Mul())
  val add = Module(new Fp16Add())

  conv.io.in := io.B_in
  mul.io.in1 := conv.io.out
  mul.io.in2 := io.A_in

  add.io.in1 := mul.io.out
  add.io.in2 := acc_reg

  // outputs
  io.A_out := a_reg
  io.B_out := b_reg
  io.valid_out := v_reg
  io.acc_out := acc_reg

  // behavior
  when (!reset.asBool) {
    // synchronous reset handled by RegInit
  }

  // shift and update accumulator on each cycle
  when (io.valid_in) {
    // shift inputs to neighbors
    a_reg := io.A_in
    b_reg := io.B_in
    // update accumulator with adder result
    acc_reg := add.io.out
    v_reg := true.B
  } .otherwise {
    // still shift values (so neighbors get zeros if not valid)
    a_reg := io.A_in
    b_reg := io.B_in
    v_reg := false.B
    // keep acc_reg
    acc_reg := acc_reg
  }
}

class Systolic8x8Tile(val M: Int = 8, val N: Int = 8, val K: Int = 8) extends Module {
    val io = IO(new Bundle {
        val start = Input(Bool())
        val A_flat = Input(UInt((M * K * 16).W))
        val B_flat = Input(UInt((K * N * 4).W))
        val C_flat = Output(UInt((M * N * 16).W))
    })

    val M1 = RegInit(VecInit(Seq.fill(M)(VecInit(Seq.fill(K)(0.U(16.W)))))) // Matrix1: M * K
    val M2 = RegInit(VecInit(Seq.fill(K)(VecInit(Seq.fill(N)(0.U(4.W)))))) // Matrix2: K * N

    val pe = Seq.fill(M)(Seq.fill(N)(Module(new PeMac())))
    for(i <- 0 until M) {
        for(j <- 0 until N) {
            pe(i)(j).io.valid_in := false.B
            pe(i)(j).io.A_in := DontCare
            pe(i)(j).io.B_in := DontCare
            // if(j + 1 < M) pe(i)(j + 1).io.B_in := pe(i)(j).io.B_out
        }
    }
    for(i <- 0 until M) {
        for(j <- 0 until N) {
            if(j + 1 < N) {
                pe(i)(j + 1).io.A_in := pe(i)(j).io.A_out
                pe(i)(j + 1).io.valid_in := pe(i)(j).io.valid_out
            }
            if(i + 1 < M) {
                pe(i + 1)(j).io.B_in := pe(i)(j).io.B_out
                pe(i + 1)(j).io.valid_in := pe(i)(j).io.valid_out
            }

        }
    }


    when(io.start) {
        for (i <- 0 until M) {
            for (k <- 0 until K) {
                M1(i)(k) := io.A_flat((i * K + k) * 16 + 15, (i * K + k) * 16)
            }
        }
        for (k <- 0 until K) {
            for (j <- 0 until N) {
                M2(k)(j) := io.B_flat((k * N + j) * 4 + 3, (k * N + j) * 4)
            }
        }
    }
    
    val cnt = RegInit(0.U(10.W))

    // 传送数据
    when(RegNext(io.start)) {
        cnt := cnt + 1.U
        for(i <- 0 until M) {
            when(cnt >= i.U && cnt < (K + i).U) {
                pe(i)(0).io.valid_in := true.B 
                pe(i)(0).io.A_in := M1(i.U)(cnt - i.U)
            }
        }
        for(j <- 0 until N) {
            when(cnt >= j.U && cnt < (K + j).U) {
                pe(0)(j).io.valid_in := true.B
                pe(0)(j).io.B_in := M2(cnt - j.U)(j.U)
            }
        }
    }

    // pe activation test
    // printf("cycles: %d\n", cnt)
    // for(i <- 0 until M) {
    //     for(j <- 0 until N) {
    //         when(pe(i)(j).io.valid_in){
    //             printf("*") // activated
    //         }.otherwise{
    //             printf("-")
    //         }
    //     }
    //     printf("\n");
    // }

    // 传送结果
    val output = Wire(Vec(M * N, UInt(16.W)))
    for(i <- 0 until M) {
        for(j <- 0 until N) {
            output(i * M + j) := pe(i)(j).io.acc_out
        }
    }
    io.C_flat := output.asUInt
}