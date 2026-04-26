module cpx_neg (
    input  signed [`QDATA_W-1:0] in_re_i,
    input  signed [`QDATA_W-1:0] in_im_i,

    output signed [`QDATA_W-1:0] out_re_o,
    output signed [`QDATA_W-1:0] out_im_o
);

    assign out_re_o = -in_re_i;
    assign out_im_o = -in_im_i;

endmodule
