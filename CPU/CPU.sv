

module CPU(
    input logic globalClk,
    input logic globalReset
);
    // control
    logic [3:0] controlSignals;

    Control control(
        .clk(globalClk),
        .reset(globalReset),
        .holdSignalFromALU(controlHold),
        .jumpSignalFromALU(controlJump),

        .controlSignals(controlSignals)
    );

    // fetch
    logic [15:0] fetchOutputInstruction;

    Fetch fetch(
        .clk(globalClk),
        .reset(globalReset),
        .hold(controlSignals[0]),
        // .relativeAddress(relativeAddress),
        // .fixedAddress(fixedAddress),
        // .enableWrite(enableWrite),

        .instruction(fetchOutputInstruction)
    );

    // decode
    logic [15:0] writeToRegisterData;
    logic [3:0] writeToRegisterDst;
    logic enableRegisterWrite;

    logic [3:0] decodeOutputOperation;
    logic [3:0] decodeOutputDst;
    logic [15:0] decodeSrc1Data;
    logic [15:0] decodeSrc2Data;
    logic [7:0] decodeOutputImmediate;

    Decode decode(
        .clk(clk),
        .hold(controlSignals[0]),
        // .flush(flush),

        .instruction(fetchOutputInstruction),
        .dataToStore(writeToRegisterData),
        .writeBackDst(writeToRegisterDst),
        .enableWrite(enableRegisterWrite),

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
    logic controlHold;
    logic controlJump;


    // EXECUTE-stage
    Execute execute(
        .clk(clk),
        .hold(controlSignals[0]),
        // .flush(flush),

        .inputOperation(decodeOutputOperation),
        .inputDstAddress(decodeOutputDst),
        .inputSrc1(decodeSrc1Data),
        .inputSrc2(decodeSrc2Data),
        .inputImmediate(decodeOutputImmediate),
        
        .out(executeResult),
        .writeBackDst(executeWriteBackDst),
        .enableWrite(executeEnableWrite),
        .operation(executeOutputOperation),
        .controlHold(controlHold),
        .controlJump(controlJump)
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