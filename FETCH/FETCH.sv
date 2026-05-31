

module Fetch(
    input logic [15:0] inAddress,
        
    output logic [15:0] outInstruction
);

    InstructionMemory instructionMemory(
        .inAddress(inAddress),

        .outInstruction(outInstruction)
    );

endmodule