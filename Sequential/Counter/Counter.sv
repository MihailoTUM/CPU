

module Counter(
    input logic clk,
    input logic reset,
    output logic [3:0] out
);

    always_ff @(posedge clk) 
    begin
        if(reset) out <= 4'b0000;
        else out <= out + 1;
    end

endmodule


/*



module light(
    input logic clk,
	 input logic reset,
	 output logic [25:0] q1,
	 output logic [3:0] q2,
	 output logic [6:0] code
);
	logic previous;
	
	always_ff @(posedge clk)
	begin	
		if(reset) begin
			q1 <= 26'b00_0000_0000_0000_0000_0000_0000;
			q2 <= 4'b0000;
			previous <= 0;
		end
		else begin
			previous <= q1[25];
			q1 <= q1 + 1;	
			if(previous != q1[25]) q2 <= q2 + 1;
		end
	end
	
	always_comb
	begin
		case(q2)
		4'h0: code = 7'b000_0001;
		4'h1: code = 7'b100_1111;
		4'h2: code = 7'b001_0010;
		default: code = 7'b000_0000;
		endcase
	end
endmodule

*/