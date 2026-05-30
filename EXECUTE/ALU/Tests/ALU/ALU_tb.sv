`timescale 1ns/1ns

module ALU_tb();
    logic clk;

    logic [3:0] inOperation;

    logic [15:0] inData1;
    logic [15:0] inData2;

    logic [3:0] inData1Address;
    logic [3:0] inData2Address;

    logic [7:0] inImmediate;
    logic [15:0] inInstructionAddress;

    logic [15:0] inExecuteOutputData;
    logic [3:0] inExecuteOutputDataSrc;

    logic [15:0] inDataMemoryOutputData;
    logic [3:0] inDataMemoryOutputDataSrc;

    logic outSignalForDiv;
    logic outWriteToRegisterEnable;
    logic outWriteToMemoryEnable;

    logic [15:0] outDataResult;
    logic [15:0] outMemoryAddress;
    logic [15:0] outFlagRegister;


    ALU dut(
        .inOperation(inOperation),
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

        .outSignalForDiv(outSignalForDiv),
        .outWriteToRegisterEnable(outWriteToRegisterEnable),
        .outWriteToMemoryEnable(outWriteToMemoryEnable),

        .outDataResult(outDataResult),
        .outMemoryAddress(outMemoryAddress),
        .outFlagRegister(outFlagRegister)
    );

    initial
    begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_tb);

        inOperation = 4'h0; inImmediate = 8'h7A; inExecuteOutputData = 16'h0000; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'h0000; inDataMemoryOutputDataSrc = 4'hF; inData1Address = 4'h0; inData2Address = 4'h1;
        #4;
        assert(outDataResult == 16'h007A) else $error("Test 1 failed!");
        #1;

        // ADD
        inOperation = 4'h1; inData1 = 16'h000A; inData2 = 16'h000B;inExecuteOutputData = 16'h0000; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'h0000; inDataMemoryOutputDataSrc = 4'hF; inData1Address = 4'h0; inData2Address = 4'h1;
        #4;
        assert(outDataResult == 16'h0015) else $error("Test 2 failed!");
        #1;
        
        // SUB
        inOperation = 4'h2; inData1 = 16'hFFFF; inData2 = 16'h0002; inExecuteOutputData = 16'h0000; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'h0000; inDataMemoryOutputDataSrc = 4'hF; inData1Address = 4'h0; inData2Address = 4'h1;
        #4;

        // MUL
        inOperation = 4'h3; inData1 = 16'h0004; inData2 = 16'h0004; inExecuteOutputData = 16'h0000; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'h0000; inDataMemoryOutputDataSrc = 4'hF; inData1Address = 4'h0; inData2Address = 4'h1;
        #4;
        assert(outDataResult == 16'h0010) else $error("Test 4 failed");
        #1;

        inOperation = 4'h8; inImmediate = 8'hFF; inInstructionAddress = 16'h000C; inExecuteOutputData = 16'h0000; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'h0000; inDataMemoryOutputDataSrc = 4'hF; inData1Address = 4'h0; inData2Address = 4'h1;
        #4;
        assert(outMemoryAddress == 16'h000B) else $error("Test 5 sfailed");
        #1;
        
        inOperation = 4'h9; inImmediate = 8'hFF; inData1 = 16'h0000; inExecuteOutputData = 16'h0000; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'h0000; inDataMemoryOutputDataSrc = 4'hF; inData1Address = 4'h0; inData2Address = 4'h1;
        #4;
        assert(outMemoryAddress == 16'h00FF) else $error("Test 6 failed");
        #1;

        $finish;
    end
endmodule;