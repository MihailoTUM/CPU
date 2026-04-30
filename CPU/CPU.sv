

module CPU(
    input logic globalClk,
    input logic globalReset
);
    // FETCH inputs
    // logic enableWrite;

    // FETCH output
    logic [15:0] fetchOutputInstruction;

    // DECODE inputs: WRITE
    logic [15:0] writeToRegisterData;
    logic [3:0] writeToRegisterDst;
    logic enableRegisterWrite;

    // DECODE outputs: READ
    logic [3:0] decodeOutputOperation;
    logic [3:0] decodeOutputDst;
    logic [15:0] decodeSrc1Data;
    logic [15:0] decodeSrc2Data;
    logic [7:0] decodeOutputImmediate;
    logic localEnableWrite;

    // control outputs
    logic [3:0] controlSignals;

    // Control-unit
    Control control(
        .clk(clk),
        .controlSignals(controlSignals)
    );

    // FETCH-stage
    Fetch fetch(
        // inputs
        .clk(globalClk),
        .reset(globalReset),
        .hold(controlSignals[0]),
        // .relativeAddress(relativeAddress),
        // .fixedAddress(fixedAddress),
        // .enableWrite(enableWrite),

        // outputs
        .instruction(fetchOutputInstruction)
    );

    // DECODE-stage
    Decode decode(
        // inputs
        // control
        .clk(clk),
        .hold(controlSignals[0]),
        // .flush(flush),

        // write to registers
        .instruction(fetchOutputInstruction),
        .dataToStore(writeToRegisterData),
        .writeBackDst(writeToRegisterDst),
        .enableWrite(enableRegisterWrite),
        // outputs
        .operation(decodeOutputOperation),
        .dstAddress(decodeOutputDst),
        .src1Data(decodeSrc1Data),
        .src2Data(decodeSrc2Data),
        .immediateOperandOutput(decodeOutputImmediate)
    );

    // EXECUTE outputs
    logic [15:0] executeResult;
    logic [3:0] executeWriteBackDst;
    logic executeEnableWrite;
    logic [3:0] executeOutputOperation;


    // EXECUTE-stage
    Execute execute(
        // inputs
        // control
        .clk(clk),
        .hold(controlSignals[0]),
        // .flush(flush),
        .operationIn(decodeOutputOperation),
        .dstAddressIn(decodeOutputDst),
        .src1DataIn(decodeSrc1Data),
        .src2DataIn(decodeSrc2Data),
        .immediateOperandOutputIn(decodeOutputImmediate),
        // outputs
        .result(executeResult),
        .writeBackDst(executeWriteBackDst),
        .enableWrite(executeEnableWrite),
        .operation(executeOutputOperation)
    );

    // DATAMEMORY outputs
    logic [15:0] datamemoryOutput;
    logic [3:0] datamemoryWriteBackDst;
    logic datamemoryEnableWriteBack;

    // DATAMEMORY-stage
    DataMemory dataMemory(
        // inputs
        // control
        .clk(clk),

        .ALUResult(executeResult),
        .writeBackALUResultDst(executeWriteBackDst),
        .writeBackEnable(executeEnableWrite),
        .operation(executeOutputOperation),
        // outputs
        .resultToWriteBack(datamemoryOutput),
        .dstToWriteBack(datamemoryWriteBackDst),
        .enableToWriteBack(datamemoryEnableWriteBack)
    );


    // WRITE_BACK-stage (technically does nothing except for passing data through)
    WriteBack writeBack(
        // inputs
        .result(datamemoryOutput),
        .writeBackDst(datamemoryWriteBackDst),
        .enableWrite(datamemoryEnableWriteBack),
        // outputs
        .writeToRegisterData(writeToRegisterData),
        .writeToRegisterDst(writeToRegisterDst),
        .enableRegisterWrite(enableRegisterWrite)
    );


endmodule