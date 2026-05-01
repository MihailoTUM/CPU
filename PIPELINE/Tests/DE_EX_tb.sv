`timescale 1ns/1ns

module DE_EX_tb();
    logic clk;
    logic hold;
    logic [15:0] instruction;
    logic controlHold;

    DE_EX dut(
        .clk(clk),
        .hold(hold),
        .instruction(instruction),
        .controlHold(controlHold)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("DE_EX.vcd");
        $dumpvars(0, DE_EX_tb);


        instruction = 16'h000A;
        #4;
        instruction = 16'hFFFF;
        #4;
        instruction = 16'h0103;
        #4;
        instruction = 16'hFFFF;
        #4;
        instruction = 16'h1201;
        #4;
        instruction = 16'hFFFF;
        #4;
        instruction = 16'h4301;

        #250;
        $finish;
    end

endmodule