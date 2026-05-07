

module Execute(
    // control inputs
    input logic clk,
    input logic hold,
    // input logic flush,
    
    // data inputs
    input logic [3:0] inputOperation,
    input logic [3:0] inputDstAddress,
    input logic [3:0] inputSrc1Address,
    input logic [3:0] inputSrc2Address,
    input logic [15:0] inputSrc1,
    input logic [15:0] inputSrc2,
    input logic [7:0] inputImmediate,
    input logic [15:0] forwardPathInput,
    input logic [3:0] forwardPathSrcInput,

    // data outputs
    output logic [15:0] out,
    output logic [3:0] writeBackDst,
    output logic enableWrite,
    output logic [3:0] operation,
    output logic controlHold,
    output logic controlJump;
    output logic [15:0] forwardPathOutput;
    output logic [15:0] forwardPathSrcOutput;
);
    // forwarding path
    // output of the ALU is input for the execution state

    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediate;
    logic [15:0] localForwardPathInput;
    logic [3:0] localForwardPathSrcInput;

    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;

    PipelineRegisterEX register(
        // inputs
        .clk(clk),
        .hold(hold),
        // .flush(flush),

        .inputOperation(inputOperation),
        .inputDstAddress(inputDstAddress),
        .inputSrc1Address(inputSrc1Address),
        .inputSrc2Address(inputSrc2Address),

        .inputSrc1(inputSrc1),
        .inputSrc2(inputSrc2),
        .inputImmediate(inputImmediate),
        .forwardPathInput(forwardPathInput),
        .forwardPathSrcInput(forwardPathSrcInput),
   
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Data(localSrc1Data),
        .src2Data(localSrc2Data),
        .immediate(localImmediate),
        .forwardPathOutput(localForwardPathInput),
        .forwardPathSrcOutput(localForwardPathSrcInput),
        .outputSrc1Address(localSrc1Address),
        .outputSrc2Address(localSrc2Address)
    );


    ALU alu(
        // inputs
        .clk(clk),
        .operation(localOperation),
        .d1(localSrc1Data),
        .d2(localSrc2Data),
        .immediate(localImmediate),
        .forwardPathInput(localForwardPathInput),
        .forwardPathInputSrc(localForwardPathSrcInput),
        .forwardSrc1Address(localSrc1Address),
        .forwardSrc2Address(localSrc2Address),
        .dstAddress(localDstAddress),

        .out(out),
        .enableWrite(enableWrite),
        .outputOperation(operation),
        .controlHold(controlHold)
    );

    assign writeBackDst = localDstAddress;
    assign forwardPathOutput = out;
    assign forwardPathSrcOutput = localDstAddress;

endmodule