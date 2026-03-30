

module RegisterBlock(
    input logic clk,
    input logic [15:0] data,
    input logic [3:0] dst,
    input logic [3:0] src1,
    input logic [3:0] src2,
    output logic [15:0] a,
    output logic [15:0] b
);

    logic [15:0] registers [15:0];

    always_ff @(posedge clk)
    begin
        case(dst)
            4'h0: registers[0] <= data;
            4'h1: registers[1] <= data;
            4'h2: registers[2] <= data;
            4'h3: registers[3] <= data;
            4'h4: registers[4] <= data;
            4'h5: registers[5] <= data;
            4'h6: registers[6] <= data;
            4'h7: registers[7] <= data;
            4'h8: registers[8] <= data;
            4'h9: registers[9] <= data;
            4'hA: registers[10] <= data;
            4'hB: registers[11] <= data;
            4'hC: registers[12] <= data;
            4'hD: registers[13] <= data;
            4'hE: registers[14] <= data;
            4'hF: registers[15] <= data;
        endcase
    end

    always_comb 
    begin
        case(src1)
            4'h0: a = registers[0];
            4'h1: a = registers[1];
            4'h2: a = registers[2];
            4'h3: a = registers[3];
            4'h4: a = registers[4];
            4'h5: a = registers[5];
            4'h6: a = registers[6];
            4'h7: a = registers[7];
            4'h8: a = registers[8];
            4'h9: a = registers[9];
            4'hA: a = registers[10];
            4'hB: a = registers[11];
            4'hC: a = registers[12];
            4'hD: a = registers[13];
            4'hE: a = registers[14];
            4'hF: a = registers[15];
        endcase

        case(src2)
            4'h0: b = registers[0];
            4'h1: b = registers[1];
            4'h2: b = registers[2];
            4'h3: b = registers[3];
            4'h4: b = registers[4];
            4'h5: b = registers[5];
            4'h6: b = registers[6];
            4'h7: b = registers[7];
            4'h8: b = registers[8];
            4'h9: b = registers[9];
            4'hA: b = registers[10];
            4'hB: b = registers[11];
            4'hC: b = registers[12];
            4'hD: b = registers[13];
            4'hE: b = registers[14];
            4'hF: b = registers[15];
        endcase
    end
endmodule