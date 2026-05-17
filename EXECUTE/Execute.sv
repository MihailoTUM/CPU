
module Execute(
    // control inputs
    input logic clk,
    input logic hold,
    input logic reset,
    
    // data inputs
    input logic [3:0] inOperation,
    input logic [3:0] inDstAddress,
    input logic [3:0] inSrc1Address,
    input logic [3:0] inSrc2Address,
    input logic [15:0] inSrc1,
    input logic [15:0] inSrc2,
    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    // forward path from Execute stage
    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    // forward path from DataMemory stage
    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [15:0] outResult,
    output logic [3:0] outWriteBackDst,
    output logic outEnableWrite,
    output logic [3:0] outOperation,
    output logic controlHold,
    output logic controlJump,
    output logic [15:0] forwardPathOutput,
    output logic [3:0] forwardPathSrcOutput,

    output logic outJMP
);
    // forwarding path
    // output of the ALU is input for the execution state

    logic [3:0] localOperation;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediate;

    logic [15:0] localForwardPathInputExecute;
    logic [3:0] localForwardPathInputExecuteSrc;

    logic [15:0] localForwardPathInputDataMemory;
    logic [3:0] localForwardPathInputDataMemorySrc;  

    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;

    logic [15:0] localInstructionAddress;

    logic [3:0] localWriteBackDst;
 
    PipelineRegisterEX register(
        // inputs
        .clk(clk),
        .hold(hold),
        .reset(reset),

        .inOperation(inOperation),
        .inDstAddress(inDstAddress),
        .inSrc1Address(inSrc1Address),
        .inSrc2Address(inSrc2Address),

        .inSrc1(inSrc1),
        .inSrc2(inSrc2),
        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),

        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPathInputExecuteSrc(forwardPathInputExecuteSrc),
        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),

        .outOperation(localOperation),
        .outDstAddress(localWriteBackDst),
        .outSrc1Data(localSrc1Data),
        .outSrc2Data(localSrc2Data),
        .outImmediate(localImmediate),

        .forwardPathOutputExecute(localForwardPathInputExecute),
        .forwardPathOutputExecuteSrc(localForwardPathInputExecuteSrc),

        .forwardPathOutputDataMemory(localForwardPathInputDataMemory),
        .forwardPathOutputDataMemorySrc(localForwardPathInputDataMemorySrc),

        .outInstructionAddress(localInstructionAddress),
        .outStackPointerAddress(localStackPointerAddress),

        .outSrc1Address(localSrc1Address),
        .outSrc2Address(localSrc2Address)
    );

    logic [15:0] localResult;

    ALU alu(
        // inputs
        .clk(clk),

        .inOperation(localOperation),
        .inData1(localSrc1Data),
        .inData2(localSrc2Data),
        .inImmediate(localImmediate),
        .inInstructionAddress(localInstructionAddress),

        .srcRegister1(localSrc1Address),
        .srcRegister2(localSrc2Address),

        .forwardPathInputExecute(localForwardPathInputExecute),
        .forwardPathInputExecuteSrc(localForwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(localForwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(localForwardPathInputDataMemorySrc),

        .outResult(localResult),
        .outEnableWrite(outEnableWrite),
        .outOperation(outOperation),
        .controlHold(controlHold),

        .outJMP(outJMP)
    );

    assign forwardPathOutput = localResult;
    assign forwardPathSrcOutput = localWriteBackDst;
    assign outResult = localResult;
    assign outWriteBackDst = localWriteBackDst;

endmodule