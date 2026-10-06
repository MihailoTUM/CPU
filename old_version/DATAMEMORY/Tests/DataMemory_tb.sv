`timescale 1ns/1ns

module DataMemory_tb();
    logic clk;

    logic [15:0] inALUDataResult;
    logic [3:0] inWriteBackDataResultDst;
    logic inWriteBackDataResultEnable;
    logic [3:0] inOperation;
    logic [15:0] inMemoryAddress;

    logic outHoldSignalFromDataMemory;

    logic [15:0] outDataResult;
    logic [3:0] outWriteBackDataResultDst;
    logic outWriteBackDataResultEnable;

    logic [15:0] forwardPathFromDataMemory;
    logic [3:0] forwardPathFromDataMemorySrc;

    DataMemory dut(
        .clk(clk),

        .inALUDataResult(inALUDataResult),
        .inWriteBackDataResultDst(inWriteBackDataResultDst),
        .inWriteBackDataResultEnable(inWriteBackDataResultEnable),
        .inOperation(inOperation),
        .inMemoryAddress(inMemoryAddress),

        .outHoldSignalFromDataMemory(outHoldSignalFromDataMemory),
        
        .outDataResult(outDataResult),
        .outWriteBackDataResultDst(outWriteBackDataResultDst),
        .outWriteBackDataResultEnable(outWriteBackDataResultEnable),
        
        .forwardPathFromDataMemory(forwardPathFromDataMemory),
        .forwardPathFromDataMemorySrc(forwardPathFromDataMemorySrc)
    );


    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("DataMemory.vcd");
        $dumpvars(0, DataMemory_tb);
        
        inALUDataResult = 16'hFFFF; inWriteBackDataResultDst = 4'h0; inWriteBackDataResultEnable = 1'b1; inOperation = 4'h1;
        #4;

        inALUDataResult = 16'hCCCC; inWriteBackDataResultDst = 4'hF; inWriteBackDataResultEnable = 1'b1; inOperation = 4'hD; inMemoryAddress = 16'hFFFF;  
        #4;

        inALUDataResult = 16'hAAAA; inWriteBackDataResultDst = 4'hX; inWriteBackDataResultEnable = 1'b0; inOperation = 4'hE; inMemoryAddress = 16'hFFFF;
        #4;

        inALUDataResult = 16'hXXXX; inOperation = 4'hF;
        #4;

        $finish;
    end

endmodule