`timescale 1ns/1ns

module Pipeline_tb();
    logic clk;
    logic hold;
    logic [15:0] instruction;

    Pipeline dut(
        .clk(clk),
        .hold(hold),
        .instruction(instruction)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Pipeline.vcd");
        $dumpvars(0, Pipeline_tb);

        instruction = 16'h000A;
        #4;
        
        instruction = 16'h0101;
        #4;

        instruction = 16'hFFFF;
        #4;

        instruction = 16'h1201;
        #4;

        instruction = 16'h3312;
        #4;

        #4;

        $finish;
    end
endmodule