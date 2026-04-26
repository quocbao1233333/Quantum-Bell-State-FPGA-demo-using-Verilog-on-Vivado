`include "qcfg_defs.vh"

module top_bell_demo (
    input  wire                         clk_i,
    input  wire                         rst_i,
    input  wire                         en_i,

    output wire signed [`QDATA_W-1:0]   a00_re_o,
    output wire signed [`QDATA_W-1:0]   a00_im_o,
    output wire signed [`QDATA_W-1:0]   a01_re_o,
    output wire signed [`QDATA_W-1:0]   a01_im_o,
    output wire signed [`QDATA_W-1:0]   a10_re_o,
    output wire signed [`QDATA_W-1:0]   a10_im_o,
    output wire signed [`QDATA_W-1:0]   a11_re_o,
    output wire signed [`QDATA_W-1:0]   a11_im_o
);

    // ============================================================
    // 1) Khoi khoi tao trang thai dau vao |00>
    // ============================================================
    wire signed [`QDATA_W-1:0] init_a00_re_w;
    wire signed [`QDATA_W-1:0] init_a00_im_w;
    wire signed [`QDATA_W-1:0] init_a01_re_w;
    wire signed [`QDATA_W-1:0] init_a01_im_w;
    wire signed [`QDATA_W-1:0] init_a10_re_w;
    wire signed [`QDATA_W-1:0] init_a10_im_w;
    wire signed [`QDATA_W-1:0] init_a11_re_w;
    wire signed [`QDATA_W-1:0] init_a11_im_w;

    qstate_bell_init u_qstate_bell_init (
        .a00_re_o(init_a00_re_w),
        .a00_im_o(init_a00_im_w),
        .a01_re_o(init_a01_re_w),
        .a01_im_o(init_a01_im_w),
        .a10_re_o(init_a10_re_w),
        .a10_im_o(init_a10_im_w),
        .a11_re_o(init_a11_re_w),
        .a11_im_o(init_a11_im_w)
    );

    // ============================================================
    // 2) REG0: chot trang thai dau vao |00>
    // ============================================================
    wire signed [`QDATA_W-1:0] reg0_a00_re_w;
    wire signed [`QDATA_W-1:0] reg0_a00_im_w;
    wire signed [`QDATA_W-1:0] reg0_a01_re_w;
    wire signed [`QDATA_W-1:0] reg0_a01_im_w;
    wire signed [`QDATA_W-1:0] reg0_a10_re_w;
    wire signed [`QDATA_W-1:0] reg0_a10_im_w;
    wire signed [`QDATA_W-1:0] reg0_a11_re_w;
    wire signed [`QDATA_W-1:0] reg0_a11_im_w;

    qstate_2q_reg u_reg0_init (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .en_i     (en_i),

        .a00_re_i (init_a00_re_w),
        .a00_im_i (init_a00_im_w),
        .a01_re_i (init_a01_re_w),
        .a01_im_i (init_a01_im_w),
        .a10_re_i (init_a10_re_w),
        .a10_im_i (init_a10_im_w),
        .a11_re_i (init_a11_re_w),
        .a11_im_i (init_a11_im_w),

        .a00_re_o (reg0_a00_re_w),
        .a00_im_o (reg0_a00_im_w),
        .a01_re_o (reg0_a01_re_w),
        .a01_im_o (reg0_a01_im_w),
        .a10_re_o (reg0_a10_re_w),
        .a10_im_o (reg0_a10_im_w),
        .a11_re_o (reg0_a11_re_w),
        .a11_im_o (reg0_a11_im_w)
    );

    // ============================================================
    // 3) H tren qubit 1 cua he 2 qubit
    // Thu tu co so:
    //   |00>, |01>, |10>, |11>
    //
    // Ap H len qubit 1 theo tung cap:
    //   Cap 1: (|00>, |10>)
    //   Cap 2: (|01>, |11>)
    // ============================================================
    wire signed [`QDATA_W-1:0] h_a00_re_w;
    wire signed [`QDATA_W-1:0] h_a00_im_w;
    wire signed [`QDATA_W-1:0] h_a01_re_w;
    wire signed [`QDATA_W-1:0] h_a01_im_w;
    wire signed [`QDATA_W-1:0] h_a10_re_w;
    wire signed [`QDATA_W-1:0] h_a10_im_w;
    wire signed [`QDATA_W-1:0] h_a11_re_w;
    wire signed [`QDATA_W-1:0] h_a11_im_w;

    // Cap (a00, a10)
    qgate_h_1q u_h_on_pair_0 (
        .alpha_re_i (reg0_a00_re_w),
        .alpha_im_i (reg0_a00_im_w),
        .beta_re_i  (reg0_a10_re_w),
        .beta_im_i  (reg0_a10_im_w),

        .alpha_re_o (h_a00_re_w),
        .alpha_im_o (h_a00_im_w),
        .beta_re_o  (h_a10_re_w),
        .beta_im_o  (h_a10_im_w)
    );

    // Cap (a01, a11)
    qgate_h_1q u_h_on_pair_1 (
        .alpha_re_i (reg0_a01_re_w),
        .alpha_im_i (reg0_a01_im_w),
        .beta_re_i  (reg0_a11_re_w),
        .beta_im_i  (reg0_a11_im_w),

        .alpha_re_o (h_a01_re_w),
        .alpha_im_o (h_a01_im_w),
        .beta_re_o  (h_a11_re_w),
        .beta_im_o  (h_a11_im_w)
    );

    // ============================================================
    // 4) REG1: chot trang thai sau Hadamard
    // ============================================================
    wire signed [`QDATA_W-1:0] reg1_a00_re_w;
    wire signed [`QDATA_W-1:0] reg1_a00_im_w;
    wire signed [`QDATA_W-1:0] reg1_a01_re_w;
    wire signed [`QDATA_W-1:0] reg1_a01_im_w;
    wire signed [`QDATA_W-1:0] reg1_a10_re_w;
    wire signed [`QDATA_W-1:0] reg1_a10_im_w;
    wire signed [`QDATA_W-1:0] reg1_a11_re_w;
    wire signed [`QDATA_W-1:0] reg1_a11_im_w;

    qstate_2q_reg u_reg1_after_h (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .en_i     (en_i),

        .a00_re_i (h_a00_re_w),
        .a00_im_i (h_a00_im_w),
        .a01_re_i (h_a01_re_w),
        .a01_im_i (h_a01_im_w),
        .a10_re_i (h_a10_re_w),
        .a10_im_i (h_a10_im_w),
        .a11_re_i (h_a11_re_w),
        .a11_im_i (h_a11_im_w),

        .a00_re_o (reg1_a00_re_w),
        .a00_im_o (reg1_a00_im_w),
        .a01_re_o (reg1_a01_re_w),
        .a01_im_o (reg1_a01_im_w),
        .a10_re_o (reg1_a10_re_w),
        .a10_im_o (reg1_a10_im_w),
        .a11_re_o (reg1_a11_re_w),
        .a11_im_o (reg1_a11_im_w)
    );

    // ============================================================
    // 5) CNOT tren he 2 qubit
    // Thu tu co so:
    //   |00>, |01>, |10>, |11>
    //
    // Anh xa:
    //   |00> -> |00>
    //   |01> -> |01>
    //   |10> -> |11>
    //   |11> -> |10>
    // ============================================================
    wire signed [`QDATA_W-1:0] cnot_a00_re_w;
    wire signed [`QDATA_W-1:0] cnot_a00_im_w;
    wire signed [`QDATA_W-1:0] cnot_a01_re_w;
    wire signed [`QDATA_W-1:0] cnot_a01_im_w;
    wire signed [`QDATA_W-1:0] cnot_a10_re_w;
    wire signed [`QDATA_W-1:0] cnot_a10_im_w;
    wire signed [`QDATA_W-1:0] cnot_a11_re_w;
    wire signed [`QDATA_W-1:0] cnot_a11_im_w;

    qgate_cnot_2q u_cnot (
        .a00_re_i (reg1_a00_re_w),
        .a00_im_i (reg1_a00_im_w),
        .a01_re_i (reg1_a01_re_w),
        .a01_im_i (reg1_a01_im_w),
        .a10_re_i (reg1_a10_re_w),
        .a10_im_i (reg1_a10_im_w),
        .a11_re_i (reg1_a11_re_w),
        .a11_im_i (reg1_a11_im_w),

        .a00_re_o (cnot_a00_re_w),
        .a00_im_o (cnot_a00_im_w),
        .a01_re_o (cnot_a01_re_w),
        .a01_im_o (cnot_a01_im_w),
        .a10_re_o (cnot_a10_re_w),
        .a10_im_o (cnot_a10_im_w),
        .a11_re_o (cnot_a11_re_w),
        .a11_im_o (cnot_a11_im_w)
    );

    // ============================================================
    // 6) REG2: chot trang thai cuoi cung sau CNOT
    // ============================================================
    qstate_2q_reg u_reg2_after_cnot (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .en_i     (en_i),

        .a00_re_i (cnot_a00_re_w),
        .a00_im_i (cnot_a00_im_w),
        .a01_re_i (cnot_a01_re_w),
        .a01_im_i (cnot_a01_im_w),
        .a10_re_i (cnot_a10_re_w),
        .a10_im_i (cnot_a10_im_w),
        .a11_re_i (cnot_a11_re_w),
        .a11_im_i (cnot_a11_im_w),

        .a00_re_o (a00_re_o),
        .a00_im_o (a00_im_o),
        .a01_re_o (a01_re_o),
        .a01_im_o (a01_im_o),
        .a10_re_o (a10_re_o),
        .a10_im_o (a10_im_o),
        .a11_re_o (a11_re_o),
        .a11_im_o (a11_im_o)
    );

endmodule
