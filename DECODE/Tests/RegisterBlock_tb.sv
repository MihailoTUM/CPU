`timescale 1ns/1ns

module RegisterBlock_tb();
    logic clk;
    logic [15:0] dataToStore;
    logic [3:0] writeBackDst;
    logic [3:0] src1Address;
    logic [3:0] src2Address;
    logic [7:0] immediateOperandInput;
    logic [15:0] src1Data;
    logic [15:0] src2Data;  
    logic [7:0] immediateOperandOutput;

    RegisterBlock dut(
        .clk(clk),
        .dataToStore(dataToStore),
        .writeBackDst(writeBackDst),
        .src1Address(src1Address),
        .src2Address(src2Address),
        .immediateOperandInput(immediateOperandInput),
        .src1Data(src1Data),
        .src2Data(src2Data),
        .immediateOperandOutput(immediateOperandOutput)
    );

    initial clk = 1;
    always #2 clk = ~clk; //t = 4ns f = 250Mhz

    initial 
    begin 
        $dumpfile("RegisterBlock.vcd");
        $dumpvars(0, RegisterBlock_tb);

        // store FFFF in register 0, propagate register 1 and register 2 to ALU
        dataToStore = 16'hFFFF; writeBackDst = 4'h0; src1Address = 4'h1; src2Address = 4'h2;
        // wait one cycle
        #4;

        // store nothing, propagate register 0 and register 2 to ALU
        dataToStore = 16'hXXXX; writeBackDst = 4'hA; src1Address = 4'h0; src2Address = 4'h1;
        // wait one cycle
        #4;

        $finish;
    end

endmodule