

module Decode(
    input logic clk,
    input logic [15:0] instruction,
    input logic [15:0] dataToStore,
    input logic [3:0] writeBackDst,
    output logic [3:0] operation,
    output logic [3:0] dstAddress,
    output logic [15:0] src1Data,
    output logic [15:0] src2Data,
    output logic [7:0] immediateOperandOutput
);
    // local signals
    logic [3:0] localOperation;  
    logic [3:0] localDstAddress;
    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;
    logic [3:0] localImmediateOperand;  


    PipelineRegister pipelineRegister(
        .clk(clk),
        .instruction(instruction),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Address(localSrc1Address),
        .src2Address(localSrc2Address),
        .immediateOperand(localImmediateOperand)
    );


    RegisterBlock registerBlock(
        .clk(clk),
        .dataToStore(dataToStore),
        .writeBackDst(writeBackDst),
        .src1Address(localSrc1Address),
        .src2Address(localSrc2Address),
        .immediateOperandInput(localImmediateOperand),
        // outputs
        .src1Data(src1Data),
        .src2Data(src2Data),
        .immediateOperandOutput(immediateOperandOutput)
    );


endmodule