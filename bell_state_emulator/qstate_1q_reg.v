`include "qcfg_defs.vh"

module qstate_1q_reg (
    input  wire                         clk_i,
    input  wire                         rst_i,
    input  wire                         en_i,

    input  wire signed [`QDATA_W-1:0]   alpha_re_i,
    input  wire signed [`QDATA_W-1:0]   alpha_im_i,
    input  wire signed [`QDATA_W-1:0]   beta_re_i,
    input  wire signed [`QDATA_W-1:0]   beta_im_i,

    output reg  signed [`QDATA_W-1:0]   alpha_re_o,
    output reg  signed [`QDATA_W-1:0]   alpha_im_o,
    output reg  signed [`QDATA_W-1:0]   beta_re_o,
    output reg  signed [`QDATA_W-1:0]   beta_im_o
);
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            alpha_re_o <= `Q1_KET0_ALPHA_RE;
            alpha_im_o <= `Q1_KET0_ALPHA_IM;
            beta_re_o  <= `Q1_KET0_BETA_RE;
            beta_im_o  <= `Q1_KET0_BETA_IM;
        end
        else if (en_i) begin
            alpha_re_o <= alpha_re_i;
            alpha_im_o <= alpha_im_i;
            beta_re_o  <= beta_re_i;
            beta_im_o  <= beta_im_i;
        end
        else begin
            alpha_re_o <= alpha_re_o;
            alpha_im_o <= alpha_im_o;
            beta_re_o  <= beta_re_o;
            beta_im_o  <= beta_im_o;
        end
    end

endmodule
