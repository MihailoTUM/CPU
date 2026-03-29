


module InstructionMemory(
    input logic [15:0] address,
    output logic [15:0] instruction
);
    logic [15:0] storage [0: (2**8 - 1)];

    assign storage[address];

endmodule