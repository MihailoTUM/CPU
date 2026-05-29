`timescale 1ns/1ns

module Mini_tb(); 
    logic clk;
    logic hold;
    logic reset;
    logic [15:0] inInstructionAddress;
    logic [15:0] inInstruction;
    logic [15:0] inAddressToRET;
    logic inAddressToRETSignal;

    Mini dut(
        .clk(clk),
        .hold(hold),
        .reset(reset),
        .inInstructionAddress(inInstructionAddress),
        .inInstruction(inInstruction),
        .inAddressToRET(inAddressToRET),
        .inAddressToRETSignal(inAddressToRETSignal)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Mini.vcd");
        $dumpvars(0, Mini_tb);

        reset = 1;
        #4;

        reset = 0;
        inInstruction = 16'h0FFF;
        #4;

        inInstruction = 16'h000A;
        #4;

        inInstruction = 16'h010B;
        #4;

        inInstruction = 16'h1201;
        #4;

        inInstruction = 16'hD3FF;
        #4;

        inInstruction = 16'hE4FD;
        #4;

        #8;
        $finish;
    end 
endmodule