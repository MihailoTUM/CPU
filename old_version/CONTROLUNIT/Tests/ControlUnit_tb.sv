`timescale 1ns/1ns

module ControlUnit_tb();
    logic clk;
    logic reset;

    logic inHoldFromExecute;
    logic inHoldFromDataMemory;
    logic inJMPSignal;

    logic [15:0] inNewInstructionAddress;

    logic outReset;
    logic outHoldDecode;
    logic outFlushDecode;
    logic outHoldExecute;
    logic outFlushExecute;
    logic outHoldDataMemory;
    logic outFlushDataMemory;

    logic [15:0] outInstructionAddress;

    ControlUnit dut(
        .clk(clk),
        .reset(reset),

        .inHoldFromExecute(inHoldFromExecute),
        .inHoldFromDataMemory(inHoldFromDataMemory),
        .inJMPSignal(inJMPSignal),

        .inNewInstructionAddress(inNewInstructionAddress),

        .outReset(outReset),
        .outHoldDecode(outHoldDecode),
        .outFlushDecode(outFlushDecode),
        .outHoldExecute(outHoldExecute),
        .outFlushExecute(outFlushExecute),
        .outHoldDataMemory(outHoldDataMemory),
        .outFlushDataMemory(outFlushDataMemory),
        
        .outInstructionAddress(outInstructionAddress)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("ControlUnit.vcd");
        $dumpvars(0, ControlUnit_tb);

        reset = 1;
        #4;

        reset = 0;
        #4;
        // testing


        inJMPSignal = 1;
        inNewInstructionAddress = 16'h00FF;
        #8;

        inJMPSignal = 0;
        #2;

        inHoldFromExecute = 1;
        #4;
        
        inHoldFromExecute = 0;
        #4;

        inHoldFromDataMemory = 1;
        #4;

        inHoldFromDataMemory = 0;

        #6;
        $finish;
    end

endmodule