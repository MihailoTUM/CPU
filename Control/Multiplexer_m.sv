

module Multiplexer_m(
    input logic [15:0] d0, d1,
    input logic control,
    output logic [15:0] out
);
    assign out = control ? d1 : d0; // ternary operator

endmodule;