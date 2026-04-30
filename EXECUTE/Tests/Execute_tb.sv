`timescale 1ns/1ns

module Execute_tb();
    logic clk;
    logic hold;
    logic [3:0] operation;
    logic [3:0] dstAddress;
    logic [15:0] src1Data;
    logic [15:0] src2Data;
    logic [7:0] immediate;
    logic [15:0] out;

    Execute dut(
        .clk(clk),
        .hold(hold),
        .inputOperation(operation),
        .inputDstAddress(dstAddress),
        .inputSrc1(src1Data),
        .inputSrc2(src2Data),
        .inputImmediate(immediate),
        .out(out)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);

        // add
        hold = 1'b0; operation = 4'h1; dstAddress = 4'h0; src1Data = 16'h0001; src2Data = 16'h0003; immediate = 8'hXX;
        #4;

        hold = 1'b1; operation = 4'h0; dstAddress = 4'hA; src1Data = 16'hXXXX; src2Data = 16'hXXXX; immediate = 8'h0C;
        #4;


        $finish;
    end

endmodule