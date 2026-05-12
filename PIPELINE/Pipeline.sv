

module Pipeline(
    // control inputs
    input logic clk,
    input logic reset
);
    logic [3:0] localControlSignals;

    CPUControl cpuControl(
        .clk(clk),
        .reset(reset),
        .holdSignalFromALU(localControlHoldExecute),
        .jumpSignalFromALU(localControlJumpExecute),
        .controlSignals(localControlSignals)
    );

    logic [15:0] instruction;

    Fetch fetch(
        .clk(clk),
        .reset(reset),
        .hold(localControlSignals[3]),
        .instruction(instruction)
    );

    logic [3:0] localOperationDecode;
    logic [3:0] localDstAddressDecode;
    logic [3:0] localSrc1DataAddressDecode;
    logic [3:0] localSrc2DataAddressDecode;
    logic [15:0] localSrc1DataDecode;
    logic [15:0] localSrc2DataDecode;
    logic [7:0] localImmediateOperandDecode;

    Decode decode(
        .clk(clk),
        .hold(localControlSignals[3]),

        .instruction(instruction),
        .dataToStore(localResultToWriteBack),
        .writeBackDst(localDstToWriteBack),
        .enableWrite(localEnableToWriteBack),

        .operation(localOperationDecode),
        .dstAddress(localDstAddressDecode),
        .src1DataAddress(localSrc1DataAddressDecode),
        .src2DataAddress(localSrc2DataAddressDecode),
        .src1Data(localSrc1DataDecode),
        .src2Data(localSrc2DataDecode),
        .immediateOperandOutput(localImmediateOperandDecode)
    );

    logic [15:0] localForwardPathInputExecute;
    logic [3:0] localForwardPathSrcInputExecute;

    logic [15:0] localOutputExecute;
    logic [3:0] localWriteBackDstExecute;
    logic localEnableWriteExecute;
    logic [3:0] localOperationExecute;
    logic localControlHoldExecute;
    logic localControlJumpExecute;

    Execute execute(
        .clk(clk),
        .hold(localControlSignals[3]),

        .inputOperation(localOperationDecode),
        .inputDstAddress(localDstAddressDecode),
        .inputSrc1Address(localSrc1DataAddressDecode),
        .inputSrc2Address(localSrc2DataAddressDecode),
        .inputSrc1(localSrc1DataDecode),
        .inputSrc2(localSrc2DataDecode),
        .inputImmediate(localImmediateOperandDecode),
        .forwardPathInput(localForwardPathInputExecute),
        .forwardPathSrcInput(localForwardPathSrcInputExecute),

        .out(localOutputExecute),
        .writeBackDst(localWriteBackDstExecute),
        .enableWrite(localEnableWriteExecute),
        .operation(localOperationExecute),
        .controlHold(localControlHoldExecute),
        .controlJump(localControlJumpExecute),
        .forwardPathOutput(localForwardPathInputExecute),
        .forwardPathSrcOutput(localForwardPathSrcInputExecute)
    );

    logic [15:0] localResultToWriteBack;
    logic [3:0] localDstToWriteBack;
    logic localEnableToWriteBack;

    DataMemory dataMemory(
        .clk(clk),
        .ALUResult(localOutputExecute),
        .writeBackALUResultDst(localWriteBackDstExecute),
        .writeBackEnable(localEnableWriteExecute),
        .operation(localOperationExecute),

        .resultToWriteBack(localResultToWriteBack),
        .dstToWriteBack(localDstToWriteBack),
        .enableToWriteBack(localEnableToWriteBack)
    );  


endmodule