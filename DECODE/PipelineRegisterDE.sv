// pipeline register

module PipelineRegisterDE(
    // control inputs
    input logic clk,
    input logic hold,
    input logic flush,

    // data inputs
    input logic [15:0] inInstructionAddress,
    input logic [15:0] inInstruction,

    // data outputs
    output logic [15:0] outInstructionAddress,
    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,
    output logic [3:0] outSrc1Address,
    output logic [3:0] outSrc2Address,
    output logic [7:0] outImmediate
);
    logic [15:0] localInstructionAddress;
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [3:0] localSrc1Address;
    logic [3:0] localSrc2Address;
    logic [7:0] localImmediate;


   always_ff @(posedge clk)
   begin
        if(hold)
        begin
            localInstructionAddress <= localInstructionAddress;
            localOperation <= localOperation;
            localDstAddress <= localDstAddress;
            localSrc1Address <= localSrc1Address;
            localSrc2Address <= localSrc2Address;
            localImmediate <= localImmediate;
        end
        else if(flush)
            begin 
                localInstructionAddress <= 16'h0000;
                localOperation <= 4'hF;
                localDstAddress <= 4'h0;
                localSrc1Address <= 4'h0;
                localSrc2Address <= 4'h0;
                localImmediate <= 8'h00;
            end
        else 
            begin 
                localInstructionAddress <= inInstructionAddress;
                localOperation <= inInstruction[15:12];
                localDstAddress <= inInstruction[11:8];
                localSrc1Address <= inInstruction[7:4];
                localSrc2Address <= inInstruction[3:0];
                localImmediate <= inInstruction[7:0];
            end
   end

   assign outInstructionAddress = localInstructionAddress;
   assign outOperation = localOperation;
   assign outDstAddress = localDstAddress;
   assign outSrc1Address = localSrc1Address;
   assign outSrc2Address = localSrc2Address;
   assign outImmediate = localImmediate;

endmodule