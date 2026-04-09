

module CPU(
    input logic clk,
    input logic reset
);
    // local output for fetch
    logic [15:0] instruction;

    // local inputs for decode
    logic [15:0] localDataToStore;
    logic [3:0] localWriteBackDst;

    // local outputs for decode
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediateOperandOutput;
    logic localEnableWrite;

    // FETCH-stage
    Fetch fetch(
        .clk(clk),
        .reset(reset),
        .instruction(instruction)
    );

    // DECODE-stage
    Decode decode(
        // inputs
        .clk(clk),
        .instruction(instruction),
        .dataToStore(localDataToStore),
        .writeBackDst(localWriteBackDst),
        .enableWrite(localEnableWrite),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Data(localSrc1Data),
        .src2Data(localSrc2Data),
        .immediateOperandOutput(localImmediateOperandOutput)
    );

    // EXECUTE-stage + WRITE_BACK-stage
    Execute execute(
        // inputs
        .clk(clk),
        .operationIn(localOperation),
        .dstAddressIn(localDstAddress),
        .src1DataIn(localSrc1Data),
        .src2DataIn(localSrc2Data),
        .immediateOperandOutputIn(localImmediateOperandOutput),
        // outputs
        .result(localDataToStore),
        .writeBackDst(localWriteBackDst),
        .enableWrite(localEnableWrite)
    );


endmodule