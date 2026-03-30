
/*
    a * b
*/

module MUL16(
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [15:0] out,
    output logic [15:0] cout
);
    logic [31:0] x0;
    logic [31:0] x1;
    logic [31:0] x2;
    logic [31:0] x3;
    logic [31:0] x4;
    logic [31:0] x5;
    logic [31:0] x6;
    logic [31:0] x7;
    logic [31:0] x8;
    logic [31:0] x9;
    logic [31:0] x10;
    logic [31:0] x11;
    logic [31:0] x12;
    logic [31:0] x13;
    logic [31:0] x14;
    logic [31:0] x15;

    // multiplication = 16 additions
    always_comb 
    begin 
        x0 = { 16{1'b0}, a[0] & b };

      
    end
endmodule