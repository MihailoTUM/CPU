`timescale 1ns/1ns

module Execute_tb();
    logic clk;
    logic [3:0] operation;
    logic [3:0] dstAddress;
    logic [15:0] src1Data;
    logic [15:0] src2Data;
    logic [7:0] immediateOperandOutput;

    Execute dut(
        .clk(clk),
        .operationIn(operation),
        .dstAddressIn(dstAddress),
        .src1DataIn(src1Data),
        .src2DataIn(src2Data),
        .immediateOperandOutputIn(immediateOperandOutput)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);

        // add
        operation = 4'h1; dstAddress = 4'h0; src1Data = 16'h0001; src2Data = 16'h0003; immediateOperandOutput = 8'hXX;
        #4;

        operation = 4'h0; dstAddress = 4'hA; src1Data = 16'hXXXX; src2Data = 16'hXXXX; immediateOperandOutput = 8'h0C;
        #4;


        $finish;
    end

endmodule