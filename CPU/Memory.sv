

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
        default: instruction = 16'hxxxx;
        endcase
    end
endmodule