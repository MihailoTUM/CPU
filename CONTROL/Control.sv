

module Control(
    input logic clk,
    output logic [1:0] controlSignals
);
    
    assign controlSignals = { 1'b1, 1'b0 };

endmodule