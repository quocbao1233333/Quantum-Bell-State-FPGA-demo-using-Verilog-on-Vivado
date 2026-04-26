`include "qcfg_defs.vh"

module cpx_add (
    input  signed [`QDATA_W-1:0] a_re_i,
    input  signed [`QDATA_W-1:0] a_im_i,
    input  signed [`QDATA_W-1:0] b_re_i,
    input  signed [`QDATA_W-1:0] b_im_i,

    output signed [`QDATA_W-1:0] out_re_o,
    output signed [`QDATA_W-1:0] out_im_o
);
    assign out_re_o = a_re_i + b_re_i;
    assign out_im_o = a_im_i + b_im_i;

endmodule
