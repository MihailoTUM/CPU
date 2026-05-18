

module Mini(
    input logic clk,
    input logic hold,

    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,

    input logic [15:0] inAddressToRET,
    input logic inAddressToRETSignal,

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
        .inDataToStore(),
        .inWriteBackDst(),
        .inEnableWrite(),
        
        .inAddressToRET(),
        .inAddressToRETSignal(),

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
    logic [3:0] localOutOperation;
    logic localControlHold;
    logic localControlJump;
    logic [15:0] localForwardPathOutput;
    logic [15:0] localForwardPathSrcOutput;

    logic outJMP;
    logic [15:0] localOutAddressToRET;
    logic localOutAddressToRetSignal;

    Execute execute(
        .clk(clk),
        .hold(hold),
        .reset(),

        .inOperation(),
        .inDstAddress(),
        .inSrc1Address(),
        .inSrc2Address(),
        .inSrc1(),
        .inSrc2(),
        .inImmediate(),
        .inInstructionAddress(),

        .forwardPathInputExecute(),
        .forwardPathInputExecuteSrc(),

        .forwardPathInputDataMemory(),
        .forwardPathInputDataMemorySrc(),

        .outResult(localOutResult),
        .outWriteBackDst(localOutWriteBackDst),
        .outEnableWrite(localOutEnableWrite),
        .outOperation(localOperation),
        .controlHold(localControlHold),
        .controlJump(localControlJump),
        .forwardPathOutput(localForwardPathOutput),
        .forwardPahtSrcOutput(localForwardPathSrcOutput),
        
        .outJMP(outJMP),
        .outAddressToRET(localOutAddressToRET),
        .outAddressToRETSignal(localOutAddressToRetSignal)
    );


endmodule