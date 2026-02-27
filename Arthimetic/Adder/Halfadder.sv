

module Halfadder(
    input logic a,
    input logic b,
    output logic s,
    output logic cout
);

    assign s = a ^ b;
    assign cout = a & b;

endmodule