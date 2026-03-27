

module CPU(
    input logic clk,
    input logic reset
);
    logic [2:0] opcode;
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] out;
    logic [3:0] flag;
    logic [15:0] instruction;
    logic we;

    Control Control(
        .clk(clk),
        .reset(reset)
    );

    // Registers
    Registerblock Registerblock(
        .clk(clk),
        .reset(reset),
        .we(1'b1),
        .dst(instruction[11:8]),
        .source1(instruction[7:4]),
        .source2(instruction[3:0]),
        .dataIn(out),
        .out1(a),
        .out2(b)
    );

    // ALU
    ALU ALU(
        .opcode(instruction[15:12]),
        .a(a),
        .b(b),
        .out(out),
        .flag(flag)
    );

    DRAM dram(
        .clk(clk),
        .write_enable(1'b1),
        .
    );

endmodule