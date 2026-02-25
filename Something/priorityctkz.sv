

module priorityctkz(
    input logic [3:0] a,
    output logic [3:0] y
);
    always_comb
    begin
        case(a)
        4'b1???: y = 4'h8;
        4'b01??: y = 4'h4;
        4'b001?: y = 4'h2;
        4'b0001: y = 4'h1;
        default: y = 4'h0;
        endcase
    end


endmodule