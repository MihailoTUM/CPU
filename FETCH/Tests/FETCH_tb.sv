`timescale 1ns/1ns

module FETCH_tb();
    logic clk;
    logic reset;
    logic [15:0] instruction;

    FETCH dut(
        .clk(clk),
        .reset(reset),
        .instruction(instruction)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("FETCH.vcd");
        $dumpvars(0, FETCH_tb);

        #2;
        reset = 1; #4;

        reset = 0;
    end
endmodule