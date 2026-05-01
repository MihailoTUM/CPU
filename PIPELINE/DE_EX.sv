

module DE_EX(
    input logic clk,
    input logic hold,
    input logic [15:0] instruction,
    output logic controlHold
);
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediate;


    Decode decode(
        // inputs
        .clk(clk),
        .hold(hold),
        .instruction(instruction),
        .dataToStore(localALUresult),
        .writeBackDst(localWriteBackDst),
        .enableWrite(localEnableWrite),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Data(localSrc1Data),
        .src2Data(localSrc2Data),
        .immediateOperandOutput(localImmediate)
    );

    logic [15:0] localALUresult;
    logic [3:0] localWriteBackDst;
    logic localEnableWrite;

    Execute execute(
        // inputs
        .clk(clk),
        .hold(hold),
        .inputOperation(localOperation),
        .inputDstAddress(localDstAddress),
        .inputSrc1(localSrc1Data),
        .inputSrc2(localSrc2Data),
        .inputImmediate(localImmediate),
        // outputs
        .operation(),
        .out(localALUresult),
        .writeBackDst(localWriteBackDst),
        .enableWrite(localEnableWrite),
        .controlHold(controlHold)
    );

endmodule