

module Decode(
    // clk
    input logic clk,
    // hold pipeline stage
    input logic hold,
    // resetting in case of wrong BRANCH prediction
    // input logic flush,
    // instruction at cycle t
    input logic [15:0] instruction,
    // data to store from cycle t-1
    input logic [15:0] dataToStore,
    // address to store from cycle t-1
    input logic [3:0] writeBackDst,
    // necessary for (stalls) NOP
    input logic enableWrite,
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
    logic [7:0] localImmediateOperand;  

    PipelineRegisterDE pipelineRegister(
        .clk(clk),
        .hold(hold),
        .flush(flush),
        .instruction(instruction),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Address(localSrc1Address),
        .src2Address(localSrc2Address),
        .immediateOperand(localImmediateOperand)
    );

    assign operation = localOperation;
    assign dstAddress = localDstAddress;


    RegisterBlock registerBlock(
        .clk(clk),
        .dataToStore(dataToStore),
        .writeBackDst(writeBackDst),
        .src1Address(localSrc1Address),
        .src2Address(localSrc2Address),
        .immediateOperandInput(localImmediateOperand),
        .enableWrite(enableWrite),
        // outputs
        .src1Data(src1Data),
        .src2Data(src2Data),
        .immediateOperandOutput(immediateOperandOutput)
    );


endmodule