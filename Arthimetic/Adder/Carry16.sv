

module Carry16(
    input logic [15:0] a,
    input logic [15:0] b,
    input logic cin,
    output logic [15:0] s,
    output logic cout
);
    logic carry[2:0];

    CarryLookAhead4 b0(a[3:0], b[3:0], cin, s[3:0], carry[0]);
    CarryLookAhead4 b1(a[7:4], b[7:4], carry[0], s[7:4], carry[1]);
    CarryLookAhead4 b2(a[11:8], b[11:8], carry[1], s[11:8], carry[2]);
    CarryLookAhead4 b3(a[15:12], b[15:12], carry[2], s[15:12], cout);

endmodule