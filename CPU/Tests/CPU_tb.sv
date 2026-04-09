

module CPU_tb();
    logic clk;
    logic [15:0] instruction;

    CPU dut(
        .clk(clk),
        .instruction(instruction)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial begin
        $dumpfile("CPU.vcd");
        $dumpvars(0, CPU_tb);
        @(posedge clk); #1;
        instruction = 16'h0008;

        @(posedge clk); #1;
        instruction = 16'h0102;

        // stall
        @(posedge clk); #1;
        instruction = 16'hF000;

        @(posedge clk); #1;
        instruction = 16'h1201;

        @(posedge clk); #1;
        instruction = 16'hXXXX;

        #12;

        $finish;
    end

endmodule