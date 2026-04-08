

module ALU(
    input logic [3:0] operation,
    input logic [15:0] data1,
    input logic [15:0] data2,
    input logic [7:0] immediateOperand,
    output logic [15:0] result
);
    logic [15:0] constOut;

    logic [15:0] addOut;
    logic cout;

    // arithmetic
    CONST16 const16(immediateOperand, constOut);
    ADD16 add16(data1, data2, 1'b0, addOut, cout);

    always_comb
    begin 
        case(operation)
            4'h0: result = constOut;
            4'h1: result = addOut;
            default: result = 16'h0000;
        endcase
    end
endmodule