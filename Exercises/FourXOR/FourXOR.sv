

module FourXOR(
    input logic [3:0] a,
    output logic y
);

    assign y = a[3] ^ a[2] ^ a[1] ^ a[0];

endmodule