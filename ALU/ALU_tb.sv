`timescale 1ns/1ns

module ALU_tb;
    logic [2:0] opcode;
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] out;
    logic [3:0] flag;

    ALU dut(
        .opcode(opcode),
        .a(a),
        .b(b),
        .out(out),
        .flag(flag)
    );

    initial begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_tb);

        // // addition
        // a = 16'h00FF; b = 16'h0010; opcode = 2'b11; #1;
        // assert(out == 16'h010F) else $error("Addition 1 failed");
        // assert(flag == 4'b0000) else $error("flag 1 failed");
        // #1;

        // a = 16'hFFFF; b = 16'h0001; opcode = 2'b11; #1;
        // assert(out == 16'h0000) else $error("Addition 2 failed");
        // assert(flag == 4'b0110) else $error("flag 2 failed");
        // #1;
        
        // a = 16'hFFFF; b = 16'h8000; opcode = 2'b11; #1;
        // assert(out == 16'h7FFF) else $error("Addition 3 failed");
        // assert(flag == 4'b0011) else $error("flag 3 failed");

        a = 16'h00FF; b = 16'h0004; opcode = 3'b100; #1;
        assert(out == 16'h000F) else $error("Shift failed");

        $finish;
    end

endmodule