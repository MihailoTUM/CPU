

module PipelineRegisterEX(
    input logic clk,
    input logic reset,

    input logic [3:0] inOperation,
    input logic [3:0] inDstAddress,

    input logic [15:0] inData1, 
    input logic [15:0] inData2, 

    input logic [3:0] inData1Address,
    input logic [3:0] inData2Address,

    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    input logic [15:0] inExecuteOutputData,
    input logic [3:0] inExecuteOutputDataSrc,

    input logic [15:0] inDataMemoryOutputData,
    input logic [3:0] inDataMemoryOutputDataSrc,

    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,

    output logic [15:0] outData1,
    output logic [15:0] outData2,

    output logic [3:0] outData1Address,
    output logic [3:0] outData2Address,

    output logic [7:0] outImmediate,
    output logic [15:0] outInstructionAddress,

    output logic [15:0] outExecuteOutputData,
    output logic [3:0] outExecuteOutputDataSrc,

    output logic [15:0] outDataMemoryOutputData,
    output logic [3:0] outDataMemoryOutputDataSrc
);
    always_ff @(posedge clk)
    begin
        if(reset)
            begin
                outExecuteOutputData <= 16'h0000;
                outExecuteOutputDataSrc <= 4'hF;

                outDataMemoryOutputData <= 16'h0000;
                outDataMemoryOutputDataSrc <= 4'hF;
            end
        else
            begin
                outOperation <= inOperation;
                outDstAddress <= inDstAddress;

                outData1 <= inData1;
                outData2 <= inData2;

                outData1Address <= inData1Address;
                outData2Address <= inData2Address;
                
                outImmediate <= inImmediate;
                outInstructionAddress <= inInstructionAddress;

                outExecuteOutputData <= inExecuteOutputData;
                outExecuteOutputDataSrc <= inExecuteOutputDataSrc;

                outDataMemoryOutputData <= inDataMemoryOutputData;
                outDataMemoryOutputDataSrc <= inDataMemoryOutputDataSrc;
            end
    end
endmodule