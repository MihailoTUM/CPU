/*
    DRAM (16 bit address, 16 bit data)
    at: 0x0000 InstructionSegment
    at: 0x8000 DataSegment
*/

module DRAM(
    input logic clk,
    input logic write_enable,
    input logic reset,
    input logic [15:0] address,
    input logic [15:0] inputData,
    output logic [15:0] outputData
);
    logic [15:0] storage [0: (2**16 - 1)];

    always_ff @(posedge clk) 
    begin
        if(write_enable) storage[address] <= inputData;
    end

    assign outputData = storage[address];

endmodule