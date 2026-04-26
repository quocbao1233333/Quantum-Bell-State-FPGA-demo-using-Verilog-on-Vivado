`include "qcfg_defs.vh"

module qgate_h_1q (
    input  wire signed [`QDATA_W-1:0] alpha_re_i,
    input  wire signed [`QDATA_W-1:0] alpha_im_i,
    input  wire signed [`QDATA_W-1:0] beta_re_i,
    input  wire signed [`QDATA_W-1:0] beta_im_i,

    output wire signed [`QDATA_W-1:0] alpha_re_o,
    output wire signed [`QDATA_W-1:0] alpha_im_o,
    output wire signed [`QDATA_W-1:0] beta_re_o,
    output wire signed [`QDATA_W-1:0] beta_im_o
);

    wire signed [`QDATA_W-1:0] sum_re_w;
    wire signed [`QDATA_W-1:0] sum_im_w;
    wire signed [`QDATA_W-1:0] diff_re_w;
    wire signed [`QDATA_W-1:0] diff_im_w;
    wire signed [`QDATA_W-1:0] scaled_sum_re_w;
    wire signed [`QDATA_W-1:0] scaled_sum_im_w;
    wire signed [`QDATA_W-1:0] scaled_diff_re_w;
    wire signed [`QDATA_W-1:0] scaled_diff_im_w;
    cpx_add u_cpx_add_ab (
        .a_re_i   (alpha_re_i),
        .a_im_i   (alpha_im_i),
        .b_re_i   (beta_re_i),
        .b_im_i   (beta_im_i),
        .out_re_o (sum_re_w),
        .out_im_o (sum_im_w)
    );
    cpx_sub u_cpx_sub_ab (
        .a_re_i   (alpha_re_i),
        .a_im_i   (alpha_im_i),
        .b_re_i   (beta_re_i),
        .b_im_i   (beta_im_i),
        .out_re_o (diff_re_w),
        .out_im_o (diff_im_w)
    );
    fxp_mul_k_inv_sqrt2 u_mul_sum_re (
        .in_i  (sum_re_w),
        .out_o (scaled_sum_re_w)
    );

    fxp_mul_k_inv_sqrt2 u_mul_sum_im (
        .in_i  (sum_im_w),
        .out_o (scaled_sum_im_w)
    );

    
    fxp_mul_k_inv_sqrt2 u_mul_diff_re (
        .in_i  (diff_re_w),
        .out_o (scaled_diff_re_w)
    );

    fxp_mul_k_inv_sqrt2 u_mul_diff_im (
        .in_i  (diff_im_w),
        .out_o (scaled_diff_im_w)
    );
    assign alpha_re_o = scaled_sum_re_w;
    assign alpha_im_o = scaled_sum_im_w;
    assign beta_re_o  = scaled_diff_re_w;
    assign beta_im_o  = scaled_diff_im_w;

endmodule


