

module Decode(
    input logic clk,
    input logic [15:0] instruction,
    input logic [15:0] data,
    output logic [15:0] a,
    output logic [15:0] b
);
    logic [3:0] opcode;
    logic [3:0] dst;
    logic [3:0] src1;
    logic [3:0] src2;

    DERegister register(
        .clk(clk),
        .instruction(instruction),
        .opcode(opcode),
        .dst(dst),
        .src1(src1),
        .src2(src2)
    );

    RegisterBlock registerBlock(
        .clk(clk),  
        .data(data),
        .dst(dst),
        .src1(src1),
        .src2(src2),
        .a(a),
        .b(b)
    );
endmodule