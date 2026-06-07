
module PipelineRegisterDE(
    input logic clk,
    input logic reset,
    input logic hold,
    input logic flush,

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
            if(hold)
                begin
                    outInstructionAddress <= outInstructionAddress;
                    outOperation <= outOperation;
                    outDstAddress <= outDstAddress;
                    outData1Address <= outData1Address;
                    outData2Address <= outData2Address;
                    outImmediate <= outImmediate;
                end
            else if(flush)
                begin
                    outInstructionAddress <= 16'h0000;
                    outOperation = 4'hF;
                    outDstAddress <= 4'h0;
                    outData1Address <= 4'h0;
                    outData2Address <= 4'h0;
                    outImmediate <= 8'h00;
                end
            else if(reset)
                begin
                    outInstructionAddress <= 16'h0000;
                    outOperation = 4'hF;
                    outDstAddress <= 4'h0;
                    outData1Address <= 4'h0;
                    outData2Address <= 4'h0;
                    outImmediate <= 8'h00;
                end
            else
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