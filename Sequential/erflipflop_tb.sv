

module erflipflop_tb;
    logic clk;
    logic reset;
    logic enable;
    logic [3:0] d;
    logic [3:0] q;

    erflipflop dut(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .d(d),
        .q(q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("erflipflop.vcd");
        $dumpvars(0, erflipflop_tb);

        // reset
        reset = 1;
        @(posedge clk); #1;

        // load
        reset = 0; enable = 1; d = 4'hF;
        @(posedge clk); #1;
        assert(q == 4'hF) else $error("Failed!");

        // hold
        reset = 0; enable = 0; d = 4'h0;
        @(posedge clk); #1;
        assert(q == 4'hF) else $error("Failed!");


        $finish;
    end
    

endmodule;