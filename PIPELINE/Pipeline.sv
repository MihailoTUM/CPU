

module Pipeline(
    input logic clk,
    input logic reset
);
    logic [15:0] localInstructionAddress;
    logic [15:0] localInstruction;
    logic [3:0] controlSignals;

    ControlUnit controlUnit(
        .clk(clk),
        .reset(reset),
        .hold(),
        .holdSignalFromALU(localControlHold),
        .inInstructionAddress(localOutNewAddress),
        .changeInstructionAddress(localOutJmp),

        .controlSignals(controlSignals),
        .outInstructionAddress(localInstructionAddress)
    );

    Fetch fetch(
        .address(localInstructionAddress),

        .instruction(localInstruction)
    );

    logic [3:0] outOperationDecode;
    logic [3:0] outDstAddressDecode;
    logic [3:0] outSrc1AddressDecode;
    logic [3:0] outSrc2AddressDecode;
    logic [15:0] outSrc1DataDecode;
    logic [15:0] outSrc2DataDecode;
    logic [7:0] outImmediateDecode; 

    logic [15:0] outInstructionAddressDecode;
    logic [15:0] outStackPointerAddressDecode;

    Decode decode(
        .clk(clk),
        .hold(controlSignals[3]),

        .inInstructionAddress(localInstructionAddress),
        .inInstruction(localInstruction),
        .inDataToStore(localDataMemoryResult),
        .inWriteBackDst(localDataMemoryWriteBackAddress),  
        .inEnableWrite(localDataMemoryEnableWriteBack),

        .outOperation(outOperationDecode),
        .outDstAddress(outDstAddressDecode),
        .outSrc1Address(outSrc1AddressDecode),
        .outSrc2Address(outSrc2AddressDecode),
        .outSrc1Data(outSrc1DataDecode),
        .outSrc2Data(outSrc2DataDecode),
        .outImmediate(outImmediateDecode),

        .outInstructionAddress(outInstructionAddressDecode),
        .outStackPointerAddress(outStackPointerAddressDecode)
    );

    logic [15:0] localOutResult;
    logic [3:0] localWriteBackDst;
    logic localEnableWrite;
    logic [3:0] localOutOperation;
    logic localControlHold;
    logic localControlJump;

    logic [15:0] localForwardPathOutput;
    logic [3:0] localForwardPathOutputSrc;

    logic [15:0] localOutNewAddress;
    logic localOutJmp;
    logic [15:0] localStackPointerAddress;

    Execute execute(
        .clk(clk),
        .hold(controlSignals[3]),

        .inOperation(outOperationDecode),
        .inDstAddress(outDstAddressDecode),
        .inSrc1Address(outSrc1AddressDecode),
        .inSrc2Address(outSrc2AddressDecode),
        .inSrc1(outSrc1DataDecode),
        .inSrc2(outSrc2DataDecode),
        .inImmediate(outImmediateDecode),
        .inInstructionAddress(outInstructionAddressDecode),
        .inStackPointerAddress(outStackPointerAddressDecode),

        .forwardPathInputExecute(localForwardPathOutput),
        .forwardPathInputExecuteSrc(localForwardPathOutputSrc),

        .forwardPathInputDataMemory(localForwardPathFromDataMemory),
        .forwardPathInputDataMemorySrc(localForwardPathFromDataMemorySrc),

        .outResult(localOutResult),
        .outWriteBackDst(localWriteBackDst),
        .outEnableWrite(localEnableWrite),
        .outOperation(localOutOperation),
        .controlHold(localControlHold),
        .controlJump(localControlJump),
        .forwardPathOutput(localForwardPathOutput),
        .forwardPathSrcOutput(localForwardPathOutputSrc),
        
        .outNewAddress(localOutNewAddress),
        .outJmp(localOutJmp),
        .outStackPointerAddress(localStackPointerAddress)
    );

    logic [15:0] localDataMemoryResult;
    logic [3:0] localDataMemoryWriteBackAddress;
    logic localDataMemoryEnableWriteBack;

    logic [15:0] localForwardPathFromDataMemory;
    logic [3:0] localForwardPathFromDataMemorySrc;


    DataMemory dataMemory(
        .clk(clk),

        .ALUResult(localOutResult),
        .writeBackALUResultDst(localWriteBackDst),
        .writeBackEnable(localEnableWrite),
        .operation(localOutOperation),

        .resultToWriteBack(localDataMemoryResult),
        .dstToWriteBack(localDataMemoryWriteBackAddress),
        .enableToWriteBack(localDataMemoryEnableWriteBack),

        .forwardPathFromDataMemory(localForwardPathFromDataMemory),
        .forwardPathFromDataMemorySrc(localForwardPathFromDataMemorySrc)
    );


endmodule