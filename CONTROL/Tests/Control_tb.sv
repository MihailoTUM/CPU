`timescale 1ns/1ns

module Control_tb();
    logic clk;
    logic reset;
    logic holdSignalFromALU;
    logic jumpSignalFromALU;
    logic [3:0] controlSignals;

    Control dut(
        .clk(clk),
        .reset(reset),
        .holdSignalFromALU(holdSignalFromALU),
        .jumpSignalFromALU(jumpSignalFromALU),
        .controlSignals(controlSignals)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Control.vcd");
        $dumpvars(0, Control_tb);

        reset = 1;
        #4;

        reset = 0;
        holdSignalFromALU = 1;
        #4;

        holdSignalFromALU = 0;
        #4;

        jumpSignalFromALU = 1;
        #4;

        $finish;
    end

endmodule