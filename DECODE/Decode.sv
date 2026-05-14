

module Decode(
    // control inputs
    input logic clk,
    input logic hold,
    // input logic flush,

    // data inputs
    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,
    input logic [15:0] inDataToStore,
    input logic [3:0] inWriteBackDst,
    input logic inEnableWrite,

    // data outputs
    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,
    output logic [3:0] outSrc1Address,
    output logic [3:0] outSrc2Address,
    output logic [15:0] outSrc1Data,
    output logic [15:0] outSrc2Data,
    output logic [7:0] outImmediate,

    output logic [15:0] outInstructionAddress,
    output logic [15:0] outStackPointerAddress
);
    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;
    logic [7:0] localImmediate;  

    PipelineRegisterDE pipelineRegister(
        .clk(clk),
        .hold(hold),
        // .flush(flush),
        
        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),

        .outInstructionAddress(outInstructionAddress),
        .outOperation(outOperation),
        .outDstAddress(outDstAddress),
        .outSrc1Address(localSrc1Address),
        .outSrc2Address(localSrc2Address),
        .outImmediate(localImmediate)
    );

    RegisterBlock registerBlock(
        .clk(clk),
        
        .inDataToStore(inDataToStore),
        .inWriteBackDst(inWriteBackDst),
        .inSrc1Address(localSrc1Address),
        .inSrc2Address(localSrc2Address),
        .inImmediate(localImmediate),
        .inEnableWrite(inEnableWrite),

        .outSrc1Data(outSrc1Data),
        .outSrc2Data(outSrc2Data),
        .outImmediate(outImmediate),
        .outStackPointerAddress(outStackPointerAddress)
    );

endmodule