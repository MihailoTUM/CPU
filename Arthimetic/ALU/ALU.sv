

module ALU(
    input logic [3:0] opcode,
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [15:0] out,
    output logic [3:0] flag
);
    logic [15:0] out1;
    logic [15:0] out2;
    logic [15:0] out3;
    logic [15:0] out4;
    logic [15:0] out5;
    logic [15:0] out6;
    logic [15:0] out7;
    logic [15:0] out8;
    logic [15:0] out9;
    logic [1:0] cout;

    ADD16 add16(a, b, 1'b0, out1, cout[0]);
    SUB16 sub16(a, b, out2, cout[1]);
    AND16 and16(a, b, out3);
    OR16 or16(a, b, out4);
    SRU sru16(a, b[3:0], out5);
    SLU slu16(a, b[3:0], out6);
    CONST16 const16(8'h01, out7);

    // 0000 -> AND
    // 0001 -> OR
    // 0010 -> AND
    // 0011 -> SUB
    // 0100 -> SRU
    // 0101 -> SLU
    // 0110 -> MUL
    // 0111 -> DIV
    // 1000 -> CONST
    // 1001 -> LOAD
    // 1010 -> STORE


    always_comb
    begin
        case(opcode)
            4'b0000: out = out1;
            4'b0001: out = out2;
            4'b0010: out = out3;
            4'b0011: out = out4;
            4'b0100: out = out5;
            4'b0101: out = out6;
            4'b1000: out = out7;
            default: out = 16'h0000;
        endcase
    end


    // flag
    assign flag[3] = out[15]; // Negative
    assign flag[2] = &(~out); // Zero
    assign flag[1] = opcode[0] ? cout[0] : cout[1]; // Carry
    assign flag[0] = (a[15] & b[15] & ~out[15]) | (~a[15] & ~b[15] & out[15]); // Overflow

endmodule