`timescale 1ns/1ns

module Decode_tb();
    logic clk;

    logic [15:0] inInstructionAddress;
    logic [15:0] inInstruction;
    logic [15:0] inDataToStore;
    logic [3:0] inWriteBackDstAddress;
    logic inWriteToRegisterEnable;

    logic [15:0] inDataResultSkippy;
    logic inDataResultSkippySignal;

    logic [3:0] outOperation;
    logic [3:0] outDstAddress;
    logic [15:0] outData1;
    logic [15:0] outData2;
    logic [3:0] outData1Address;
    logic [3:0] outData2Address;
    logic [7:0] outImmediate;
    logic [15:0] outInstructionAddress;

    Decode dut(
        .clk(clk),

        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),
        .inDataToStore(inDataToStore),
        .inWriteBackDstAddress(inWriteBackDstAddress),
        .inWriteToRegisterEnable(inWriteToRegisterEnable),

        .inDataResultSkippy(inDataResultSkippy),
        .inDataResultSkippySignal(inDataResultSkippySignal),

        .outOperation(outOperation),
        .outDstAddress(outDstAddress),
        .outData1(outData1),
        .outData2(outData2),
        .outData1Address(outData1Address),
        .outData2Address(outData2Address),
        .outImmediate(outImmediate),
        .outInstructionAddress(outInstructionAddress)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Decode.vcd");
        $dumpvars(0, Decode_tb);

        inInstruction = 16'h000A; inDataToStore = 16'h000A; inWriteBackDstAddress = 4'h0; inWriteToRegisterEnable = 1; 
        #4;

        inInstruction = 16'h010A; inDataToStore = 16'h000B; inWriteBackDstAddress = 4'h1; inWriteToRegisterEnable = 1;
        #4;

        inInstruction = 16'h1201; inDataToStore = 16'h0000; inWriteBackDstAddress = 4'h3; inWriteToRegisterEnable = 1; 
        #4;

        inInstruction = 16'h93FF; 
        #4; 

        inInstruction = 16'hA002;
        #4;


        $finish;
    end

endmodule