

module Fetch(
    // control inputs
    input logic clk,
    input logic reset,
    input logic hold, 
    input logic inJMP,
    input logic inEnableWrite

    // data inputs
    input logic [15:0] inNewAddress;
    
    // outputs
    output logic [15:0] instructionAddress,
    output logic [15:0] instruction
);
    logic [15:0] address;

    always_ff @(posedge clk) 
        begin
            if(reset) address <= 16'h0000;
            else if(hold) address <= address;
            else if (inJMP) address <= inNewAddress;
            else address <= address + 2;
        end

    InstructionMemory instructionMemory(
        .address(address),

        .instruction(instruction)
    );

    assign instructionAddress = address;

endmodule