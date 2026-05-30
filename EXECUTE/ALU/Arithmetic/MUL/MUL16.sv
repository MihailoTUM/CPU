
module MUL16(
    input logic [15:0] a,
    input logic [15:0] b,
    
    output logic [15:0] higherOut,
    output logic [15:0] lowerOut
);
    logic [31:0] result;

    // 16 partials a 16-bit width
    logic [15:0] partials [15:0];

    assign partials[0] = b[0] ? a : 16'h0000;
    assign partials[1] = b[1] ? a : 16'h0000;
    assign partials[2] = b[2] ? a : 16'h0000;
    assign partials[3] = b[3] ? a : 16'h0000;
    assign partials[4] = b[4] ? a : 16'h0000;
    assign partials[5] = b[5] ? a : 16'h0000;
    assign partials[6] = b[6] ? a : 16'h0000;
    assign partials[7] = b[7] ? a : 16'h0000;
    assign partials[8] = b[8] ? a : 16'h0000;
    assign partials[9] = b[9] ? a : 16'h0000;
    assign partials[10] = b[10] ? a : 16'h0000;
    assign partials[11] = b[11] ? a : 16'h0000;
    assign partials[12] = b[12] ? a : 16'h0000;
    assign partials[13] = b[13] ? a : 16'h0000;
    assign partials[14] = b[14] ? a : 16'h0000;
    assign partials[15] = b[15] ? a : 16'h0000;

    // implement a smarter design

    logic [31:0] pSums [15:0];

    assign pSums[0] = { 16'b0000_0000_0000_0000, partials[0]};
    assign pSums[1] = { 15'b000_0000_0000_0000, partials[1], 1'b0 };
    assign pSums[2] = { 14'b00_0000_0000_0000, partials[2], 2'b00 };
    assign pSums[3] = { 13'b0_0000_0000_0000, partials[3], 3'b000 };
    assign pSums[4] = { 12'b0000_0000_0000, partials[4], 4'b0000 };
    assign pSums[5] = { 11'b000_0000_0000, partials[5], 5'b0_0000 };
    assign pSums[6] = { 10'b00_0000_0000, partials[6], 6'b00_0000 };
    assign pSums[7] = { 9'b0_0000_0000, partials[7], 7'b000_0000 };
    assign pSums[8] = { 8'b0000_0000, partials[8], 8'b0000_0000 };
    assign pSums[9] = { 7'b000_0000, partials[9], 9'b0_0000_0000 };
    assign pSums[10] = { 6'b00_0000, partials[10], 10'b00_0000_0000 };
    assign pSums[11] = { 5'b0_0000, partials[11], 11'b000_0000_0000 };
    assign pSums[12] = { 4'b0000, partials[12], 12'b0000_0000_0000 };
    assign pSums[13] = { 3'b000, partials[13], 13'b0_0000_0000_0000 };
    assign pSums[14] = { 2'b00, partials[14], 14'b00_0000_0000_0000 };
    assign pSums[15] = { 1'b0, partials[15], 15'b000_0000_0000_0000 };


    logic [31:0] sum [13:0];

    ADD32 add0(pSums[0], pSums[1], 1'b0, sum[0], );
    ADD32 add1(sum[0], pSums[2], 1'b0, sum[1], );
    ADD32 add2(sum[1], pSums[3], 1'b0, sum[2], );
    ADD32 add3(sum[2], pSums[4], 1'b0, sum[3], );
    ADD32 add4(sum[3], pSums[5], 1'b0, sum[4], );
    ADD32 add5(sum[4], pSums[6], 1'b0, sum[5], );
    ADD32 add6(sum[5], pSums[7], 1'b0, sum[6], );
    ADD32 add7(sum[6], pSums[8], 1'b0, sum[7], );
    ADD32 add8(sum[7], pSums[9], 1'b0, sum[8], );
    ADD32 add9(sum[8], pSums[10], 1'b0, sum[9], );
    ADD32 add10(sum[9], pSums[11], 1'b0, sum[10], );
    ADD32 add11(sum[10], pSums[12], 1'b0, sum[11], );
    ADD32 add12(sum[11], pSums[13], 1'b0, sum[12], );
    ADD32 add13(sum[12], pSums[14], 1'b0, sum[13], );
    ADD32 add14(sum[13], pSums[15], 1'b0, result, );

    assign higherOut = result[31:16];
    assign lowerOut = result[15:0];
endmodule