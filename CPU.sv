
module CPU(
    input logic clk,
    input logic reset
);

    logic [15:0] localOutControlUnitInstructionAddress;
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

        .inHoldFromExecute(localOutHoldFromExecute),
        .inHoldFromDataMemory(),
        .inJMPSignal(localOutJMPSignal),

        .inNewInstructionAddress(localExecuteOutMemoryAddress),

        .outReset(globalReset),
        .outHoldDecode(globalHoldDecode),
        .outFlushDecode(globalFlushDecode),
        .outHoldExecute(globalHoldExecute),
        .outFlushExecute(globalFlushExecute),
        .outHoldDataMemory(globalHoldDataMemory),
        .outFlushDataMemory(globalFlushDataMemory),

        .outInstructionAddress(localOutControlUnitInstructionAddress)
    );

    logic [15:0] localOutFetchInstruction;

    Fetch fetch(
        .inAddress(localOutControlUnitInstructionAddress),

        .outInstruction(localOutFetchInstruction)
    );

    logic [3:0] localOutDecodeOperation;
    logic [3:0] localOutDecodeDstAddress;
    logic [15:0] localOutDecodeData1;
    logic [15:0] localOutDecodeData2;
    logic [3:0] localOutDecodeData1Address;
    logic [3:0] localOutDecodeData2Address;
    logic [7:0] localOutDecodeImmediate;
    logic [15:0] localOUtDecodeInstructionAddress;
    logic localOutWriteToRegisterEnable;
    logic localOutWriteToMemoryEnable;

    Decode decode(
        .clk(clk),
        .reset(globalReset),
        .hold(globalHoldDecode),
        .flush(globalFlushDecode),
        
        .inInstructionAddress(localOutControlUnitInstructionAddress),
        .inInstruction(localOutFetchInstruction),
        .inDataToStore(localDataMemoryOutResultData),
        .inWriteBackDstAddress(localDataMemoryOutWriteBackDataResultDst),
        .inWriteToRegisterEnable(localDataMemoryOutWriteBackDataResultEnable),

        .inDataResultSkippy(localExecuteOutDataResult),
        .inDataResultSkippySignal(localOutWriteReturnAddressToRegisterSignal),

        .outOperation(localOutDecodeOperation),
        .outDstAddress(localOutDecodeDstAddress),
        .outData1(localOutDecodeData1),
        .outData2(localOutDecodeData2),
        .outData1Address(localOutDecodeData1Address),
        .outData2Address(localOutDecodeData2Address),
        .outImmediate(localOutDecodeImmediate),
        .outInstructionAddress(localOUtDecodeInstructionAddress),

        .outWriteToRegisterEnable(localOutWriteToRegisterEnable),
        .outWriteToMemoryEnable(localOutWriteToMemoryEnable)
    );

    logic [15:0] localOutExecuteOuputData;
    logic [3:0] localOutExecuteOuputDataSrc;

    logic localOutHoldFromExecute;
    logic localOutJMPSignal;
    logic localOutWriteReturnAddressToRegisterSignal;
    logic localOutExecuteWriteToRegisterEnable;
    logic localOutExecuteWriteToMemoryEnable;

    logic [15:0] localExecuteOutDataResult;
    logic [15:0] localExecuteOutMemoryAddress;
    logic [15:0] localExecuteOutFlagRegister;
    logic [3:0] localExecuteOutDstAddress;
    logic [3:0] localExecuteOutOperation;
    
    Execute execute(
        .clk(clk),
        .reset(reset),
        .hold(globalHoldExecute),
        .flush(globalFlushExecute),

        .inOperation(localOutDecodeOperation),
        .inDstAddress(localOutDecodeDstAddress),
        .inData1(localOutDecodeData1),
        .inData2(localOutDecodeData2),
        .inData1Address(localOutDecodeData1Address),
        .inData2Address(localOutDecodeData2Address),
        .inImmediate(localOutDecodeImmediate),
        .inInstructionAddress(localOUtDecodeInstructionAddress),

        .inExecuteOutputData(localOutExecuteOuputData),
        .inExecuteOutputDataSrc(localOutExecuteOuputDataSrc),
        .inDataMemoryOutputData(localDataMemoryOutResultData),
        .inDataMemoryOutputDataSrc(localDataMemoryOutWriteBackDataResultDst),

        .inWriteToRegisterEnable(localOutWriteToRegisterEnable),
        .inWriteToMemoryEnable(localOutWriteToMemoryEnable),

        .outHoldFromExecute(localOutHoldFromExecute),
        .outJMPSignal(localOutJMPSignal),

        .outWriteReturnAddressToRegisterSignal(localOutWriteReturnAddressToRegisterSignal),
        
        .outWriteToRegisterEnable(localOutExecuteWriteToRegisterEnable),
        .outWriteToMemoryEnable(localOutExecuteWriteToMemoryEnable),

        .outDataResult(localExecuteOutDataResult),
        .outMemoryAddress(localExecuteOutMemoryAddress),
        .outFlagRegister(localExecuteOutFlagRegister),
        .outDstAddress(localExecuteOutDstAddress),
        .outOperation(localExecuteOutOperation),

        .outExecuteOutputData(localOutExecuteOuputData),
        .outExecuteOutputDataSrc(localOutExecuteOuputDataSrc)
    );

    logic [15:0] localDataMemoryOutResultData;
    logic [3:0] localDataMemoryOutWriteBackDataResultDst;
    logic localDataMemoryOutWriteBackDataResultEnable;
    logic localOutHoldFromDataMemory;

    logic [15:0] localForwardPathFromDataMemory;
    logic [3:0] localForwardPathFromDataMemorySrc;

    DataMemory dataMemory(
        .clk(clk),
        .reset(globalReset),
        .hold(globalHoldDataMemory),
        .flush(globalFlushDataMemory),

        .inDataResult(localExecuteOutDataResult),
        .inWriteBackDataResultDst(localExecuteOutDstAddress),
        .inWriteBackDataResultEnable(localOutExecuteWriteToRegisterEnable),
        .inOperation(localExecuteOutOperation),
        .inMemoryAddress(localExecuteOutMemoryAddress),
        .inWriteToMemoryEnable(localOutExecuteWriteToMemoryEnable),

        .outHoldFromDataMemory(localOutHoldFromDataMemory),

        .outDataResult(localDataMemoryOutResultData),
        .outWriteBackDataResultDst(localDataMemoryOutWriteBackDataResultDst),
        .outWriteBackDataResultEnable(localDataMemoryOutWriteBackDataResultEnable),

        .forwardPathFromDataMemory(localForwardPathFromDataMemory),
        .forwardPathFromDataMemorySrc(localForwardPathFromDataMemorySrc)
    );
endmodule