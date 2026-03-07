

module Memory(
    input logic [15:0] address,
    output logic [15:0] instruction
);

    always_comb 
    begin
        case(address)
        16'h0000: instruction = 16'h0000;
        16'h0002: instruction = 16'h8000;
        16'h0004: instruction = 16'h8100;
        16'h0006: instruction = 16'h2201;
        16'h0008: instruction = 16'h0004;
        16'h000A: instruction = 16'h0005;
        16'h000C: instruction = 16'h0006;
        16'h000E: instruction = 16'h0007;
        16'h0010: instruction = 16'h0008;
        16'h0012: instruction = 16'h0009;
        16'h0014: instruction = 16'h000A;
        default: instruction = 16'hxxxx;
        endcase
    end
endmodule