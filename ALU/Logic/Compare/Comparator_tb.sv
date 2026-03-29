

module Comparator_tb;
    logic [15:0] a;
    logic [15:0] b;
    logic equal;

    Comparator dut(a, b, equal);

    initial begin
        $dumpfile("Comparator.vcd");
        $dumpvars(0, Comparator_tb);

        a = 16'h00; b = 16'h00;
        assert(equal == 1) else $error("failure 1");

        #1;
        a = 16'hFA; b = 16'hFA;
        assert(equal == 1) else $error("failure 2");

        #1;
        a = 16'h0A; b = 16'hCC; 
        assert(equal == 0) else $error("failure 3");

        $finish;
    end

endmodule;