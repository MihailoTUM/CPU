

module mux2(
    input logic [3:0] d0,
    input logic [3:0] d1,
    input logic s,
    output logic [3:0] o
);

    assign o = s ? d1 : d0;

endmodule;