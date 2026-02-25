

module delay(
    input logic a, b, c,
    output logic x, y, z
);

    // delay for 1 ns, undefined value
    assign #1 x = ~a;

    // delay for 1 ns
    assign #1 y = b | c;

    // delay for 10 ns
    assign #10 z = a & b & c;

endmodule