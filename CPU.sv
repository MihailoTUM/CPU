
module CPU(
    input logic clk,
    input logic reset
);

    logic [15:0] localInstructionAddress;
    logic globalReset;
    logic globalHoldDecode;
    logic globalFlushDecode;
    logic globalHoldExecute;
    logic globalFlushExecute;
    logic globalHoldDataMemory;
    logic globalFlushDataMemory;

    ControlUnit controlUnit(
        .clk(clk),
        .reset(reset),

        .inHoldFromDataMemory(),
        .inNewInstructionAddress(localMemoryAddress),
        .inChangeToNewInstructionAddress(localOutJMPSignal),

        .outReset(globalReset),
        .outHoldDeocde(globalHoldDecode),
        .outFlushDecode(globalFlushDecode),
        .outHoldExecute(globalHoldExecute),
        .outFlushExecute(globalFlushExecute),
        .outHoldDataMemory(globalHoldDataMemory),
        .outFlushDataMemory(globalFlushDataMemory),

        .outInstructionAddress(localInstructionAddress)
    );

    logic [15:0] localInstruction;

    Fetch fetch(
        .inAddress(localInstructionAddress),

        .outInstruction(localInstruction)
    );

    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localData1;
    logic [15:0] localData2;
    logic [3:0] localData1Address;
    logic [3:0] localData2Address;
    logic [7:0] localImmediate;
    logic [15:0] localDEInstructionAddress;

    Decode decode(
        .clk(clk),
        .reset(globalReset),
        .hold(globalHoldDecode),
        .flush(globalFlushDecode),
        
        .inInstructionAddress(localInstructionAddress),
        .inInstruction(localInstruction),
        .inDataToStore(localDMDataResult),
        .inWriteBackDstAddress(localDMWriteBackDataResultDst),
        .inWriteToRegisterEnable(localDMWriteBackDataResultEnable),

        .inDataResultSkippy(localDataResult),
        .inDataResultSkippySignal(outWriteReturnAddressToRegisterSignal),

        .outOperation(localOperation),
        .outDstAddress(localDstAddress),
        .outData1(localData1),
        .outData2(localData2),
        .outData1Address(localData1Address),
        .outData2Address(localData2Address),
        .outImmediate(localImmediate),
        .outInstructionAddress(localDEInstructionAddress)
    );

    logic [15:0] localDataResult;
    logic [15:0] localMemoryAddress;
    logic localWriteToRegisterEnable;
    logic localWriteToMemoryEnable;
    logic localOutJMPSignal;

    logic [15:0] localExecuteOutputData;
    logic [3:0] localExecuteOutputDataSrc;
    logic outWriteReturnAddressToRegisterSignal;

    logic [3:0] localExDstAddress;
    logic [3:0] localExOutOperation;

    Execute execute(
        .clk(clk),
        .reset(reset),
        .hold(globalHoldExecute),
        .flush(globalFlushExecute),

        .inOperation(localOperation),
        .inDstAddress(localDstAddress),
        .inData1(localData1),
        .inData2(localData2),
        .inData1Address(localData1Address),
        .inData2Address(localData2Address),
        .inImmediate(localImmediate),
        .inInstructionAddress(localDEInstructionAddress),

        .inExecuteOutputData(localExecuteOutputData),
        .inExecuteOutputDataSrc(localExecuteOutputDataSrc),

        .inDataMemoryOutputData(localForwardPathFromDataMemory),
        .inDataMemoryOutputDataSrc(localForwardPathFromDataMemorySrc),

        .outSignalDIV(),
        .outWriteToRegisterEnable(localWriteToRegisterEnable),
        .outWriteToMemoryEnable(localWriteToMemoryEnable),
        .outJMPSignal(localOutJMPSignal),
        .outWriteReturnAddressToRegisterSignal(outWriteReturnAddressToRegisterSignal),

        .outDataResult(localDataResult),
        .outMemoryAddress(localMemoryAddress),
        .outFlagRegister(),

        .outDstAddress(localExDstAddress),
        .outOperation(localExOutOperation),

        .outExecuteOutputData(localExecuteOutputData),
        .outExecuteOutputDataSrc(localExecuteOutputDataSrc)
    );

    logic [15:0] localDMDataResult;
    logic [3:0] localDMWriteBackDataResultDst;
    logic localDMWriteBackDataResultEnable;
    logic localHoldSignalFromDataMemory;

    logic [15:0] localForwardPathFromDataMemory;
    logic [3:0] localForwardPathFromDataMemorySrc;

    DataMemory dataMemory(
        .clk(clk),
        .reset(globalReset),
        .hold(globalHoldDataMemory),
        .flush(globalFlushDataMemory),

        .inALUDataResult(localDataResult),
        .inWriteBackDataResultDst(localExDstAddress),
        .inWriteBackDataResultEnable(localWriteToRegisterEnable),
        .inOperation(localExOutOperation),
        .inMemoryAddress(localMemoryAddress),

        .outHoldSignalFromDataMemory(localHoldSignalFromDataMemory),

        .outDataResult(localDMDataResult),
        .outWriteBackDataResultDst(localDMWriteBackDataResultDst),
        .outWriteBackDataResultEnable(localDMWriteBackDataResultEnable),

        .forwardPathFromDataMemory(localForwardPathFromDataMemory),
        .forwardPathFromDataMemorySrc(localForwardPathFromDataMemorySrc)
    );
endmodule