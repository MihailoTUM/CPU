

module CONST16(
    input logic [7:0] a,
    output logic [15:0] out
);

    assign out = {{ 8{ a[7] } }, a };

endmodule