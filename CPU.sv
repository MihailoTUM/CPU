
module CPU(
    input logic     clk,
    input logic     reset
);

logic [15:0] localInstructionAddress;

logic localReset;
logic localHoldDecode;
logic localFlushDecode;
logic localHoldExecute;
logic localFlushExecute;
logic localHoldDataMemory;
logic localFlushDataMemory;
logic ControlDeactivateExecute;
logic ControlDeactivateMemory;

ControlUnit controlUnit(
    .clk(clk),
    .reset(reset),

    .inHoldFromExecute(ExecuteHoldFromExecute),
    .inHoldFromDataMemory(DataMemoryHoldFromDataMemory),
    .inJMPSignal(ExecuteJMPSignal),

    .inNewInstructionAddress(ExecuteMemoryAddress),
    
    .outReset(localReset),
    .outHoldDecode(localHoldDecode),
    .outFlushDecode(localFlushDecode),
    .outHoldExecute(localHoldExecute),
    .outFlushExecute(localFlushExecute),
    .outHoldDataMemory(localHoldDataMemory),
    .outFlushDataMemory(localFlushDataMemory),

    .outDeactivateExecutePath(ControlDeactivateExecute),
    .outDeactivateMemoryPath(ControlDeactivateMemory),

    .outInstructionAddress(localInstructionAddress)
);

logic [15:0] localInstruction;

Fetch fetch(
    .inAddress(localInstructionAddress),

    .outInstruction(localInstruction)
);

logic [3:0] DecodeOperation;
logic [3:0] DecodeDstAddress;
logic [15:0] DecodeData1;
logic [15:0] DecodeData2;
logic [3:0] DecodeData1Address;
logic [3:0] DecodeData2Address;
logic [7:0] DecodeImmediate;
logic [15:0] DecodeInstructionAddress;
logic DecodeWriteToRegisterEnable;
logic DecodeWriteToMemoryEnable;

Decode decode(
    .clk(clk),
    .reset(localReset),
    .hold(localHoldDecode),
    .flush(localFlushDecode),

    .inInstructionAddress(localInstructionAddress),
    .inInstruction(localInstruction),
    .inDataToStore(DataMemoryDataResult),
    .inWriteBackDstAddress(DataMemoryWriteBackDataResultDst),
    .inWriteToRegisterEnable(DataMemoryWriteBackDataResultEnable),

    .inDataResultSkippy(ExecuteDataResult),
    .inDataResultSkippySignal(ExecuteWriteReturnAddressToRegisterSignal),

    .outOperation(DecodeOperation),
    .outDstAddress(DecodeDstAddress),
    .outData1(DecodeData1),
    .outData2(DecodeData2),
    .outData1Address(DecodeData1Address),
    .outData2Address(DecodeData2Address),
    .outImmediate(DecodeImmediate),
    .outInstructionAddress(DecodeInstructionAddress),
    .outWriteToRegisterEnable(DecodeWriteToRegisterEnable),
    .outWriteToMemoryEnable(DecodeWriteToMemoryEnable)
);

logic ExecuteHoldFromExecute;
logic ExecuteJMPSignal;
logic ExecuteWriteReturnAddressToRegisterSignal;
logic ExecuteWriteToRegisterEnable;
logic ExecuteWriteToMemoryEnable;

logic [15:0] ExecuteDataResult;
logic [15:0] ExecuteMemoryAddress;
logic [15:0] ExecuteFlagRegister;
logic [3:0] ExecuteDstAddress;
logic [3:0] ExecuteOperation;
logic [15:0] ExecuteOutputData;
logic [3:0] ExecuteOutputDataSrc;

Execute execute(
    .clk(clk),
    .reset(localReset),
    .hold(localHoldExecute),
    .flush(localFlushExecute),

    .inOperation(DecodeOperation),
    .inDstAddress(DecodeDstAddress),
    .inData1(DecodeData1),
    .inData2(DecodeData2),
    .inData1Address(DecodeData1Address),
    .inData2Address(DecodeData2Address),
    .inImmediate(DecodeImmediate),
    .inInstructionAddress(DecodeInstructionAddress),

    .inExecuteOutputData(ExecuteOutputData),
    .inExecuteOutputDataSrc(ExecuteOutputDataSrc),
    .inDataMemoryOutputData(DataMemoryForwardPath),
    .inDataMemoryOutputDataSrc(DataMemoryForwardPathSrc),

    .inWriteToRegisterEnable(DecodeWriteToRegisterEnable),
    .inWriteToMemoryEnable(DecodeWriteToMemoryEnable),

    .inDeactivateExecutePath(ControlDeactivateExecute),
    .inDeactivateMemoryPath(ControlDeactivateMemory),

    .outHoldFromExecute(ExecuteHoldFromExecute),
    .outJMPSignal(ExecuteJMPSignal),

    .outWriteReturnAddressToRegisterSignal(ExecuteWriteReturnAddressToRegisterSignal),
    .outWriteToRegisterEnable(ExecuteWriteToRegisterEnable),
    .outWriteToMemoryEnable(ExecuteWriteToMemoryEnable),

    .outDataResult(ExecuteDataResult),
    .outMemoryAddress(ExecuteMemoryAddress),
    .outFlagRegister(ExecuteFlagRegister),
    .outDstAddress(ExecuteDstAddress),
    .outOperation(ExecuteOperation),

    .outExecuteOutputData(ExecuteOutputData),
    .outExecuteOutputDataSrc(ExecuteOutputDataSrc)
);

logic DataMemoryHoldFromDataMemory;

logic [15:0] DataMemoryDataResult;
logic [3:0] DataMemoryWriteBackDataResultDst;
logic DataMemoryWriteBackDataResultEnable;
logic [15:0] DataMemoryForwardPath;
logic [3:0] DataMemoryForwardPathSrc;

DataMemory DataMemory(
    .clk(clk),
    .reset(localReset),
    .hold(localHoldDataMemory),
    .flush(localFlushDataMemory),

    .inDataResult(ExecuteDataResult),
    .inWriteBackDataResultDst(ExecuteDstAddress),
    .inWriteBackDataResultEnable(ExecuteWriteToRegisterEnable),
    .inOperation(ExecuteOperation),
    .inMemoryAddress(ExecuteMemoryAddress),
    .inWriteToMemoryEnable(ExecuteWriteToMemoryEnable),

    .outHoldFromDataMemory(DataMemoryHoldFromDataMemory),

    .outDataResult(DataMemoryDataResult),
    .outWriteBackDataResultDst(DataMemoryWriteBackDataResultDst),
    .outWriteBackDataResultEnable(DataMemoryWriteBackDataResultEnable),

    .forwardPathFromDataMemory(DataMemoryForwardPath),
    .forwardPathFromDataMemorySrc(DataMemoryForwardPathSrc)
);

endmodule