

module Sub16(
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [15:0] s,
    output logic cout
);

    Carry16 adder(a, ~b, 1'b1, s, cout);
endmodule