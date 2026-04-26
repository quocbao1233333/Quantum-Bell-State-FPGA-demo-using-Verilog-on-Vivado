`ifndef QCFG_DEFS_VH
`define QCFG_DEFS_VH
`define QDATA_W        16
`define QFRAC_W        14
`define QINT_W         2
`define QMSB           (`QDATA_W-1)
`define QLSB           0

`define Q_ZERO         16'sd0
`define Q_ONE          16'sd16384
`define Q_NEG_ONE     (-16'sd16384)

`define Q_HALF         16'sd8192
`define Q_NEG_HALF    (-16'sd8192)

`define Q_TWO          16'sd32768
`define Q_NEG_TWO     (-16'sd32768)

// 1/sqrt(2) ~= 0.7071067811865476
// 0.7071067811865476 * 2^14 = 11585.2375 -> làm tròn thành 11585
`define Q_INV_SQRT2    16'sd11585
`define Q_NEG_INV_SQRT2 (-16'sd11585)

// ------------------------------------------------------------
// 3) Biên ?? kh?i t?o chu?n cho 1 qubit
//
// |0> : alpha = 1, beta = 0
// |1> : alpha = 0, beta = 1
`define Q1_KET0_ALPHA_RE   `Q_ONE
`define Q1_KET0_ALPHA_IM   `Q_ZERO
`define Q1_KET0_BETA_RE    `Q_ZERO
`define Q1_KET0_BETA_IM    `Q_ZERO

`define Q1_KET1_ALPHA_RE   `Q_ZERO
`define Q1_KET1_ALPHA_IM   `Q_ZERO
`define Q1_KET1_BETA_RE    `Q_ONE
`define Q1_KET1_BETA_IM    `Q_ZERO

// |+> = (|0> + |1>) / sqrt(2)
`define Q1_KETP_ALPHA_RE   `Q_INV_SQRT2
`define Q1_KETP_ALPHA_IM   `Q_ZERO
`define Q1_KETP_BETA_RE    `Q_INV_SQRT2
`define Q1_KETP_BETA_IM    `Q_ZERO

// |-> = (|0> - |1>) / sqrt(2)
`define Q1_KETM_ALPHA_RE   `Q_INV_SQRT2
`define Q1_KETM_ALPHA_IM   `Q_ZERO
`define Q1_KETM_BETA_RE    `Q_NEG_INV_SQRT2
`define Q1_KETM_BETA_IM    `Q_ZERO

// ------------------------------------------------------------
// 4) Biên ?? kh?i t?o chu?n cho h? 2 qubit
// Th? t? tr?ng thái c? s? c? ??nh:
// |00>, |01>, |10>, |11>
// ------------------------------------------------------------

// |00>
`define Q2_KET00_A00_RE    `Q_ONE
`define Q2_KET00_A00_IM    `Q_ZERO
`define Q2_KET00_A01_RE    `Q_ZERO
`define Q2_KET00_A01_IM    `Q_ZERO
`define Q2_KET00_A10_RE    `Q_ZERO
`define Q2_KET00_A10_IM    `Q_ZERO
`define Q2_KET00_A11_RE    `Q_ZERO
`define Q2_KET00_A11_IM    `Q_ZERO

// |01>
`define Q2_KET01_A00_RE    `Q_ZERO
`define Q2_KET01_A00_IM    `Q_ZERO
`define Q2_KET01_A01_RE    `Q_ONE
`define Q2_KET01_A01_IM    `Q_ZERO
`define Q2_KET01_A10_RE    `Q_ZERO
`define Q2_KET01_A10_IM    `Q_ZERO
`define Q2_KET01_A11_RE    `Q_ZERO
`define Q2_KET01_A11_IM    `Q_ZERO

// |10>
`define Q2_KET10_A00_RE    `Q_ZERO
`define Q2_KET10_A00_IM    `Q_ZERO
`define Q2_KET10_A01_RE    `Q_ZERO
`define Q2_KET10_A01_IM    `Q_ZERO
`define Q2_KET10_A10_RE    `Q_ONE
`define Q2_KET10_A10_IM    `Q_ZERO
`define Q2_KET10_A11_RE    `Q_ZERO
`define Q2_KET10_A11_IM    `Q_ZERO

// |11>
`define Q2_KET11_A00_RE    `Q_ZERO
`define Q2_KET11_A00_IM    `Q_ZERO
`define Q2_KET11_A01_RE    `Q_ZERO
`define Q2_KET11_A01_IM    `Q_ZERO
`define Q2_KET11_A10_RE    `Q_ZERO
`define Q2_KET11_A10_IM    `Q_ZERO
`define Q2_KET11_A11_RE    `Q_ONE
`define Q2_KET11_A11_IM    `Q_ZERO


`define QBELL_PHI_PLUS_A00_RE   `Q_INV_SQRT2
`define QBELL_PHI_PLUS_A00_IM   `Q_ZERO
`define QBELL_PHI_PLUS_A01_RE   `Q_ZERO
`define QBELL_PHI_PLUS_A01_IM   `Q_ZERO
`define QBELL_PHI_PLUS_A10_RE   `Q_ZERO
`define QBELL_PHI_PLUS_A10_IM   `Q_ZERO
`define QBELL_PHI_PLUS_A11_RE   `Q_INV_SQRT2
`define QBELL_PHI_PLUS_A11_IM   `Q_ZERO
// Chuy?n s? nguyên sang fixed-point Q2.14
`define Q_FROM_INT(x)      ((x) <<< `QFRAC_W)

// Nhân 2 s? fixed-point r?i scale l?i v? Q2.14
`define Q_MUL(a,b)         (((a) * (b)) >>> `QFRAC_W)

`define Q_EPSILON          16'sd2

`endif
