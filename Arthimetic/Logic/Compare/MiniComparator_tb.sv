

module MiniComparator_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic y;

    MiniComparator dut(a, b, y);

    initial begin
        $dumpfile("MiniComparator.vcd");
        $dumpvars(0, MiniComparator_tb);

        a = 16'h00FF; b = 16'h00FF; #1;
        assert(y == 1) else $error("Failed 1");

        a = 16'h00FA; b = 16'h00FA; #1;
        assert(y == 1) else $error("Failed 2");

        a = 16'h00AA; b = 16'h0FFA; #1;
        assert(y == 0) else $error("Failed 3");

        $finish;
    end
endmodule