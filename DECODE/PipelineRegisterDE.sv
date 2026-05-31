
module PipelineRegisterDE(
    input logic clk,

    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,

    output logic [15:0] outInstructionAddress,
    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,
    output logic [3:0] outData1Address,
    output logic [3:0] outData2Address,
    output logic [7:0] outImmediate
);
    always_ff @(posedge clk)
        begin 
            begin 
                outInstructionAddress <= inInstructionAddress;
                outOperation <= inInstruction[15:12];
                outDstAddress <= inInstruction[11:8];
                outData1Address <= inInstruction[7:4];
                outData2Address <= inInstruction[3:0];
                outImmediate <= inInstruction[7:0];
            end
        end
endmodule