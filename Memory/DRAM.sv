/*
    DRAM (16 bit address, 16 bit data)
    at: 0x0000 InstructionSegment
    at: 0x8000 DataSegment
*/

module DRAM(
    input logic clk,
    input logic writeEnable,
    input logic [15:0] instructionAddress,
    input logic [15:0] dataAddress,
    input logic [15:0] dataInput,
    output logic [15:0] dataOuput,
    output logic [15:0] instructionOutput
);
    logic [15:0] storage [0: (2**16 - 1)];

    always_ff @(posedge clk) 
    begin
        if(writeEnable) storage[dataAddress] <= dataInput;
    end

    assign dataOuput = storage[dataAddress];
    assign instructionOuput = storage[instructionAddress];
endmodule