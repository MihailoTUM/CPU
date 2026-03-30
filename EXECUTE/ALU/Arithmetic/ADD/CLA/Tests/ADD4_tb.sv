`timescale 1ns/1ns

module ADD4_tb();
    logic [3:0] a;
    logic [3:0] b;
    logic blockCin;
    logic [3:0] s;
    logic blockCout;

    ADD4 dut(a, b, blockCin, s, blockCout);

    initial begin
        $dumpfile("ADD4.vcd");
        $dumpvars(0, ADD4_tb);

        // normal cases
        a = 4'h0; b = 4'h3; blockCin = 0; #1;
        assert(s == 4'h3) else $error("Test 1 failed"); #1;
        assert(blockCout == 1'b0) else $error("Test 1 failed"); #1;

        a = 4'h4; b = 4'h9; blockCin = 0; #1;
        assert(s == 4'hD) else $error("Test 2 failed"); #1;
        assert(blockCout == 1'b0) else $error("Test 2 failed"); #1;

        // edge cases
        a = 4'h9; b = 4'h7; blockCin = 0; #1;
        assert(s == 4'h0) else $error("Test 3 failed"); #1;
        assert(blockCout == 1'b1) else $error("Test 3 failed"); #1;


        $finish;
    end
endmodule