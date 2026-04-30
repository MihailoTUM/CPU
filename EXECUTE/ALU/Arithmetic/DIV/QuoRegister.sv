

module QuoRegister(
    input logic clk,
    input logic reset,
    input logic digit,
    input logic [3:0] selection,
    output logic [15:0] q
);
    logic [15:0] quotient;

    always_ff @(posedge clk)
    begin
        if(reset)
        begin
            quotient <= 16'h0000;
        end
        else 
        begin
            case(selection)
            4'h0: quotient[15] <= digit;
            4'h1: quotient[14] <= digit;
            4'h2: quotient[13] <= digit;
            4'h3: quotient[12] <= digit;
            4'h4: quotient[11] <= digit;
            4'h5: quotient[10] <= digit;
            4'h6: quotient[9] <= digit;
            4'h7: quotient[8] <= digit;
            4'h8: quotient[7] <= digit;
            4'h9: quotient[6] <= digit;
            4'hA: quotient[5] <= digit;
            4'hB: quotient[4] <= digit;
            4'hC: quotient[3] <= digit;
            4'hD: quotient[2] <= digit;
            4'hE: quotient[1] <= digit;
            4'hF: quotient[0] <= digit;
            default: quotient <= quotient;
            endcase
        end
    end

    assign q = quotient;

endmodule