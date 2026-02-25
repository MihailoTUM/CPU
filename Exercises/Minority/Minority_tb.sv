`timescale 1ns/1ns

module Minority_tb;
    logic a;
    logic b;
    logic c;
    logic s;

    Minority dut(a, b, c, s);

    initial begin
        $dumpfile("Minority.vcd");
        $dumpvars(0, Minority_tb);

        a = 0; b = 0; c = 0;
        #1; 
        assert(s == 1) else $error("000 failed"); #1;

        a = 0; b = 0; c = 1;
        #1;
        assert(s == 1) else $error("001 failed"); #1;

        a = 0; b = 1; c = 0;
        #1;
        assert(s == 1) else $error("010 failed"); #1;

        a = 0; b = 1; c = 1;
        #1;
        assert(s == 0) else $error("011 failed"); #1;

        a = 1; b = 0; c = 0;
        #1;
        assert(s == 1) else $error("100 failed"); #1;

        a = 1; b = 0; c = 1;
        #1;
        assert(s == 0) else $error("101 failed"); #1;

        a = 1; b = 1; c = 0;
        #1;
        assert(s == 0) else $error("110 failed"); #1;

        a = 1; b = 1; c = 1;
        #1;
        assert(s == 0) else $error("111 failed"); #1;

        $finish;
    end

endmodule;