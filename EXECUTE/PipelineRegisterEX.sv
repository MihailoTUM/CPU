

module PipelineRegisterEX(
    // control inputs
    input logic clk,
    input logic hold,
    input logic reset,

    // data inputs
    input logic [3:0] inOperation,
    input logic [3:0] inDstAddress,

    input logic [15:0] inData1, 
    input logic [15:0] inData2, 

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,

    output logic [15:0] outData1,
    output logic [15:0] outData2,

    output logic [3:0] outData1Address,
    output logic [3:0] outData2Address,

    output logic [7:0] outImmediate,
    output logic [15:0] outInstructionAddress,

    output logic [15:0] forwardPathOutputExecute,
    output logic [3:0] forwardPathOutputExecuteSrc,

    output logic [15:0] forwardPathOutputDataMemory,
    output logic [3:0] forwardPathOutputDataMemorySrc,

);
    always_ff @(posedge clk)
    begin
        if(reset)
            begin
                forwardPathOutputExecute <= 16'h0000;
                forwardPathOutputExecuteSrc <= 4'hF;

                forwardPathOutputDataMemory <= 16'h0000;
                forwardPathOutputDataMemorySrc <= 4'hF;
            end
        else
            begin
                outOperation <= inOperation;
                outDstAddress <= inDstAddress;

                outData1 <= inData1;
                outData2 <= inData2;

                outData1Address <= inData1Address;
                outData2Address <= inData2Adresss;
                
                outImmediate <= inImmediate;
                outInstructionAddress <= inInstructionAddress;

                forwardPathOutputExecute <= forwardPathInputExecute;
                forwardPathOutputExecuteSrc <= forwardPathInputExecuteSrc;

                forwardPathInputDataMemory <= forwardPathInputDataMemory;
                forwardPathInputDataMemorySrc <= forwardPathInputDataMemorySrc;
            end
    end
endmodule