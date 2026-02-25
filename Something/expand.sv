

module expand(
    input logic[7:0] in,
    input logic sign,
    output logic [15:0] expandedInput
);

    assign expandedInput = sign ? {{8{in[7]}}, in } : { 8'h00, in };

endmodule