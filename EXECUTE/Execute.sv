

module Execute(
    input logic clk,
    input logic [3:0] operationIn,
    input logic [3:0] dstAddressIn,
    input logic [15:0] src1DataIn,
    input logic [15:0] src2DataIn,
    input logic [7:0] immediateOperandOutputIn,
    output logic [15:0] result,
    output logic [3:0] writeBackDst,
    output logic enableWrite
);

    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediateOperandOutput;

    PipelineRegisterEX register(
        // inputs
        .clk(clk),
        .operationIn(operationIn),
        .dstAddressIn(dstAddressIn),
        .src1DataIn(src1DataIn),
        .src2DataIn(src2DataIn),
        .immediateOperandOutputIn(immediateOperandOutputIn),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Data(localSrc1Data),
        .src2Data(localSrc2Data),
        .immediateOperandOutput(localImmediateOperandOutput),
        .writeBackDst(writeBackDst)
    );

    ALU alu(
        // inputs
        .operation(localOperation),
        .data1(localSrc1Data),
        .data2(localSrc2Data),
        .immediateOperand(localImmediateOperandOutput),
        // outputs
        .result(result),
        .enableWrite(enableWrite)
    );

endmodule