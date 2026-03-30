

module EXRegister(
    input logic clk,
    input logic [3:0] dst,
    input logic [15:0] srcA,
    input logic [15:0] srcB,
    output logic [15:0] ALU1,
    output logic [15:0] ALU2,
    output logic [3:0] writeBackDst
);

    always_ff @(posedge clk)
    begin 
        ALU1 <= srcA;
        ALU2 <= srcB;
        writeBackDst <= dst;
    end
endmodule