

module DivRegister(
    input logic clk,
    input logic reset,
    input logic [15:0] writeLowData,
    input logic [15:0] writeHighData,
    input logic enableWriteHigh,
    input logic shift,
    output logic [15:0] q
);
    logic [31:0] dividend;

    always_ff @(posedge clk)
    begin
        if(reset)
        begin
            dividend[31:16] <= 16'h0000;
            dividend[15:0] <= writeLowData;
        end

        else if(enableWriteHigh)
        begin
            dividend[31:16] <= writeHighData;
        end

        else if (shift)
        begin
            dividend[31] <= dividend[30];
            dividend[30] <= dividend[29];
            dividend[29] <= dividend[28];
            dividend[28] <= dividend[27];
            dividend[27] <= dividend[26];
            dividend[26] <= dividend[25];
            dividend[25] <= dividend[24];
            dividend[24] <= dividend[23];
            dividend[23] <= dividend[22];
            dividend[22] <= dividend[21];
            dividend[21] <= dividend[20];
            dividend[20] <= dividend[19];
            dividend[19] <= dividend[18];
            dividend[18] <= dividend[17];
            dividend[17] <= dividend[16];
            dividend[16] <= dividend[15];
            dividend[15] <= dividend[14];
            dividend[14] <= dividend[13];
            dividend[13] <= dividend[12];
            dividend[12] <= dividend[11];
            dividend[11] <= dividend[10];
            dividend[10] <= dividend[9];
            dividend[9] <= dividend[8];
            dividend[8] <= dividend[7];
            dividend[7] <= dividend[6];
            dividend[6] <= dividend[5];
            dividend[5] <= dividend[4];
            dividend[4] <= dividend[3];
            dividend[3] <= dividend[2];
            dividend[2] <= dividend[1];
            dividend[1] <= dividend[0];
            dividend[0] <= 1'b0;
        end
    end

    assign q = dividend[31:16];

endmodule