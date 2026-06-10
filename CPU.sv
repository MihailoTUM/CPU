

module CPU(
    input logic     clk,
    input logic     reset
);

logic [15:0] localInstructionAddress;

ControlUnit controlUnit(
    .clk(clk),
    .reset(reset),

    .inHoldFromExecute(),
    .inHoldFromDataMemory(),
    .inJMPSignal(),

    .inNewInstructionAddress(),
    
    .outReset(),
    .outHoldDecode(),
    .outFlushDecode(),
    .outHoldExecute(),
    .outFlushExecute(),
    .outHoldDataMemory(),
    .outFlushDataMemory(),

    .outInstructionAddress(localInstructionAddress)
);

logic [15:0] localInstruction;

Fetch fetch(
    .inAddress(localInstruction),

    .outInstruction(localInstruction)
);

Decode decode(
    .clk(clk),
    .reset(reset),
    .hold(),
    .flush(),

    .inInstructionAddress(localInstructionAddress),
    .inInstruction(localInstruction),
    .inDataToStore(),
    .inWriteBackDstAddress(),
    .inWriteToRegisterEnable(),

    .inDataResultSkippy(),
    .inDataResultSkippySignal(),

    .outOperation(),
    .outDstAddress(),
    .outData1(),
    .outData2(),
    .outData1Address(),
    .outData2Address(),
    .outImmediate(),
    .outInstructionAddress(),
    .outWriteToRegisterEnable(),
    .outWriteToMemoryEnable()
);

Execute execute(
    .clk(clk),
    .reset(reset),
    .hold(),
    .flush(),

    .inOperation(),
    .inDstAddress(),
    .inData1(),
    .inData2(),
    .inData1Address(),
    .inData2Address(),
    .inImmediate(),
    .inInstructionAddress(),

    .inExecuteOutputData(),
    .inExecuteOutputDataSrc(),
    .inDataMemoryOutputData(),
    .inDataMemoryOutputDataSrc(),

    .inWriteToRegisterEnable(),
    .inWriteToMemoryEnable(),

    .outHoldFromExecute(),
    .outJMPSignal(),

    .outWriteReturnAddressToRegisterSignal(),
    .outWriteToRegisterEnable(),
    .outWriteToMemoryEnable(),

    .outDataResult(),
    .outMemoryAddress(),
    .outFlagRegister(),
    .outDstAddress(),
    .outOperation(),

    .outExecuteOutputData(),
    .outExecuteOutputDataSrc()
);

DataMemory DataMemory(
    .clk(clk),
    .reset(reset),
    .hold(),
    .flush(),

    .inDataResult(),
    .inWriteBackDataResultDst(),
    .inWriteBackDataResultEnable(),
    .inOperation(),
    .inMemoryAddress(),
    .inWriteToMemoryEnable(),

    .outHoldFromDataMemory(),

    .outDataResult(),
    .outWriteBackDataResultDst(),
    .outWriteBackDataResultEnable(),

    .forwardPathFromDataMemory(),
    .forwardPathFromDataMemorySrc()
);

endmodule