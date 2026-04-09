

module Fetch(
    input logic clk,
    input logic reset,
    output logic [15:0] instruction
);
    logic [15:0] address;

    always_ff @(posedge clk) 
        begin
            if(reset) address <= 16'h0000;
            else address <= address + 2;
        end

    InstructionMemory instructionMemory(
        // inputs
        .address(address),
        // outputs
        .instruction(instruction)
    );

endmodule