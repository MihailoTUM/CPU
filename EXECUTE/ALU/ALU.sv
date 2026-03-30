

module ALU(
    input logic [3:0] opcode,
    input logic [15:0] a,
    input logic [15:0] b,
    input logic [7:0] immediateOperand,
    output logic [15:0] result
);
    logic [15:0] constOut;

    logic [15:0] addOut;
    logic cout;

    // arithmetic
    CONST16 const16(immediateOperand, constOut);
    ADD16 add16(a, b, 1'b0, addOut, cout);

    always_comb
    begin 
        case(opcode)
            4'h0: result = constOut;
            4'h1: result = addOut;
            default: result = 16'h0000;
        endcase
    end
endmodule