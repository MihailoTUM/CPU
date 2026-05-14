

module Execute(
    // control inputs
    input logic clk,
    input logic hold,
    // input logic flush,
    
    // data inputs
    input logic [3:0] inOperation,
    input logic [3:0] inDstAddress,
    input logic [3:0] inSrc1Address,
    input logic [3:0] inSrc2Address,
    input logic [15:0] inSrc1,
    input logic [15:0] inSrc2,
    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,
    input logic [15:0] inStackPointerAddress,

    // forward path from Execute stage
    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    // forward path from DataMemory stage
    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [15:0] outResult,
    output logic [3:0] outWriteBackDst,
    output logic outEenableWrite,
    output logic [3:0] outOperation,
    output logic controlHold,
    output logic controlJump,
    output logic [15:0] forwardPathOutput,
    output logic [3:0] forwardPathSrcOutput
);
    // forwarding path
    // output of the ALU is input for the execution state

    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
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
    logic [15:0] localStackPointerAddress;

    PipelineRegisterEX register(
        // inputs
        .clk(clk),
        .hold(hold),
        // .flush(flush),

        .inOperation(inOperation),
        .inDstAddress(inDstAddress),
        .inSrc1Address(inSrc1Address),
        .inSrc2Address(inSrc2Address),
        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),
        .inStackPointerAddress(inStackPointerAddress),

        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPahtInputExecuteSrc(forwardPathInputExecuteSrc),
        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),

        .outOperation(localOperation),
        .outDstAddress(localDstAddress),
        .outSrc1Data(localSrc1Data),
        .outSrc2Data(localSrc2Data),
        .outImmediate(localImmediate),

        .forwardPathOutputExecute(localForwardPathInputExecute),
        .forwardPathOutputExecuteSrc(localForwardPathInputExecuteSrc),

        .forwardPathOutputDataMemory(localForwardPathInputDataMemory),
        .forwardPathOutputDataMemorySrc(localForwardPathInputDataMemorySrc),

        .outInstructionAddress(localInstructionAddress),
        .outStackPointerAddress(localInstructionAddress),

        .outSrc1Address(localSrc1Address),
        .outSrc2Address(localSrc2Address)
    );

    ALU alu(
        // inputs
        .clk(clk),
        .operation(localOperation),
        .beforeAddress(localForwardPathSrcInput),
        .d1(localSrc1Data),
        .d2(localSrc2Data),
        .immediate(localImmediate),
        .forwardPathInput(localForwardPathInput),
        .forwardPathInputSrc(localForwardPathSrcInput),
        .forwardSrc1Address(localSrc1Address),
        .forwardSrc2Address(localSrc2Address),

        
        .out(out),
        .enableWrite(enableWrite),
        .outputOperation(operation),
        .controlHold(controlHold)
    );

    assign writeBackDst = localDstAddress;
    assign forwardPathOutput = out;
    assign forwardPathSrcOutput = localDstAddress;

endmodule