
module InstructMemory(
    input logic [15:0] address,
    output logic [15:0] instruction
);
    logic [15:0] memory [0: (2**8 - 1)];

    assign instruction = memory[address];        
endmodule