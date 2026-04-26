`include "qcfg_defs.vh"

module qgate_z_1q (
    input  wire signed [`QDATA_W-1:0] alpha_re_i,
    input  wire signed [`QDATA_W-1:0] alpha_im_i,
    input  wire signed [`QDATA_W-1:0] beta_re_i,
    input  wire signed [`QDATA_W-1:0] beta_im_i,

    output wire signed [`QDATA_W-1:0] alpha_re_o,
    output wire signed [`QDATA_W-1:0] alpha_im_o,
    output wire signed [`QDATA_W-1:0] beta_re_o,
    output wire signed [`QDATA_W-1:0] beta_im_o
);
    // alpha_out = alpha_in
    assign alpha_re_o = alpha_re_i;
    assign alpha_im_o = alpha_im_i;
    // beta_out = -beta_in
    assign beta_re_o  = -beta_re_i;
    assign beta_im_o  = -beta_im_i;

endmodule
