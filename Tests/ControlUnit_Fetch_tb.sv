`timescale 1ns/1ns

module ControlUnit_Fetch_tb();
    logic clk;
    logic reset;
    logic holdSignalFromALU;
    logic [15:0] inInstructionAddress;
    logic changeInstructionAddress;

    logic holdSigFromControl;
    logic resetSigFromControl;

    logic [15:0] outInstructionAddress;

    logic [15:0] instruction;

    ControlUnit unit(
        .clk(clk),
        .reset(reset),
        .holdSignalFromALU(holdSignalFromALU),

        .inInstructionAddress(inInstructionAddress),
        .changeInstructionAddress(changeInstructionAddress),
        
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

        changeInstructionAddress = 1;
        inInstructionAddress = 16'h0002;

        #4;
        changeInstructionAddress = 0;


        $finish;
    end
endmodule