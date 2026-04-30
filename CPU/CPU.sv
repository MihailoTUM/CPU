

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

    // control outputs
    logic [1:0] controlSignals;
    logic [15:0] relativeAddress;
    logic [15:0] fixedAddress;
    logic [3:0] localOperation2;
    logic enableWrite;

    // Control-unit
    Control control(
        .clk(clk),
        .controlSignals(controlSignals)
    );

    // FETCH-stage
    Fetch fetch(
        // inputs
        .clk(clk),
        .reset(reset),
        .hold(controlSignals[0]),
        .relativeAddress(relativeAddress),
        .fixedAddress(fixedAddress),
        .enableWrite(enableWrite),
        // outputs
        .instruction(instruction)
    );

    // DECODE-stage
    Decode decode(
        // inputs
        .clk(clk),
        .hold(hold),
        .flush(flush),
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
        .hold(hold),
        .flush(flush),
        .operationIn(localOperation),
        .dstAddressIn(localDstAddress),
        .src1DataIn(localSrc1Data),
        .src2DataIn(localSrc2Data),
        .immediateOperandOutputIn(localImmediateOperandOutput),
        // outputs
        .result(localDataToStore),
        .writeBackDst(localWriteBackDst),
        .enableWrite(localEnableWrite),
        .operation(localOperation2)
    );

    // outputs for DATAMEMORY-stage
    logic [15:0] resultInputWB;
    logic [3:0] dstInputWB;
    logic enableWriteRegisterInputWB;

    // DATAMEMORY-stage
    DataMemory dataMemory(
        .clk(clk),
        .ALUResult(localDataToStore),
        .writeBackALUResultDst(localWriteBackDst),
        .writeBackEnable(localEnableWrite),
        .operation(localOperation2),
        .resultToWriteBack(resultInputWB),
        .distToWriteBack(dstInputWB),
        .enableToWriteBack(enableWriteRegisterInputWB)
    );


    // WRITE_BACK-stage (technically does nothing except for passing data through)
    WriteBack writeBack(
        .result(resultInputWB),
        .writeBackDst(dstInputWB),
        .enableWrite(enableWriteRegisterInputWB),
        // outputs
        .writeToRegisterData(writeToRegisterData),
        .writeToRegisterDst(writeToRegisterDst),
        .enableRegisterWrite(enableRegisterWrite)
    );


endmodule