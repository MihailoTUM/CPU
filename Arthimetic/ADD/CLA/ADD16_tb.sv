

module Carry16_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic cin;
    logic [15:0] s;
    logic cout;

    Carry16 dut(a, b, cin, s, cout);

    initial begin
        $dumpfile("Carry16.vcd");
        $dumpvars(0, Carry16_tb);

        a = 16'h0001; b = 16'h0010; cin = 0; #1;
        assert(s == 16'h0011) else $error("failed 1");
        #1;

        a = 16'h1FAC; b = 16'h0001; cin = 0; #1;
        assert(s == 16'h1FAD) else $error("failed 2");
        #1;

        $finish;
    end

endmodule