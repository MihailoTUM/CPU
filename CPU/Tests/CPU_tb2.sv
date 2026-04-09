

module CPU_tb2();
    logic clk;
    logic reset;

    CPU dut(
        .clk(clk),
        .reset(reset)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("CPU2.vcd");
        $dumpvars(0, CPU_tb2);

        reset = 1;
        #4;
        reset = 0;

        #40;
        $finish;
    end

endmodule