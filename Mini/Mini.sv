

module Mini(
    input logic clk,
    input logic hold,
    input logic reset,

    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,

    input logic [15:0] inAddressToRET,
    input logic inAddressToRETSignal
);
    




    logic [3:0] localOutOperation;
    logic [3:0] localDstAddress;
    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediate;
    logic [15:0] localOutInstructionAddress;


    Decode decode(
        .clk(clk),
        .hold(hold),

        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),
        .inDataToStore(localOutResult),
        .inWriteBackDst(localOutWriteBackDst),
        .inEnableWrite(localOutEnableWrite),
        
        .inAddressToRET(localOutAddressToRET),
        .inAddressToRETSignal(localOutAddressToRetSignal),

        .outOperation(localOutOperation),
        .outDstAddress(localDstAddress),
        .outSrc1Address(localSrc1Address),
        .outSrc2Address(localSrc2Address),
        .outSrc1Data(localSrc1Data),
        .outSrc2Data(localSrc2Data), 
        .outImmediate(localImmediate),
        
        .outInstructionAddress(localOutInstructionAddress)
    );

    logic [15:0] localOutResult;
    logic [3:0] localOutWriteBackDst;
    logic localOutEnableWrite;  
    logic localControlHold;
    logic localControlJump;
    logic [15:0] localForwardPathOutput;
    logic [3:0] localForwardPathSrcOutput;

    logic outJMP;
    logic [15:0] localOutAddressToRET;
    logic localOutAddressToRetSignal;
    logic [3:0] localOperation;

    Execute execute(
        .clk(clk),
        .hold(hold),
        .reset(reset),

        .inOperation(localOutOperation),
        .inDstAddress(localDstAddress),
        .inSrc1Address(localSrc1Address),
        .inSrc2Address(localSrc2Address),
        .inSrc1(localSrc1Data),
        .inSrc2(localSrc2Data),
        .inImmediate(localImmediate),
        .inInstructionAddress(localOutInstructionAddress),

        .forwardPathInputExecute(localForwardPathOutput),
        .forwardPathInputExecuteSrc(localForwardPathSrcOutput),

        .forwardPathInputDataMemory(16'h0000),
        .forwardPathInputDataMemorySrc(4'hA),

        .outResult(localOutResult),
        .outWriteBackDst(localOutWriteBackDst),
        .outEnableWrite(localOutEnableWrite),
        .outOperation(localOperation),
        .controlHold(localControlHold),
        .controlJump(localControlJump),
        .forwardPathOutput(localForwardPathOutput),
        .forwardPathSrcOutput(localForwardPathSrcOutput),
        
        .outJMP(outJMP),
        .outAddressToRET(localOutAddressToRET),
        .outAddressToRETSignal(localOutAddressToRetSignal)
    );


endmodule