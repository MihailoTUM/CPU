`timescale 1ns/1ns

module Pipeline_tb();
    logic clk;
    logic reset;

    Pipeline dut(
        .clk(clk),
        .reset(reset)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Pipeline.vcd");
        $dumpvars(0, Pipeline_tb);

        reset = 1;
        #4;
        reset = 0;

        #50;
        $finish;
    end
endmodule