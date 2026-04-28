

module Fetch(
    input logic clk,
    input logic reset,
    input logic hold, 
    input logic [15:0] relativeAddress,
    input logic [15:0] fixedAddress,
    output logic [15:0] instruction
);
    logic [15:0] address;

    always_ff @(posedge clk) 
        begin
            if(reset) address <= 16'h0000;
            else if(hold) address <= address;
            else address <= address + 2;
        end

    InstructionMemory instructionMemory(
        // inputs
        .address(address),
        // outputs
        .instruction(instruction)
    );

endmodule