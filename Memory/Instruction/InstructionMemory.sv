


module InstructionMemory(
    input logic [15:0] instructionAddress,
    output logic [15:0] instruction
);
    logic [7:0] storage [0: (2**8 - 1)];

    assign storage[instructionAddress];

endmodule