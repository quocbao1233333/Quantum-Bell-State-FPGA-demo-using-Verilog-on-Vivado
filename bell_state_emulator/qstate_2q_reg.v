`include "qcfg_defs.vh"

module qstate_2q_reg (
    input  wire                         clk_i,
    input  wire                         rst_i,
    input  wire                         en_i,

    input  wire signed [`QDATA_W-1:0]   a00_re_i,
    input  wire signed [`QDATA_W-1:0]   a00_im_i,
    input  wire signed [`QDATA_W-1:0]   a01_re_i,
    input  wire signed [`QDATA_W-1:0]   a01_im_i,
    input  wire signed [`QDATA_W-1:0]   a10_re_i,
    input  wire signed [`QDATA_W-1:0]   a10_im_i,
    input  wire signed [`QDATA_W-1:0]   a11_re_i,
    input  wire signed [`QDATA_W-1:0]   a11_im_i,

    output reg  signed [`QDATA_W-1:0]   a00_re_o,
    output reg  signed [`QDATA_W-1:0]   a00_im_o,
    output reg  signed [`QDATA_W-1:0]   a01_re_o,
    output reg  signed [`QDATA_W-1:0]   a01_im_o,
    output reg  signed [`QDATA_W-1:0]   a10_re_o,
    output reg  signed [`QDATA_W-1:0]   a10_im_o,
    output reg  signed [`QDATA_W-1:0]   a11_re_o,
    output reg  signed [`QDATA_W-1:0]   a11_im_o
);

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            a00_re_o <= `Q2_KET00_A00_RE;
            a00_im_o <= `Q2_KET00_A00_IM;
            a01_re_o <= `Q2_KET00_A01_RE;
            a01_im_o <= `Q2_KET00_A01_IM;
            a10_re_o <= `Q2_KET00_A10_RE;
            a10_im_o <= `Q2_KET00_A10_IM;
            a11_re_o <= `Q2_KET00_A11_RE;
            a11_im_o <= `Q2_KET00_A11_IM;
        end
        else if (en_i) begin
            a00_re_o <= a00_re_i;
            a00_im_o <= a00_im_i;
            a01_re_o <= a01_re_i;
            a01_im_o <= a01_im_i;
            a10_re_o <= a10_re_i;
            a10_im_o <= a10_im_i;
            a11_re_o <= a11_re_i;
            a11_im_o <= a11_im_i;
        end
        else begin
            a00_re_o <= a00_re_o;
            a00_im_o <= a00_im_o;
            a01_re_o <= a01_re_o;
            a01_im_o <= a01_im_o;
            a10_re_o <= a10_re_o;
            a10_im_o <= a10_im_o;
            a11_re_o <= a11_re_o;
            a11_im_o <= a11_im_o;
        end
    end

endmodule

