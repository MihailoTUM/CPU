`timescale 1ns/1ns

module ALUUnit_tb();
    logic [3:0] inOperation;
    logic [15:0] inData1;
    logic [15:0] inData2;
    logic [7:0] inImmediate;
    logic [15:0] inInstructionAddress;

    logic [15:0] outDataResult;
    logic [15:0] outMemoryAddress;
    logic [15:0] outFlagRegister;

    ALUUnit dut(
        .inOperation(inOperation),
        .inData1(inData1),
        .inData2(inData2),
        .inImmediate(inImmediate),
        .inInstructionAddress(inInstructionAddress),

        .outDataResult(outDataResult),
        .outMemoryAddress(outMemoryAddress),
        .outFlagRegister(outFlagRegister)
    );

    initial
    begin
        $dumpfile("ALUUnit.vcd");
        $dumpvars(0, ALUUnit_tb);
        
        // CONST
        inOperation = 4'h0; inImmediate = 8'h7A;
        #4;

        // ADD
        inOperation = 4'h1; inData1 = 16'h000A; inData2 = 16'h000B;
        #4;

        // SUB
        inOperation = 4'h2; inData1 = 16'hFFFF; inData2 = 16'h0002; 
        #4;

        // MUL
        inOperation = 4'h3; inData1 = 16'h0004; inData2 = 16'h0004; 
        #4;

        inOperation = 4'h8; inImmediate = 8'hFF; inInstructionAddress = 16'h000C;
        #4;

        inOperation = 4'h9; inImmediate = 8'hFF; inData1 = 16'h0000; 
        #4;


        $finish;
    end
endmodule