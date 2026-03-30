`timescale 1ns/1ns

module Decode_tb();
    logic clk;
    logic [15:0] instruction;
    logic [15:0] data;
    logic [15:0] a;
    logic [15:0] b;

    Decode dut(
        .clk(clk),
        .instruction(instruction),
        .data(data),
        .a(a),
        .b(b)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("Decode.vcd");
        $dumpvars(0, Decode_tb);

        // write
        data = 16'hABCD; instruction = 16'h0123; #10;

        // read
        instruction = 16'h0401; #10;

    end
endmodule