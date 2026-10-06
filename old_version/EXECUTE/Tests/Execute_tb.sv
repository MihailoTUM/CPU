`timescale 1ns/1ns

module Execute_tb();
    logic clk;
    logic reset;

    logic [3:0] inOperation;
    logic [3:0] inDstAddress;
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

    logic outSignalDIV;
    logic outWriteToRegisterEnable;
    logic outWriteToMemoryEnable;

    logic [15:0] outDataResult;
    logic [15:0] outMemoryAddress;
    logic [15:0] outFlagRegister;

    logic [3:0] outDstAddress;
    logic [3:0] outOperation;

    logic [15:0] outExecuteOutputData;
    logic [3:0] outExecuteOutputDataSrc;

    Execute dut(
        .clk(clk),
        .reset(reset),

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

        .outSignalDIV(outSignalDIV),
        .outWriteToRegisterEnable(outWriteToRegisterEnable),
        .outWriteToMemoryEnable(outWriteToMemoryEnable),

        .outDataResult(outDataResult),
        .outMemoryAddress(outMemoryAddress),
        .outFlagRegister(outFlagRegister),

        .outDstAddress(outDstAddress),
        .outOperation(outOperation),

        .outExecuteOutputData(outExecuteOutputData),
        .outExecuteOutputDataSrc(outExecuteOutputDataSrc)
    );


    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Execute.vcd");
        $dumpvars(0, Execute_tb);

        reset = 1;
        #4;

        reset = 0;

        inOperation = 4'h0; inDstAddress = 4'h0; inImmediate = 8'h02; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'h0; inDstAddress = 4'h1; inImmediate = 8'h04; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'h1; inDstAddress = 4'h2; inData1 = 16'h0002; inData2 = 16'h0004; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'h3; inDstAddress = 4'h3; inData1 = 16'h0004; inData2 = 16'h0004; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'h8; inImmediate = 8'hFF; inInstructionAddress = 16'h000A; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'h9; inImmediate = 8'hFF; inInstructionAddress = 16'h000A; inData1 = 16'h0000; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'hA; inImmediate = 8'h01; inData1 = 16'h0000; inData1Address = 4'h9; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'hD; inImmediate = 8'hFF; inData1 = 16'hFFFF; inData1Address = 4'hA; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'hE; inData1Address = 4'hF; inData1 = 16'hFFFF; inImmediate = 8'hFF; inData2 = 16'hAAAA; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'hB; inInstructionAddress = 16'h000F; inImmediate = 8'hFF; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;

        inOperation = 4'hC; inData1 = 16'h00FF; inExecuteOutputData = 16'hXXXX; inExecuteOutputDataSrc = 4'hF; inDataMemoryOutputData = 16'hXXXX; inDataMemoryOutputDataSrc = 4'hF;
        #4;


        #2;
        $finish;
    end

endmodule