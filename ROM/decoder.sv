

module decoder3_8(
    input logic [2:0] a,
    output logic [7:0] y
);

    always_comb
    begin
        case(a)
            3'b000: y = 8'h01;
            3'b001: y = 8'h02;
            3'b010: y = 8'h04;
            3'b011: y = 8'h08;
            3'b100: y = 8'h10;
            3'b101: y = 8'h20;
            3'b110: y = 8'h40;
            3'b111: y = 8'h80;
            default: y = 8'hxx;
        endcase
    end
        
endmodule