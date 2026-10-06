`timescale 1ns/1ns

module CPU_tb();
    logic clk;
    logic reset;

    CPU dut(
        .clk(clk),
        .reset(reset)
    );

    initial clk = 0;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("CPU.vcd");
        $dumpvars(0, CPU_tb);

        reset = 1;
        #4;

        reset = 0;

        #60;
        $finish;
    end
endmodule