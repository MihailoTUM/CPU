`timescale 1ns/1ns

module Registerblock_tb();
    logic clk;
    logic reset;
    logic we;
    logic [2:0] dst;
    logic [2:0] source1;
    logic [2:0] source2; 
    logic [15:0] dataIn;
    logic [15:0] out1;
    logic [15:0] out2;

    Registerblock dut(
        .clk(clk),
        .reset(reset),
        .we(we),
        .dst(dst),
        .source1(source1),
        .source2(source2),
        .dataIn(dataIn),
        .out1(out1),
        .out2(out2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("Register.vcd");
        $dumpvars(0, Registerblock_tb);

        // reset
        reset = 1; #10;

        // write
        reset = 0; dst = 3'b000; dataIn = 16'hFFFF; #10;

        dst = 3'b001; dataIn = 16'h00FF; #10;

        // read
        source1 = 3'b000; source2 = 3'b001; #10;

        $finish;
    end
endmodule