`timescale 1ns/1ns

module ControlUnit_Fetch_tb();
    logic clk;
    logic reset;
    logic holdSignalFromALU;
    logic [15:0] inNewInstructionAddress;
    logic changeToNewInstructionAddress;

    logic holdSigFromControl;
    logic resetSigFromControl;

    logic [15:0] outInstructionAddress;

    logic [15:0] instruction;

    ControlUnit unit(
        .clk(clk),
        .reset(reset),
        .holdSignalFromALU(holdSignalFromALU),

        .inNewInstructionAddress(inNewInstructionAddress),
        .changeToNewInstructionAddress(changeToNewInstructionAddress),

        .holdSigFromControl(holdSigFromControl),
        .resetSigFromControl(resetSigFromControl),
        
        .outInstructionAddress(outInstructionAddress)
    );

    Fetch fetch(
        .inAddress(outInstructionAddress),

        .outInstruction(instruction)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("ControlUnit_Fetch.vcd");
        $dumpvars(0, ControlUnit_Fetch_tb);

        reset = 1;
        #4;

        reset = 0;

        #20;

        changeToNewInstructionAddress = 1;
        inNewInstructionAddress = 16'h0002;

        #4;
        changeToNewInstructionAddress = 0;


        $finish;
    end
endmodule