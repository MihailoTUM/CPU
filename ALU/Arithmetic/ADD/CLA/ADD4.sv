

module ADD4(
    input logic [3:0] a,
    input logic [3:0] b,
    input logic blockCin,
    output logic [3:0] s,
    output logic blockCout
);
    logic c1, c2, c3;
    logic p0, p1, p2, p3;
    logic g0, g1, g2, g3;

    assign p0 = a[0] ^ b[0];
    assign g0 = a[0] & b[0];

    assign p1 = a[1] ^ b[1];
    assign g1 = a[1] & b[1];

    assign p2 = a[2] ^ b[2];
    assign g2 = a[2] & b[2];

    assign p3 = a[3] ^ b[3];
    assign g3 = a[3] & b[3];

    assign c1 = g0 | (p0 & blockCin);
    assign c2 = g1 | (p1 & g0) | (p1 & p0 & blockCin);
    assign c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & blockCin);
    assign blockCout  = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & blockCin);

    assign s[0] = p0 ^ blockCin;
    assign s[1] = p1 ^ c1;
    assign s[2] = p2 ^ c2;
    assign s[3] = p3 ^ c3;

endmodule