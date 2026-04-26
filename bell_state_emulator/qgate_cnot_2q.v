`include "qcfg_defs.vh"

module qgate_cnot_2q (
    input  wire signed [`QDATA_W-1:0] a00_re_i,
    input  wire signed [`QDATA_W-1:0] a00_im_i,
    input  wire signed [`QDATA_W-1:0] a01_re_i,
    input  wire signed [`QDATA_W-1:0] a01_im_i,
    input  wire signed [`QDATA_W-1:0] a10_re_i,
    input  wire signed [`QDATA_W-1:0] a10_im_i,
    input  wire signed [`QDATA_W-1:0] a11_re_i,
    input  wire signed [`QDATA_W-1:0] a11_im_i,

    output wire signed [`QDATA_W-1:0] a00_re_o,
    output wire signed [`QDATA_W-1:0] a00_im_o,
    output wire signed [`QDATA_W-1:0] a01_re_o,
    output wire signed [`QDATA_W-1:0] a01_im_o,
    output wire signed [`QDATA_W-1:0] a10_re_o,
    output wire signed [`QDATA_W-1:0] a10_im_o,
    output wire signed [`QDATA_W-1:0] a11_re_o,
    output wire signed [`QDATA_W-1:0] a11_im_o
);
    assign a00_re_o = a00_re_i;
    assign a00_im_o = a00_im_i;
    assign a01_re_o = a01_re_i;
    assign a01_im_o = a01_im_i;
    assign a10_re_o = a11_re_i;
    assign a10_im_o = a11_im_i;
    assign a11_re_o = a10_re_i;
    assign a11_im_o = a10_im_i;

endmodule
