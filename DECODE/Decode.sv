

module Decode(
    // control inputs
    input logic clk,
    input logic hold,
    // input logic flush,
    // input logic reset,

    // data inputs
    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,
    input logic [15:0] inDataToStore,
    input logic [3:0] inWriteBackDst,
    input logic inEnableWrite,

    // for CALL/RET
    input logic [15:0] inDataResultSkippy,
    input logic inDataResultSkippySignal,

    // data outputs
    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,
    output logic [3:0] outSrc1Address,
    output logic [3:0] outSrc2Address,
    output logic [15:0] outSrc1Data,
    output logic [15:0] outSrc2Data,
    output logic [7:0] outImmediate,

    output logic [15:0] outInstructionAddress
);
    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;
    logic [7:0] localImmediate;  
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;

    PipelineRegisterDE pipelineRegister(
        .clk(clk),
        .hold(hold),
        // .flush(flush),
        
        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),

        .outInstructionAddress(outInstructionAddress),
        .outOperation(localOperation),
        .outDstAddress(localDstAddress),
        .outSrc1Address(localSrc1Address),
        .outSrc2Address(localSrc2Address),
        .outImmediate(localImmediate)
    );

    RegisterBlock registerBlock(
        .clk(clk),
        
        .inOperation(localOperation),
        .inDataToStore(inDataToStore),
        .inDstAddress(localDstAddress),
        .inWriteBackDst(inWriteBackDst),
        .inSrc1Address(localSrc1Address),
        .inSrc2Address(localSrc2Address),
        .inImmediate(localImmediate),
        .inEnableWrite(inEnableWrite),

        .inDataResultSkippy(inDataResultSkippy),
        .inDataResultSkippySignal(inDataResultSkippySignal),

        .outSrc1Data(outSrc1Data),
        .outSrc2Data(outSrc2Data),
        .outImmediate(outImmediate)
    );

    assign outSrc1Address = localSrc1Address;
    assign outSrc2Address = localSrc2Address;
    assign outOperation = localOperation;
    assign outDstAddress = localDstAddress;

endmodule