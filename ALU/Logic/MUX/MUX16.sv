

module MUX16(
    input logic [15:0] in,
    input logic [3:0] con,
    output logic out
);

    assign out = in[con];

endmodule