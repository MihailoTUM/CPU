

module AND16(
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [15:0] out
);

    assign out = a & b;

endmodule