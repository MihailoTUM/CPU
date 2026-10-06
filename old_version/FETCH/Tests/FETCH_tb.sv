`timescale 1ns/1ns

module Fetch_tb();
    logic clk;
    logic reset;
    logic hold;
    logic [15:0] instruction;

    Fetch dut(
        .clk(clk),
        .reset(reset),
        .hold(hold),
        .instruction(instruction)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("Fetch.vcd");
        $dumpvars(0, Fetch_tb);

        reset = 1;
        #4;

        reset = 0;
        #4;

        #8;
        hold = 1;

        #12;
        $finish;
    end
endmodule