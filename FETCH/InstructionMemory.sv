
module InstructionMemory(
    // control inputs
    // input logic clk,

    // data inputs
    input logic [15:0] inAddress,

    // data outputs
    output logic [15:0] outInstruction
);
    logic [15:0] memory [0: (2**8 - 1)];
    
    always_comb 
    begin
        case(inAddress)
        16'h0002: outInstruction = 16'h000A;
        16'h0004: outInstruction = 16'h0101;
        16'h0006: outInstruction = 16'h1201;

        default: outInstruction = 16'hXXXX;
        endcase
    end
    
endmodule