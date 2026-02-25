

module HexSegment(
    input logic [3:0] in,
    output logic [6:0] out
);

    always_comb
    begin
        case(in)
            4'h0: out = 7'b111_1110;
            4'h1: out = 7'b011_0000;
            4'h2: out = 7'b110_1100;
            4'h3: out = 7'b001_0011;
            4'hA: out = 7'b111_0111;
            4'hB: out = 7'b001_1111;
            // ...
        endcase
    end

endmodule;