// include forward path

module ALU(
    // control inputs
    input logic clk,

    // data inputs
    input logic [3:0] inOperation,
    input logic [15:0] inData1,
    input logic [15:0] inData2,
    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,
    input logic [15:0] inStackPointerAddress,

    // forward path
    input logic [3:0] srcRegister1,
    input logic [3:0] srcRegister2,

    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [15:0] outResult
    output logic outEnableWrite,
    output logic [3:0] outOperation,
    output logic controlHold,
    output logic [15:0] flags,

    // control outputs
    output logic [15:0] outNewAddress,
    output logic outJMP,
    output logic [15:0] outStackPointerAddress
);
    logic localDivFinished;
    logic [3:0] controlSignals;

    logic [15:0] localOutData1;
    logic [15:0] localOutData2;

    ALUControl control(
        .clk(clk),
        .divFinished(localDivFinished),

        .inOperation(inOperation),
        .inData1(inData1),
        .inData2(inData2),
        
        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPathInputExecuteSrc(forwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),
        
        .controlSignals(controlSignals),
        .outData1(localOutData1),
        .outData2(localOutData2)
    );

    logic [15:0] flags;

    ALUUnit unit(
        .clk(clk),
        .hold(controlSignals[3]),
        
        .inInstructionAddress(inInstructionAddress),
        .inStackPointerAddress(inStackPointerAddress),
        .inOperation(operation),
        .inData1(localOutData1),
        .inData2(localOutData2),
        .inImmediate(inImmediate),

        .ALUOutput(outResult),
        .flags(flags),
        .divFinished(localDivFinished)
    );

    ALUFlag flag(
        .operation(operation),
        
        .outEnableWrite(outEnableWrite),
        .outOperation(outOperation),
        .JMPSignalToControl(JMPSignalToControl)
    );

    assign controlHold = controlSignals[2];
    assign outNewAddress = outResult;
    assign outJMP = JMPSignalToControl;

endmodule