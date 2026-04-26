`include "qcfg_defs.vh"
module fxp_mul_k_inv_sqrt2 (
    input  signed [`QDATA_W-1:0] in_i,
    output signed [`QDATA_W-1:0] out_o
);
    wire signed [(2*`QDATA_W)-1:0] mult_full_w;
    assign mult_full_w = in_i * `Q_INV_SQRT2;
    assign out_o = mult_full_w >>> `QFRAC_W;

endmodule
