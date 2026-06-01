
module InstructionMemory(
    input logic [15:0] inAddress,

    output logic [15:0] outInstruction
);
    logic [15:0] memory [0: (2**8 - 1)];
    
    always_comb 
    begin
        case(inAddress)
        16'h0002: outInstruction = 16'h0008;
        16'h0004: outInstruction = 16'h0102;
        16'h0006: outInstruction = 16'h1201;
        16'h0008: outInstruction = 16'h80FE;
        16'h000A: outInstruction = 16'h03FF;

        default: outInstruction = 16'hFFFF;
        endcase
    end
    
endmodule