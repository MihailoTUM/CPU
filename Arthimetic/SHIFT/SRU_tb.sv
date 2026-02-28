

module SRU_tb;
    logic [15:0] a;
    logic [3:0] shift;
    logic [15:0] out;

    SRU dut(
        .a(a),
        .shift(shift),
        .out(out)
    );

    initial begin
        $dumpfile("SRU.vcd");
        $dumpvars(0, SRU_tb);

        a = 16'b0000_1111_1010_0101; shift = 4'd1; #1;
        assert(out == 16'b0000_0111_1101_0010) else $error("Shift 1 failed");
        #1;

        shift = 4'd4; #1;
        assert(out == 16'b0000_0000_1111_1010) else $error("Shift 2 failed");
        #1;

        shift = 4'd8; #1;
        assert(out == 16'b0000_0000_0000_1111) else $error("Shift 3 failed");
        #1;

        shift = 4'd15; #1;
        assert(out == 16'b0000_0000_0000_0000) else $error("Shift 4 failed");
        #1;


        $finish;
    end

endmodule