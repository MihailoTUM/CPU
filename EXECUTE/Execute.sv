

module Execute(
    input logic clk,
    input logic [3:0] opcode,
    input logic [3:0] dst,
    input logic [15:0] srcA,
    input logic [15:0] srcB,
    input logic [7:0] iOperand,
    output logic [15:0] data,
    output logic [3:0] writeBackDst
);

    logic [15:0] ALU1;
    logic [15:0] ALU2;

    logic [7:0] immediateOperand;

    EXRegister exregister(
        .clk(clk),
        .dst(dst),
        .directOperand(iOperand),
        .srcA(srcA),
        .srcB(srcB),
        .ALU1(ALU1),
        .ALU2(ALU2),
        .writeBackDst(dst),
        .immediateOperand(immediateOperand)
    );

    // ALU
    ALU alu(    
        .opcode(opcode),
        .a(ALU1),
        .b(ALU2),
        .immediateOperand(immediateOperand),
        .result(data)  
    );

    assign writeBackDst = dst;

endmodule