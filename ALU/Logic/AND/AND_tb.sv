

module AND_tb;
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] out;

    AND dut(a, b, out);

    initial begin
        $dumpfile("AND.vcd");
        $dumpvars(0, AND_tb);
        a = 16'h000F; b = 16'hABCD; #1;
        assert(out == 16'h000D) else $error("Failed!");

        $finish;
    end    
endmodule