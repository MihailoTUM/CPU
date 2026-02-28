

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