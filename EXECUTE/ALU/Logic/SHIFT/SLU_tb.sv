`timescale 1ns/1ns

module SLU_tb;
    logic [15:0] a;
    logic [3:0] shift;
    logic [15:0] out;

    SLU dut(
        .a(a),
        .shift(shift),
        .out(out)
    );  

    initial begin
        $dumpfile("SLU.vcd");
        $dumpvars(0, SLU_tb);

        a = 16'b0101_1111_0000_1010; shift = 4'd1; #1;
        assert(out == 16'b1011_1110_0001_0100) else $error("Shift failed 1");
        #1;

        shift = 4'd4; #1;
        assert(out == 16'b1111_0000_1010_0000) else $error("Shift failed 2");
        #1;

        shift = 4'd8; #1;
        assert(out == 16'b0000_1010_0000_0000) else $error("Shift failed 3");
        #1;


        $finish;
    end

endmodule;