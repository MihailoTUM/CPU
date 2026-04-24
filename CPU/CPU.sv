

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

    logic [15:0] writeToRegisterData;
    logic [3:0] writeToRegisterDst;
    logic enableRegisterWrite;

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
        .dataToStore(writeToRegisterData),
        .writeBackDst(writeToRegisterDst),
        .enableWrite(enableRegisterWrite),
        // outputs
        .operation(localOperation),
        .dstAddress(localDstAddress),
        .src1Data(localSrc1Data),
        .src2Data(localSrc2Data),
        .immediateOperandOutput(localImmediateOperandOutput)
    );

    // EXECUTE-stage
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

    // WRITE_BACK-stage (technically does nothing except for passing data through)
    WriteBack writeBack(
        .result(localDataToStore),
        .writeBackDst(localWriteBackDst),
        .enableWrite(localEnableWrite),
        // outputs
        .writeToRegisterData(writeToRegisterData),
        .writeToRegisterDst(writeToRegisterDst),
        .enableRegisterWrite(enableRegisterWrite)
    );


endmodule