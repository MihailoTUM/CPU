// include forward path

module ALU(
    // control inputs
    input logic clk,

    // data inputs
    input logic [3:0] inOperation,

    input logic [15:0] inData1,
    input logic [15:0] inData2,

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    // forward path
    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [15:0] outDataResult,
    output logic [15:0] outMemoryAddress,
    output logic [3:0] outOperation,

    output logic outEnableWrite,
    output logic outControlHold,

    // control outputs
    output logic outJMPSignal,

    output logic outAdressToRETSignal,
    output logic [15:0] outAddressToRET
);
    logic localDivFinished;
    logic [3:0] localControlSignals;

    logic [15:0] localOutData1;
    logic [15:0] localOutData2;

    ALUControl control(
        .clk(clk),
        .divFinished(localDivFinished),

        .inOperation(inOperation),

        .inData1(inData1),
        .inData2(inData2),

        .inData1Address(inData1Address),
        .inData2Address(inData2Address),

        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPathInputExecuteSrc(forwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),
        
        .controlSignals(localControlSignals),
        .outData1(localOutData1),
        .outData2(localOutData2)
    );

    ALUUnit unit(
        .clk(clk),
        .hold(localControlSignals[2]),
        
        .inOperation(inOperation),

        .inData1(localOutData1),
        .inData2(localOutData2),

        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),

        .divFinished(localDivFinished),
        .outEnableWrite(outEnableWrite),
        .JMPSignalToControl(outJMP),

        .outDataResult(outResult),
        .outMemoryAddress(),

        .outAddressToRET(outAddressToRET),
        .outAddressToRETSignal(outAdressToRETSignal)
    );

    assign controlHold = localControlSignals[2];
endmodule