

module CPU(
    input logic clk,
    input logic [15:0] instruction,
);
    // local inputs for decode
    logic [15:0] localDataToStore;
    logic [3:0] localWriteBackDst;

    // local outputs for decode
    logic [3:0] operation;
    logic [3:0] dstAddress;
    logic [15:0] src1Data;
    logic [15:0] src2Data;
    logic [7:0] immediateOperandOutput;


    // DECODE-stage
    DECODE decode(
        // inputs
        .clk(clk),
        .instruction(instruction),
        .dataToStore(localDataToStore),
        .writeBackDst(localWriteBackDst),
        // outputs
        .operation(operation),
        .dstAddress(dstAddress),
        .src1Data(src1Data),
        .src2Data(src2Data),
        .immediateOperandOutput(immediateOperandOutput)
    );

    // EXECUTE-stage
    EXECUTE execute();


endmodule