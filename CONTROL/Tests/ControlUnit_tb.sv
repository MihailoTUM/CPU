`timescale 1ns/1ns

module ControlUnit_tb();
    logic clk;
    logic reset;
    logic hold;
    logic holdSignalFromALU;
    logic [15:0] inInstructionAddress;
    logic changeInstructionAddress;
    logic [3:0] controlSignals;

    ControlUnit dut(
        .clk(clk),
        .reset(reset),
        .holdSignal(hold),
        .holdSignalFromALU(holdSignalFromALU),
        .inInstructionAddress(inInstructionAddress),
        .changeInstructionAddress(changeInstructionAddress),
        .controlSignals(controlSignals)
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

        #8;
        $finish;
    end
endmodule
