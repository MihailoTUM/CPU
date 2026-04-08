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

    initial clk = 1;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("FETCH.vcd");
        $dumpvars(0, FETCH_tb);

        // wait one cycle
        #4;

        // reset the program counter
        reset = 1;
        #4;

        reset = 0;

        #12;

        $finish;
    end
endmodule