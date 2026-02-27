

module MiniComparator(
    input logic [15:0] a,
    input logic [15:0] b,
    output logic y
);

    assign y = ~|(a ^ b);

endmodule