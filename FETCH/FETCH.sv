

module FETCH(
    input logic clk,
    input logic reset,
    output logic [15:0] instruction
);
    logic [15:0] address;
    logic [15:0] localInstruction;

    always_ff @(posedge clk) 
    begin
        if(reset) begin
            address <= 16'h0000;
        end
        else begin
            address <= address + 2;
        end
    end

    InstructionMemory instructionMemory(
        .clk(clk),
        .address(address)
        .instruction(localInstruction)
    );

    PCR pcr(
        .clk(clk),
        .instructionToStore(localInstruction),
        .instructionToShare(instruction);
    );
endmodule