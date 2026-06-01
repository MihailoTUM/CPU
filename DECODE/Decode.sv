

module Decode(
    input logic clk,
    input logic hold,
    input logic flush,

    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,
    input logic [15:0] inDataToStore,
    input logic [3:0] inWriteBackDstAddress,
    input logic inWriteToRegisterEnable,

    input logic [15:0] inDataResultSkippy,
    input logic inDataResultSkippySignal,

    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,
    output logic [15:0] outData1,
    output logic [15:0] outData2,
    output logic [3:0] outData1Address,
    output logic [3:0] outData2Address,
    output logic [7:0] outImmediate,

    output logic [15:0] outInstructionAddress
);
    logic [3:0] localData1Address;
    logic [3:0] localData2Address;
    logic [7:0] localImmediate;  
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;

    PipelineRegisterDE pipelineRegister(
        .clk(clk),
        .hold(hold),
        .flush(flush),
        
        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),

        .outInstructionAddress(outInstructionAddress),
        .outOperation(localOperation),
        .outDstAddress(localDstAddress),
        .outData1Address(localData1Address),
        .outData2Address(localData2Address),
        .outImmediate(localImmediate)
    );

    RegisterBlock registerBlock(
        .clk(clk),
        
        .inOperation(localOperation),
        .inDataToStore(inDataToStore),
        .inDstAddress(localDstAddress),
        .inWriteBackDstAddress(inWriteBackDstAddress),
        .inData1Address(localData1Address),
        .inData2Address(localData2Address),
        .inImmediate(localImmediate),
        .inWriteToRegisterEnable(inWriteToRegisterEnable),

        .inDataResultSkippy(inDataResultSkippy),
        .inDataResultSkippySignal(inDataResultSkippySignal),

        .outData1(outData1),
        .outData2(outData2),
        .outImmediate(outImmediate)
    );

    assign outData1Address = localData1Address;
    assign outData2Address = localData2Address;
    assign outOperation = localOperation;
    assign outDstAddress = localDstAddress;

endmodule