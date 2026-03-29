`timescale 1ns/1ns

module MUX16_tb;
    logic [15:0] in;
    logic [3:0] con;
    logic out;

    MUX16 dut(
        .in(in),
        .con(con),
        .out(out)
    );

    initial begin
        $dumpfile("MUX16.vcd");
        $dumpvars(0, MUX16_tb);

        in = 16'b0000_1100_0011_1111; con = 4'b0000; #1;
        assert(out == 1) else $error("control 1 failed");
        #1;

        con = 4'b0111; #1;
        assert(out == 0) else $error("control 2 failed");
        #1;

        $finish;
    end
endmodule