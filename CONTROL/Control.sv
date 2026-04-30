

module Control(
    input logic clk,
    output logic [3:0] controlSignals
);
    /*  ControlSignals
        0: hold
        1: pipeLine flush
        2: jmp
        3: memory stall
        4: out-of order execution
    */
    
    assign controlSignals = { 1'b0, 1'b0, 1'b0, 1'b0 };

endmodule