

module Execute(
    input logic clk,
    input logic [3:0] opcode,
    input logic [3:0] dst,
    input logic [15:0] srcA,
    input logic [15:0] srcB,
    output logic [15:0] data,
    output logic [3:0] writeBackDst
);

    EXRegister exregister(
        .clk(clk),
        .dst(dst),
        .srcA(srcA),
        .srcB(srcB),
        .ALU1(),
        .ALU2(),
        .writeBackDst(dst)
    );

    // ALU


endmodule