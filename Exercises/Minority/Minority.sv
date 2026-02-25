

module Minority(
    input logic a, b, c,
    output logic s
);
    logic x, y, z;
    assign x = (~a) & (~b);
    assign y = (~a) & (~c);
    assign z = (~b) & (~c);

    assign s = x | y | z;
endmodule;