`timescale 1ns/1ns

module decoder_tb();
    logic [2:0] a;
    logic [7:0] y;

    decoder3_8 dut(a, y);

    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0, decoder_tb);

        a = 0; #2;
        assert(y == 8'h01) else $error("000 failed."); #1;

        a = 1; #2;
        assert(y == 8'h02) else $error("001 failed"); #1;

        a = 7; #2;
        assert(y == 8'h80) else $error("111 failed"); #1;

        a = 10; #2;

    end

endmodule;