
module Execute(
    input logic         clk,
    input logic         reset,
    input logic         hold,
    input logic         flush,

    input logic [3:0]   inOperation,
    input logic [3:0]   inDstAddress,
    input logic [15:0]  inData1,
    input logic [15:0]  inData2,
    input logic [3:0]   inData1Address,
    input logic [3:0]   inData2Address,
    input logic [7:0]   inImmediate,
    input logic [15:0]  inInstructionAddress,

    input logic [15:0]  inExecuteOutputData,
    input logic [3:0]   inExecuteOutputDataSrc,
    input logic [15:0]  inDataMemoryOutputData,
    input logic [3:0]   inDataMemoryOutputDataSrc,

    input logic         inWriteToRegisterEnable,
    input logic         inWriteToMemoryEnable,

    // --> CONTROL control
    output logic        outHoldFromExecute,
    output logic        outJMPSignal,

    // --> DECODE control
    output logic        outWriteReturnAddressToRegisterSignal,

    // --> DATAMEMORY control
    output logic        outWriteToRegisterEnable,
    output logic        outWriteToMemoryEnable,

    // --> DATAMEMORY data
    output logic [15:0] outDataResult,
    output logic [15:0] outMemoryAddress,
    output logic [15:0] outFlagRegister,
    output logic [3:0]  outDstAddress,
    output logic [3:0]  outOperation,

    // --> EXECUTE data
    output logic [15:0] outExecuteOutputData,
    output logic [3:0]  outExecuteOutputDataSrc
);

    logic [3:0]         localOperation;
    logic [3:0]         localDstAddress;

    logic [15:0]        localData1;
    logic [15:0]        localData2;
    logic [3:0]         localData1Address;
    logic [3:0]         localData2Address;
    logic [7:0]         localImmediate;
    logic [15:0]        localInstructionAddress;
  
    logic [15:0]        localExecuteOutputData;
    logic [3:0]         localExecuteOutputDataSrc;
    logic [15:0]        localDataMemoryOutputData;
    logic [3:0]         localDataMemoryOutputDataSrc;

    PipelineRegisterEX register(
        .clk(clk),
        .reset(reset),
        .hold(hold),
        .flush(flush),

        .inOperation(inOperation),
        .inDstAddress(inDstAddress),
        .inData1(inData1),
        .inData2(inData2),
        .inData1Address(inData1Address),
        .inData2Address(inData2Address),
        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),

        .inExecuteOutputData(inExecuteOutputData),
        .inExecuteOutputDataSrc(inExecuteOutputDataSrc),
        .inDataMemoryOutputData(inDataMemoryOutputData),
        .inDataMemoryOutputDataSrc(inDataMemoryOutputDataSrc),

        .inWriteToRegisterEnable(inWriteToRegisterEnable),
        .inWriteToMemoryEnable(inWriteToMemoryEnable),

        .outOperation(localOperation),
        .outDstAddress(localDstAddress),
        .outData1(localData1),
        .outData2(localData2),
        .outData1Address(localData1Address),
        .outData2Address(localData2Address),
        .outImmediate(localImmediate),
        .outInstructionAddress(localInstructionAddress),

        .outExecuteOutputData(localExecuteOutputData),
        .outExecuteOutputDataSrc(localExecuteOutputDataSrc),
        .outDataMemoryOutputData(localDataMemoryOutputData),
        .outDataMemoryOutputDataSrc(localDataMemoryOutputDataSrc),

        .outWriteToRegisterEnable(outWriteToRegisterEnable),
        .outWriteToMemoryEnable(outWriteToMemoryEnable)
    );

    logic [15:0] localDataResult;

    ALU alu(
        .inOperation(localOperation),

        .inData1(localData1),
        .inData2(localData2),
        .inData1Address(localData1Address),
        .inData2Address(localData2Address),

        .inDeactivateExecutePath(),
        .inDeactivateMemoryPath(),

        .inImmediate(localImmediate),
        .inInstructionAddress(localInstructionAddress),

        .inExecuteOutputData(localExecuteOutputData),
        .inExecuteOutputDataSrc(localExecuteOutputDataSrc),
        .inDataMemoryOutputData(localDataMemoryOutputData),
        .inDataMemoryOutputDataSrc(localDataMemoryOutputDataSrc),

        .outJMPSignal(outJMPSignal),
        .outWriteReturnAddressToRegisterSignal(outWriteReturnAddressToRegisterSignal),

        .outDataResult(localDataResult),
        .outMemoryAddress(outMemoryAddress),
        .outFlagRegister(outFlagRegister)
    );

    assign outDataResult = localDataResult;
    assign outExecuteOutputData = localDataResult;
    assign outOperation = localOperation;
    assign outExecuteOutputDataSrc = localDstAddress;
    assign outDstAddress = localDstAddress;

endmodule