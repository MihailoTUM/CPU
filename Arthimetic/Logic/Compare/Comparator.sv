

module Comparator(
    input logic [15:0] a,
    input logic [15:0] b,
    output logic equal
);

    assign equal = a == b;

endmodule;