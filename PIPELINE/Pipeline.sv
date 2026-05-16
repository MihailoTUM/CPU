

module Pipeline(
    input logic clk,
    input logic reset
);
    logic [15:0] localInstructionAddress;
    logic localResetSignal;
    logic localHoldSignal;

    ControlUnit controlUnit(
        .clk(clk),
        .reset(reset),

        .holdSignalFromALU(localControlHold),
        .inNewInstructionAddress(localOutResult),
        .changeToNewInstructionAddress(localOutJMP),

        .holdSigFromControl(localHoldSignal),
        .resetSigFromControl(localResetSignal),

        .outInstructionAddress(localInstructionAddress)
    );

    logic [15:0] localInstruction;

    Fetch fetch(
        .inAddress(localInstructionAddress),

        .outInstruction(localInstruction)
    );

    logic [15:0] localDecodeInstructionAddress;
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;
    logic [15:0] localSrc1Data;
    logic [15:0] localSrc2Data;
    logic [7:0] localImmediate;

    logic [15:0] localStackPointerAddress;

    Decode decode(
        .clk(clk),
        .hold(localHoldSignal),

        .inInstructionAddress(localInstructionAddress),
        .inInstruction(localInstruction),
        .inDataToStore(localResultToWriteBack),
        .inWriteBackDst(localDstToWriteBack),
        .inEnableWrite(localEnableToWriteBack),

        .outOperation(localOperation),
        .outDstAddress(localDstAddress),
        .outSrc1Address(localSrc1Address),
        .outSrc2Address(localSrc2Address),
        .outSrc1Data(localSrc1Data),
        .outSrc2Data(localSrc2Data),
        .outImmediate(localImmediate),

        .outInstructionAddress(localDecodeInstructionAddress),
        .outStackPointerAddress(localStackPointerAddress)
    );

    logic [15:0] localOutResult;
    logic [3:0] localWriteBackDst;
    logic localEnableWrite;
    logic localControlHold;
    logic localControlJump;
    logic [15:0] localForwardPathOutput;
    logic [3:0] localForwardPathSrcOutput;
    logic localOutJMP;

    logic [3:0] localExecuteOperation;

    Execute execute(
        .clk(clk),
        .hold(localHoldSignal),
        .reset(localResetSignal),

        .inOperation(localOperation),
        .inDstAddress(localDstAddress),
        .inSrc1Address(localSrc1Address),
        .inSrc2Address(localSrc2Address),
        .inSrc1(localSrc1Data),
        .inSrc2(localSrc2Data),
        .inImmediate(localImmediate),
        .inInstructionAddress(localDecodeInstructionAddress),
        .inStackPointerAddress(localStackPointerAddress),

        .forwardPathInputExecute(localForwardPathOutput),
        .forwardPathInputExecuteSrc(localForwardPathSrcOutput),

        .forwardPathInputDataMemory(localForwardPathFromDataMemory),
        .forwardPathInputDataMemorySrc(localForwardPathFromDataMemorySrc),

        .outResult(localOutResult),
        .outWriteBackDst(localWriteBackDst),
        .outEnableWrite(localEnableWrite),
        .outOperation(localExecuteOperation),
        .controlHold(localControlHold),
        .controlJump(localControlJump),
        .forwardPathOutput(localForwardPathOutput),
        .forwardPathSrcOutput(localForwardPathSrcOutput),
        
        .outJMP(localOutJMP)
    );

    logic [15:0] localResultToWriteBack;
    logic [3:0] localDstToWriteBack;
    logic localEnableToWriteBack;

    logic [15:0] localForwardPathFromDataMemory;
    logic [3:0] localForwardPathFromDataMemorySrc;

    DataMemory dataMemory(
        .clk(clk),
        .ALUResult(localOutResult),
        .writeBackALUResultDst(localWriteBackDst),
        .writeBackEnable(localEnableWrite),
        .operation(localExecuteOperation),
        
        .resultToWriteBack(localResultToWriteBack),
        .dstToWriteBack(localDstToWriteBack),
        .enableToWriteBack(localEnableToWriteBack),

        .forwardPathFromDataMemory(localForwardPathFromDataMemory),
        .forwardPathFromDataMemorySrc(localForwardPathFromDataMemorySrc)
    );

endmodule