
module InstructionMemory(
    input logic [15:0] address,
    output logic [15:0] instruction
);
    logic [15:0] memory [0: (2**8 - 1)];

    // assign instruction = memory[address];     
    
    always_comb 
    begin
        case(address)
        16'h0000: instruction = 16'h0201;
        16'h0002: instruction = 16'h0120;
        16'h0004: instruction = 16'h4021;
        default: instruction = 16'h0000;
        endcase
    end
    
endmodule