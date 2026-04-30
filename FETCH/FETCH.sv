

module Fetch(
    input logic clk,
    input logic reset,
    // pipeline stall
    input logic hold, 
    // new address for JMP
    input logic JMP,
    input logic [15:0] relativeAddress,
    // new address for BRANCH, function calls
    input logic BRANCH,
    input logic [15:0] fixedAddress,
    // writing in instruction memory
    input logic enableWrite,
    // outputs
    output logic [15:0] instruction
);
    logic [15:0] address;

    always_ff @(posedge clk) 
        begin
            // reset PC
            if(reset) address <= 16'h0000;
            // hold PC at same address
            else if(hold) address <= address;
            // JMP to relative address
            else if(JMP) address <= address + relativeAddress;
            // BRANCH to fixed address
            else if(BRANCH) address <= fixedAddress;
            // normal program development
            else address <= address + 2;
        end

    // read-only memory so far
    InstructionMemory instructionMemory(
        // inputs
        .address(address),
        // outputs
        .instruction(instruction)
    );

endmodule