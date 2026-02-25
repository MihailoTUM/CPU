

module ROM(
    input logic [3:0] address,
    output logic [3:0] data
);

    always_comb 
    begin
        case
            4'h0: data = 4'b0000;
            4'h1: data = 4'b1101;
            default: data = 4'b1111;
        endcase
    end

endmodule;