

module ADD32(
    input logic [31:0] a,
    input logic [31:0] b,
    output logic [31:0] out,
    output logic cout;
);
    logic localCout;

    ADD16 low(a[15:0], b[15:0], 1'b0, out[15:0], localCout);
    ADD16 high(a[31:16], b[31:16], logcalCout, out[31:16], cout);

endmodule;