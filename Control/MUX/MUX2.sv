
module MUX2(
    input logic s,
    input logic [15:0] input0,
    input logic [15:0] input1,
    output logic [15:0] out
);

    assign out = s ? input0 : input1;

endmodule