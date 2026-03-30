`timescale 1ns/1ns

module SUB16_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] s;
    logic cout;

    SUB16 dut(a, b, s, cout);

    initial begin
        $dumpfile("Sub16.vcd");
        $dumpvars(0, SUB16_tb);

        a = 16'h0010; b = 16'h0001; #1;
        assert(s == 16'h000F) else $error("failed");



        $finish;
    end
endmodule