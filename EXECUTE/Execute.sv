
module Execute(
    // control inputs
    input logic clk,
    input logic hold,
    input logic reset,
    
    // data inputs
    input logic [3:0] inOperation,
    input logic [3:0] inDstAddress,

    input logic [15:0] inData1,
    input logic [15:0] inData2,

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

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

    output logic outJMP,
    output logic [15:0] outAddressToRET,
    output logic outAddressToRETSignal
);

    logic [3:0] localOperation;
    logic [3:0] localDstAddress;

    logic [15:0] localData1;
    logic [15:0] localData2;

    logic [3:0] localData1Address;
    logic [3:0] localData2Address;

    logic [7:0] localImmediate;
    logic [15:0] localInstructionAddress;

    logic [15:0] localForwardPathInputExecute;
    logic [3:0] localForwardPathInputExecuteSrc;

    logic [15:0] localForwardPathInputDataMemory;
    logic [3:0] localForwardPathInputDataMemorySrc;  


    PipelineRegisterEX register(
        .clk(clk),
        .hold(hold),
        .reset(reset),

        .inOperation(inOperation),
        .inDstAddress(inDstAddress),

        .inData1(inData1),
        .inData2(inData2),
        
        .inData1Address(inData1Address),
        .inData2Address(inData2Address),

        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),

        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPathInputExecuteSrc(forwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),

        .outOperation(localOperation),
        .outDstAddress(localDstAddress),

        .outData1(localData1),
        .outData2(localData2),

        .outData1Address(localData1Address),
        .outData2Address(localData2Address),

        .outImmediate(localImmediate),
        .outInstructionAddress(localInstructionAddress),

        .forwardPathOutputExecute(localForwardPathInputExecute),
        .forwardPathOutputExecuteSrc(localForwardPathInputExecuteSrc),

        .forwardPathOutputDataMemory(localForwardPathInputDataMemory),
        .forwardPathOutputDataMemorySrc(localForwardPathInputDataMemorySrc),

    );

    logic [15:0] localResult;

    ALU alu(
        // inputs
        .clk(clk),

        .inOperation(localOperation),

        .inData1(localData1),
        .inData2(localData2),

        .inData1Address(localData1Address),
        .inData2Address(localData2Address),

        .inImmediate(localImmediate),
        .inInstructionAddress(localInstructionAddress),

        .forwardPathInputExecute(localForwardPathInputExecute),
        .forwardPathInputExecuteSrc(localForwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(localForwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(localForwardPathInputDataMemorySrc),

        .outResult(localResult),
        .outEnableWrite(outEnableWrite),
        .outOperation(outOperation),
        .controlHold(controlHold),

        .outJMP(outJMP),
        .outAddressToRET(outAddressToRET),
        .outAdressToRETSignal(outAddressToRETSignal)

    );

    assign forwardPathOutput = localResult;
    assign forwardPathSrcOutput = localWriteBackDst;
    assign outResult = localResult;
    assign outWriteBackDst = localWriteBackDst;

endmodule