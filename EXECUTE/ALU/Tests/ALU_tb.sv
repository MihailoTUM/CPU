`timescale 1ns/1ns

module ALU_tb();
    logic [3:0] opcode;
    logic [15:0] a;
    logic [15:0] b;
    logic [7:0] immediateOperand;
    logic [15:0] result;

    ALU dut(
        .opcode(opcode),
        .a(a),
        .b(b),
        .immediateOperand(immediateOperand),
        .result(result)
    );

    initial begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_tb);

        // CONST
        opcode = 4'h0; immediateOperand = 8'h04; #2;
        assert(result == 16'h0004) else $error("Test 1 failed");

        // ADD
        opcode = 4'h1; a = 16'h0001; b = 16'h000C; #2;
        assert(result == 16'h000D) else $error("Test 2 failed");

    end


endmodule;