`timescale 1ns/1ns

module Fulladder8_tb();
    logic [7:0] a;
    logic [7:0] b;
    logic cin;
    logic [7:0] s;
    logic cout;

    Fulladder8 dut(a, b, cin, s, cout);

    initial begin
        $dumpfile("Fuladder8.vcd");
        $dumpvars(0, Fulladder8_tb);

        a = 8'h01; b = 8'h03; cin = 0; #1;
        assert(s == 8'h04) else $error("Failed 1");

        $finish;
    end
    
endmodule