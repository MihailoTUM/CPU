`timescale 1ns/1ns

module CPU_tb();
    logic clk;
    logic reset;

    CPU dut(
        .clk(clk),
        .reset(reset)
    );


    initial begin
        $dumpfile("CPU.vcd");
        $dumpvars(0, CPU_tb);
        clk = 0;

        reset = 1;
        #20;

        reset = 0;
        #200;

        $finish;
    end

    always #5 clk = ~clk;
endmodule