
module ALU(
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    input logic [15:0] inExecuteOutputData,
    input logic [3:0] inExecuteOutputDataSrc,

    input logic [15:0] inDataMemoryOutputData,
    input logic [3:0] inDataMemoryOutputDataSrc,

    output logic outSignalDIV,
    output logic outWriteToRegisterEnable,
    output logic outWriteToMemoryEnable,
    output logic outJMPSignal,
    output logic outWriteReturnAddressToRegisterSignal,

    output logic [15:0] outDataResult,
    output logic [15:0] outMemoryAddress,
    output logic [15:0] outFlagRegister
);

    logic [15:0] localData1;
    logic [15:0] localData2;

    ALUControl control(
        .inOperation(inOperation),
        .inData1(inData1),
        .inData2(inData2),
        .inData1Address(inData1Address),
        .inData2Address(inData2Address),

        .inExecuteOutputData(inExecuteOutputData),
        .inExecuteOutputDataSrc(inExecuteOutputDataSrc),

        .inDataMemoryOutputData(inDataMemoryOutputData),
        .inDataMemoryOutputDataSrc(inDataMemoryOutputDataSrc),

        .outData1(localData1),
        .outData2(localData2),

        .outSignalForDiv(outSignalDIV),
        .outWriteToRegisterEnable(outWriteToRegisterEnable),
        .outWriteToMemoryEnable(outWriteToMemoryEnable)
    );

    ALUUnit unit(
        .inOperation(inOperation),
        .inData1(localData1),
        .inData2(localData2),

        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),

        .outDataResult(outDataResult),
        .outMemoryAddress(outMemoryAddress),
        .outFlagRegister(outFlagRegister),
        
        .outJMPSignal(outJMPSignal),
        .outWriteReturnAddressToRegisterSignal(outWriteReturnAddressToRegisterSignal)
    );

endmodule