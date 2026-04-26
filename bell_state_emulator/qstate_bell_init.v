`include "qcfg_defs.vh"

module qstate_bell_init (
    output wire signed [`QDATA_W-1:0] a00_re_o,
    output wire signed [`QDATA_W-1:0] a00_im_o,
    output wire signed [`QDATA_W-1:0] a01_re_o,
    output wire signed [`QDATA_W-1:0] a01_im_o,
    output wire signed [`QDATA_W-1:0] a10_re_o,
    output wire signed [`QDATA_W-1:0] a10_im_o,
    output wire signed [`QDATA_W-1:0] a11_re_o,
    output wire signed [`QDATA_W-1:0] a11_im_o
);
    assign a00_re_o = `Q2_KET00_A00_RE;
    assign a00_im_o = `Q2_KET00_A00_IM
    assign a01_re_o = `Q2_KET00_A01_RE;
    assign a01_im_o = `Q2_KET00_A01_IM;
    assign a10_re_o = `Q2_KET00_A10_RE;
    assign a10_im_o = `Q2_KET00_A10_IM;
    assign a11_re_o = `Q2_KET00_A11_RE;
    assign a11_im_o = `Q2_KET00_A11_IM;
endmodule
