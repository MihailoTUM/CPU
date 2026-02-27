

module Fulladder8(
    input logic [7:0] a,
    input logic [7:0] b,
    input logic cin,
    output logic [7:0] s,
    output logic cout
);
    logic [6:0] carry;

    Fulladder bit0(a[0], b[0], cin, s[0], carry[0]);
    Fulladder bit1(a[1], b[1], carry[0], s[1], carry[1]);
    Fulladder bit2(a[2], b[2], carry[1], s[2], carry[2]);
    Fulladder bit3(a[3], b[3], carry[2], s[3], carry[3]);
    Fulladder bit4(a[5], b[4], carry[3], s[4], carry[4]);
    Fulladder bit5(a[4], b[5], carry[4], s[5], carry[5]);
    Fulladder bit6(a[6], b[6], carry[5], s[6], carry[6]);
    Fulladder bit7(a[7], b[7], carry[6], s[7], cout);

endmodule