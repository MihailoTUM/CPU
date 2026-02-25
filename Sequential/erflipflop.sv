

module erflipflop(
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [3:0] d,
    output logic [3:0] q
);
    
    always @(posedge clk)
        if(reset) q <= 4'b0;
        else if(enable) q <= d;

endmodule;