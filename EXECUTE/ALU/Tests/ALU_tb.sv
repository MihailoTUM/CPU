`timescale 1ns/1ns

module ALU_tb();
    logic clk;
    logic [3:0] operation;
    logic [15:0] d1;
    logic [15:0] d2;
    logic [7:0] immediate;

    logic [15:0] out;
    logic enableWrite;
    logic [3:0] outputOperation;
    logic controlHold;

    ALU dut(
        .clk(clk),
        .operation(operation),
        .d1(d1),
        .d2(d2),
        .immediate(immediate),
        .out(out),
        .enableWrite(enableWrite),
        .outputOperation(outputOperation),
        .controlHold(controlHold)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_tb);

        operation = 4'h0; immediate = 8'h0C; d1 = 16'hXXXX; d2 = 16'hXXXX; #4;

        operation = 4'h4; immediate = 8'hXX; d1 = 16'h000C; d2 = 16'h0003; #4;

        #250;
        $finish;
    end
endmodule;