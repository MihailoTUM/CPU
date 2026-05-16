`timescale 1ns/1ns

module ALU_tb();
    logic clk;

    logic [3:0] inOperation;
    logic [15:0] inData1;
    logic [15:0] inData2;
    logic [7:0] inImmediate;
    logic [15:0] inInstructionAddress;
    logic [15:0] inStackPointerAddress;

    logic [3:0] srcRegister1;
    logic [3:0] srcRegister2;

    logic [15:0] forwardPathInputExecute;
    logic [3:0] forwardPathInputExecuteSrc;

    logic [15:0] forwardPathInputDataMemory;
    logic [3:0] forwardPathInputDataMemorySrc;
    
    logic [15:0] outResult;
    logic outEnableWrite;
    logic [3:0] outOperation;
    logic controlHold;
    logic [15:0] flags;

    logic [15:0] outNewAddress;
    logic outJMP;
    logic [15:0] outStackPointerAddress;

    ALU dut(
        .clk(clk),
        .inOperation(inOperation),
        .inData1(inData1),
        .inData2(inData2),
        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),
        .inStackPointerAddress(inStackPointerAddress),
        
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),

        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPathInputExecuteSrc(forwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),

        .outResult(outResult),
        .outEnableWrite(outEnableWrite),
        .outOperation(outOperation),
        .controlHold(controlHold),
        .flags(flags),

        .outNewAddress(outNewAddress),
        .outJMP(outJMP),
        .outStackPointerAddress(outStackPointerAddress)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_tb);

        inOperation = 4'h0; inData1 = 16'hXXXX; inData2 = 16'hXXXX; inImmediate = 8'hAA; 
        #4;

        inOperation = 4'h1; inData1 = 16'h0001; inData2 = 16'h0002; inImmediate = 8'h00; forwardPathInputExecute = 16'hXXXX; forwardPathInputExecuteSrc = 4'hF; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF; srcRegister1 = 4'h0; srcRegister2 = 4'h1;
        #4;

        inOperation = 4'h2; inData1 = 16'h0FFF; inData2 = 16'h0002; inImmediate = 8'h00; forwardPathInputExecute = 16'h0003; forwardPathInputExecuteSrc = 4'h3; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF; srcRegister1 = 4'h2; srcRegister2 = 4'h3;
        #4;

        inOperation = 4'h8; inData1 = 16'hXXXX; inData2 = 16'hXXXX; inImmediate = 8'h02; forwardPathInputExecute = 16'hXXXX; forwardPathInputExecuteSrc = 4'hF; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF; srcRegister1 = 4'h0; srcRegister2 = 4'h0; inInstructionAddress = 16'h00FA; 
        #4;

        inOperation = 4'h8; inData1 = 16'hXXXX; inData2 = 16'hXXXX; inImmediate = 8'hFD; forwardPathInputExecute = 16'hXXXX; forwardPathInputExecuteSrc = 4'hF; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF; srcRegister1 = 4'h0; srcRegister2 = 4'h0; inInstructionAddress = 16'h00FA; 
        #4;

        $finish;
    end
endmodule;