`timescale 1ns/1ns

module CarryLookAhead4_tb();
    logic [3:0] a;
    logic [3:0] b;
    logic blockCin;
    logic [3:0] s;
    logic blockCout;

    CarryLookAhead4 dut(a, b, blockCin, s, blockCout);

    initial begin
        $dumpfile("Carry4.vcd");
        $dumpvars(0, CarryLookAhead4_tb);

        a = 4'h0; b = 4'h3; blockCin = 0; #1;
        assert(s == 4'h3) else $error("false 2"); #1;

        a = 4'h4; b = 4'h9; blockCin = 0; #1;
        assert(s == 4'hD) else $error("false 2"); #1;

        $finish;
    end

endmodule