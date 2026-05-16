

module Fetch(
    // control inputs
    // input logic clk,
    // input logic inEnableWrite

    // data inputs
    input logic [15:0] inAddress,
        
    // data outputs
    output logic [15:0] outInstruction
);

    InstructionMemory instructionMemory(
        .inAddress(inAddress),

        .outInstruction(outInstruction)
    );

endmodule