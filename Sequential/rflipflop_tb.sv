`timescale 1ns/1ns

module rflipflop_tb;
    logic clk;
    logic reset;
    logic [3:0] d;
    logic [3:0] q;

    rflipflop dut(
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    initial clk = 0;
    always #5 clk = ~clk;  // 1 clock cycle = 1 / 10ns = 100 Mhz

    initial begin
        $dumpfile("rflipflop.vcd");
        $dumpvars(0, rflipflop_tb);

        // reset
        reset = 1; 
        @(posedge clk); #1;

        // load
        reset = 0; d = 4'b0001;
        @(posedge clk); #1;
        assert(q == 4'b0001) else $error("Load failed!");

        $finish;
    end

endmodule;