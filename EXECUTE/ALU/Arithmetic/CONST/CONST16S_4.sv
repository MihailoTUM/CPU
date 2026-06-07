

module CONST16S_4(
    input logic [3:0] a,
    output logic [15:0] out
);
    assign out = {{ 12{ a[3] }}, a};
endmodule