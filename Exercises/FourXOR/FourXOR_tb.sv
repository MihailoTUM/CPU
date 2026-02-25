`timescale 1ns/1ns

module FourXOR_tb();
    logic [3:0] a;
    logic y;

    FourXOR dut(a, y);

    initial begin
        $dumpfile("FourXOR.vcd");
        $dumpvars(0, FourXOR_tb);

        a = 4'h0;
        assert(y == 0) else $error("0000 failed!");
        #1;

        a = 4'h1;
        assert(y == 1) else $error("0001 failed!");
        #1;

        a = 4'hF;
        assert(y == 0) else $error("1111 failed!");
        #1;
        
        $finish;
    end
endmodule