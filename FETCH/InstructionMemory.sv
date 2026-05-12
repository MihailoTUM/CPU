
module InstructionMemory(
    // input logic clk
    input logic [15:0] address,
    output logic [15:0] instruction
);
    logic [15:0] memory [0: (2**8 - 1)];
    
    always_comb 
    begin
        case(address)
        16'h0000: instruction = 16'h000A;
        16'h0002: instruction = 16'h0102;
        16'h0004: instruction = 16'hFFFF;
        16'h0006: instruction = 16'hFFFF;
        16'h0008: instruction = 16'hFFFF;
        16'h000A: instruction = 16'h1201;
        16'h000C: instruction = 16'h3312;

        default: instruction = 16'hXXXX;
        endcase
    end
    
endmodule