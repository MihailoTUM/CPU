


module Decode_tb();
    logic clk;
    logic [15:0] instruction;
    logic [15:0] dataToStore;
    logic [3:0] writeBackDst;
    logic [3:0] operation;
    logic [3:0] dstAddress;
    logic [15:0] src1Data;
    logic [15:0] src2Data;
    logic [7:0] immediateOperandOutput;

    Decode dut(
        .clk(clk),
        .
    );

endmodule