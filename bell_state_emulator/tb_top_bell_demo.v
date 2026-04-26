`timescale 1ns/1ps
`include "qcfg_defs.vh"

module tb_top_bell_demo;

    // ============================================================
    // 1) Tin hieu dieu khien dua vao top
    // ============================================================
    reg clk_i;
    reg rst_i;
    reg en_i;

    // ============================================================
    // 2) Tin hieu output cua top_bell_demo
    //    Day chinh la trang thai cuoi cung sau REG2
    // ============================================================
    wire signed [`QDATA_W-1:0] a00_re_o;
    wire signed [`QDATA_W-1:0] a00_im_o;
    wire signed [`QDATA_W-1:0] a01_re_o;
    wire signed [`QDATA_W-1:0] a01_im_o;
    wire signed [`QDATA_W-1:0] a10_re_o;
    wire signed [`QDATA_W-1:0] a10_im_o;
    wire signed [`QDATA_W-1:0] a11_re_o;
    wire signed [`QDATA_W-1:0] a11_im_o;

    // ============================================================
    // 3) Bien dem loi
    // ============================================================
    integer err_count;

    // ============================================================
    // 4) DUT = Device Under Test
    // ============================================================
    top_bell_demo uut (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .en_i     (en_i),

        .a00_re_o (a00_re_o),
        .a00_im_o (a00_im_o),
        .a01_re_o (a01_re_o),
        .a01_im_o (a01_im_o),
        .a10_re_o (a10_re_o),
        .a10_im_o (a10_im_o),
        .a11_re_o (a11_re_o),
        .a11_im_o (a11_im_o)
    );

    // ============================================================
    // 5) Tao clock 10 ns
    //    Canh len tai: 5 ns, 15 ns, 25 ns, 35 ns, 45 ns, ...
    // ============================================================
    always #5 clk_i = ~clk_i;

    // ============================================================
    // 6) Task kiem tra mot tin hieu voi sai so cho phep rat nho
    // ============================================================
    task check_sig;
        input integer actual;
        input integer expected;
        input [127:0] sig_name;
        begin
            if ((actual < (expected - `Q_EPSILON)) ||
                (actual > (expected + `Q_EPSILON))) begin
                $display("FAIL %0s : got=%0d expected=%0d", sig_name, actual, expected);
                err_count = err_count + 1;
            end
            else begin
                $display("PASS %0s : got=%0d expected~=%0d", sig_name, actual, expected);
            end
        end
    endtask

    // ============================================================
    // 7) Kiem tra output cuoi cua top dang la |00>
    // ============================================================
    task check_top_is_ket00;
        input [255:0] test_name;
        begin
            $display("--------------------------------------------------");
            $display("%0s", test_name);
            check_sig($signed(a00_re_o), `Q_ONE,  "top.a00_re_o");
            check_sig($signed(a00_im_o), `Q_ZERO, "top.a00_im_o");
            check_sig($signed(a01_re_o), `Q_ZERO, "top.a01_re_o");
            check_sig($signed(a01_im_o), `Q_ZERO, "top.a01_im_o");
            check_sig($signed(a10_re_o), `Q_ZERO, "top.a10_re_o");
            check_sig($signed(a10_im_o), `Q_ZERO, "top.a10_im_o");
            check_sig($signed(a11_re_o), `Q_ZERO, "top.a11_re_o");
            check_sig($signed(a11_im_o), `Q_ZERO, "top.a11_im_o");
        end
    endtask

    // ============================================================
    // 8) Kiem tra REG0 dang la |00>
    //    Dung hierarchical reference vao ben trong uut
    // ============================================================
    task check_reg0_is_ket00;
        input [255:0] test_name;
        begin
            $display("--------------------------------------------------");
            $display("%0s", test_name);
            check_sig($signed(uut.reg0_a00_re_w), `Q_ONE,  "reg0_a00_re_w");
            check_sig($signed(uut.reg0_a00_im_w), `Q_ZERO, "reg0_a00_im_w");
            check_sig($signed(uut.reg0_a01_re_w), `Q_ZERO, "reg0_a01_re_w");
            check_sig($signed(uut.reg0_a01_im_w), `Q_ZERO, "reg0_a01_im_w");
            check_sig($signed(uut.reg0_a10_re_w), `Q_ZERO, "reg0_a10_re_w");
            check_sig($signed(uut.reg0_a10_im_w), `Q_ZERO, "reg0_a10_im_w");
            check_sig($signed(uut.reg0_a11_re_w), `Q_ZERO, "reg0_a11_re_w");
            check_sig($signed(uut.reg0_a11_im_w), `Q_ZERO, "reg0_a11_im_w");
        end
    endtask

    // ============================================================
    // 9) Kiem tra REG1 dang la trang thai sau H:
    //    (|00> + |10>) / sqrt(2)
    // ============================================================
    task check_reg1_is_after_h;
        input [255:0] test_name;
        begin
            $display("--------------------------------------------------");
            $display("%0s", test_name);
            check_sig($signed(uut.reg1_a00_re_w), `Q_INV_SQRT2, "reg1_a00_re_w");
            check_sig($signed(uut.reg1_a00_im_w), `Q_ZERO,      "reg1_a00_im_w");
            check_sig($signed(uut.reg1_a01_re_w), `Q_ZERO,      "reg1_a01_re_w");
            check_sig($signed(uut.reg1_a01_im_w), `Q_ZERO,      "reg1_a01_im_w");
            check_sig($signed(uut.reg1_a10_re_w), `Q_INV_SQRT2, "reg1_a10_re_w");
            check_sig($signed(uut.reg1_a10_im_w), `Q_ZERO,      "reg1_a10_im_w");
            check_sig($signed(uut.reg1_a11_re_w), `Q_ZERO,      "reg1_a11_re_w");
            check_sig($signed(uut.reg1_a11_im_w), `Q_ZERO,      "reg1_a11_im_w");
        end
    endtask

    // ============================================================
    // 10) Kiem tra output cuoi cua top dang la Bell state:
    //     (|00> + |11>) / sqrt(2)
    // ============================================================
    task check_top_is_bell;
        input [255:0] test_name;
        begin
            $display("--------------------------------------------------");
            $display("%0s", test_name);
            check_sig($signed(a00_re_o), `Q_INV_SQRT2, "top.a00_re_o");
            check_sig($signed(a00_im_o), `Q_ZERO,      "top.a00_im_o");
            check_sig($signed(a01_re_o), `Q_ZERO,      "top.a01_re_o");
            check_sig($signed(a01_im_o), `Q_ZERO,      "top.a01_im_o");
            check_sig($signed(a10_re_o), `Q_ZERO,      "top.a10_re_o");
            check_sig($signed(a10_im_o), `Q_ZERO,      "top.a10_im_o");
            check_sig($signed(a11_re_o), `Q_INV_SQRT2, "top.a11_re_o");
            check_sig($signed(a11_im_o), `Q_ZERO,      "top.a11_im_o");
        end
    endtask

    // ============================================================
    // 11) Kich ban mo phong toan he
    //
    // Pipeline cua top:
    //   qstate_bell_init -> REG0 -> H -> REG1 -> CNOT -> REG2 -> output
    //
    // Kich ban:
    //   A) Reset he ve |00>
    //   B) Giu en_i = 0 de he dung yen
    //   C) Bat en_i = 1 cho pipeline chay
    //      - Canh len thu 1: REG1 co trang thai sau H, output van |00>
    //      - Canh len thu 2: output ra Bell state
    //   D) Reset lai de kiem tra phuc hoi
    // ============================================================
    initial begin
        // --------------------------------------------------------
        // Khoi tao tin hieu dieu khien
        // --------------------------------------------------------
        clk_i     = 1'b0;
        rst_i     = 1'b1;
        en_i      = 1'b0;
        err_count = 0;

        // --------------------------------------------------------
        // GIAI DOAN A: reset dang bat
        // Vi reset la bat dong bo muc cao, output phai ve |00> ngay
        // --------------------------------------------------------
        #1;
        check_top_is_ket00("A1: Async reset active -> top output must be |00>");

        // --------------------------------------------------------
        // Nha reset tai 12 ns, khong trung canh len
        // --------------------------------------------------------
        #11;
        rst_i = 1'b0;

        // --------------------------------------------------------
        // GIAI DOAN B: en_i = 0, pipeline phai dung yen
        //
        // Canh len tiep theo:
        //   15 ns, 25 ns
        // Vi en_i = 0, cac register giu nguyen trang thai |00>
        // --------------------------------------------------------
        @(posedge clk_i); #1;   // sau canh len 15 ns
        check_top_is_ket00("B1: After posedge 15 ns with en=0 -> top output still |00>");

        @(posedge clk_i); #1;   // sau canh len 25 ns
        check_top_is_ket00("B2: After posedge 25 ns with en=0 -> top output still |00>");

        // --------------------------------------------------------
        // Bat enable tai 28 ns, khong trung canh len
        // --------------------------------------------------------
        #2;
        en_i = 1'b1;

        // --------------------------------------------------------
        // GIAI DOAN C1: canh len huu hieu thu nhat sau khi en=1
        // Tai 35 ns:
        //   REG0 <= |00>
        //   REG1 <= H(|00>) = (|00> + |10>) / sqrt(2)
        //   REG2 <= CNOT(REG1_cu) = |00>
        //
        // Vi REG2 van nhan gia tri cu cua REG1, nen output cuoi
        // tai thoi diem nay VAN la |00>
        // --------------------------------------------------------
        @(posedge clk_i); #1;   // sau canh len 35 ns
        check_reg0_is_ket00("C1.1: After posedge 35 ns -> REG0 must be |00>");
        check_reg1_is_after_h("C1.2: After posedge 35 ns -> REG1 must be H-state");
        check_top_is_ket00("C1.3: After posedge 35 ns -> top output still |00>");

        // --------------------------------------------------------
        // GIAI DOAN C2: canh len huu hieu thu hai sau khi en=1
        // Tai 45 ns:
        //   REG2 <= CNOT(REG1_cu)
        //        <= CNOT((|00> + |10>) / sqrt(2))
        //        <= (|00> + |11>) / sqrt(2)
        //
        // Day chinh la Bell state muc tieu
        // --------------------------------------------------------
        @(posedge clk_i); #1;   // sau canh len 45 ns
        check_reg1_is_after_h("C2.1: After posedge 45 ns -> REG1 remains H-state");
        check_top_is_bell("C2.2: After posedge 45 ns -> top output must be Bell state");

        // --------------------------------------------------------
        // GIAI DOAN C3: them mot canh len nua de kiem tra Bell state on dinh
        // Tai 55 ns, output van phai giu Bell state
        // --------------------------------------------------------
        @(posedge clk_i); #1;   // sau canh len 55 ns
        check_top_is_bell("C3: After posedge 55 ns -> Bell state remains stable");

        // --------------------------------------------------------
        // GIAI DOAN D: bat reset lai
        // Reset bat dong bo muc cao, output phai ve |00> ngay
        // --------------------------------------------------------
        #2;                     // den 58 ns
        rst_i = 1'b1;
        #1;                     // den 59 ns
        check_top_is_ket00("D1: Re-assert async reset -> top output back to |00>");

        // --------------------------------------------------------
        // Tong ket
        // --------------------------------------------------------
        $display("==================================================");
        if (err_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TOTAL ERRORS = %0d", err_count);

        $finish;
    end

endmodule
