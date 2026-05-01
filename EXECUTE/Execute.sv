

module Execute(
    // control inputs
    input logic clk,
    input logic hold,
    // input logic flush,
    
    // data inputs
    input logic [3:0] inputOperation,
    input logic [3:0] inputDstAddress,
    input logic [15:0] inputSrc1,
    input logic [15:0] inputSrc2,
    input logic [7:0] inputImmediate,
    // input logic [15:0] forwardPathInput,

    // data outputs
    output logic [3:0] operation,
    output logic [15:0] out,
    output logic [3:0] writeBackDst,
    output logic enableWrite,
    output logic controlHold
);
    // forwarding path
    // output of the ALU is input for the execution state

    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediate;

    PipelineRegisterEX register(
        // inputs
        .clk(clk),
        .hold(hold),
        // .flush(flush),
        .inputOperation(inputOperation),
        .inputDstAddress(inputDstAddress),
        .inputSrc1(inputSrc1),
        .inputSrc2(inputSrc2),
        .inputImmediate(inputImmediate),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Data(localSrc1Data),
        .src2Data(localSrc2Data),
        .immediate(localImmediate)
    );


    ALU alu(
        // inputs
        .clk(clk),
        .operation(localOperation),
        .d1(localSrc1Data),
        .d2(localSrc2Data),
        .immediate(localImmediate),
        // outputs
        .out(out),
        .enableWrite(enableWrite),
        .outputOperation(operation),
        .controlHold(controlHold)
    );

    assign writeBackDst = localDstAddress;

endmodule