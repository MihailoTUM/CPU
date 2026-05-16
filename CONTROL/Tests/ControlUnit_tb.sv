`timescale 1ns/1ns

module ControlUnit_tb();
    logic clk;
    logic reset;
    logic holdSignalFromALU;
    logic [15:0] inNewInstructionAddress;
    logic changeToNewInstructionAddress;

    logic holdSigFromControl;
    logic resetSigFromControl;

    logic [15:0] outInstructionAddress;

    ControlUnit dut(
        .clk(clk),
        .reset(reset),
        .holdSignalFromALU(holdSignalFromALU),
        .inNewInstructionAddress(inNewInstructionAddress),
        .changeToNewInstructionAddress(changeToNewInstructionAddress),

        .holdSigFromControl(holdSigFromControl),
        .resetSigFromControl(resetSigFromControl),
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
        holdSignalFromALU = 1;

        #8;
        holdSignalFromALU = 0;
        changeToNewInstructionAddress = 1;
        inNewInstructionAddress = 16'h0000;
        #4;

        changeToNewInstructionAddress = 0;

        #4;
        $finish;
    end

endmodule