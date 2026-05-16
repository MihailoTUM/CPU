`timescale 1ns/1ns

module Execute_tb();
    // control inputs
    logic clk;
    logic hold;
    logic reset;

    // data inputs
    logic [3:0] inOperation;
    logic [3:0] inDstAddress;
    logic [3:0] inSrc1Address;
    logic [3:0] inSrc2Address;
    logic [15:0] inSrc1;
    logic [15:0] inSrc2;
    logic [7:0] inImmediate;
    logic [15:0] inInstructionAddress;
    logic [15:0] inStackPointerAddress;

    logic [15:0] forwardPathInputExecute;
    logic [3:0] forwardPathInputExecuteSrc;

    logic [15:0] forwardPathInputDataMemory;
    logic [3:0] forwardPathInputDataMemorySrc;

    // data outputs
    logic [15:0] outResult;
    logic [3:0] outWriteBackDst;
    logic enableWrite;
    logic [3:0] outOperation;
    logic controlHold;
    logic controlJump;
    logic [15:0] forwardPathOutput;
    logic [3:0] forwardPathSrcOutput;

    logic outJMP;

    Execute dut(
        .clk(clk),
        .hold(hold),
        .reset(reset),

        .inOperation(inOperation),
        .inDstAddress(inDstAddress),
        .inSrc1Address(inSrc1Address),
        .inSrc2Address(inSrc2Address),
        .inSrc1(inSrc1),
        .inSrc2(inSrc2),
        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),
        .inStackPointerAddress(inStackPointerAddress),

        .forwardPathInputExecute(forwardPathInputExecute),
        .forwardPathInputExecuteSrc(forwardPathInputExecuteSrc),

        .forwardPathInputDataMemory(forwardPathInputDataMemory),
        .forwardPathInputDataMemorySrc(forwardPathInputDataMemorySrc),

        .outResult(outResult),
        .outWriteBackDst(outWriteBackDst),
        .outEnableWrite(outEnableWrite),
        .outOperation(outOperation),
        .controlHold(controlHold),
        .controlJump(controlJump),
        .forwardPathOutput(forwardPathOutput),
        .forwardPathSrcOutput(forwardPathSrcOutput),

        .outJMP(outJMP)
    );


    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);

        // testing reset capabilities
        reset = 1;
        #4;

        reset = 0;


        inOperation = 4'h0; inDstAddress = 4'h0; inSrc1Address = 4'h0; inSrc2Address = 4'h1; inSrc1 = 16'hXXXX; inSrc2 = 16'hXXXX; inImmediate = 8'h0F; inInstructionAddress = 16'h0000; inStackPointerAddress = 16'h0000; forwardPathInputExecute = 16'hXXXX; forwardPathInputExecuteSrc = 4'hF; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF;
        #4;

        inOperation = 4'h1; inDstAddress = 4'h1; inSrc1Address = 4'h1; inSrc2Address = 4'h2; inSrc1 = 16'h0002; inSrc2 = 16'h0004; inImmediate = 8'hXX; inInstructionAddress = 16'h0000; inStackPointerAddress = 16'h0000; forwardPathInputExecute = 16'hXXXX; forwardPathInputExecuteSrc = 4'hF; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF;
        #4;

        inOperation = 4'h8; inDstAddress = 4'hF; inSrc1Address = 4'h0; inSrc2Address = 4'h3; inSrc1 = 16'h0000; inSrc2 = 16'h0000; inImmediate = 8'h02; inInstructionAddress = 16'h0008; inStackPointerAddress = 16'h0000; forwardPathInputExecute = 16'hXXXX; forwardPathInputExecuteSrc = 4'hF; forwardPathInputDataMemory = 16'hXXXX; forwardPathInputDataMemorySrc = 4'hF;
        #4;

        // testing hold capabilites

        #8;
        $finish;
    end

endmodule