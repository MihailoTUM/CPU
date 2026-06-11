

module PipelineRegisterEX(
    input logic         clk,
    input logic         reset,
    input logic         hold,
    input logic         flush,

    input logic [3:0]   inOperation,
    input logic [3:0]   inDstAddress,
    input logic [15:0]  inData1, 
    input logic [15:0]  inData2, 
    input logic [3:0]   inData1Address,
    input logic [3:0]   inData2Address,

    input logic         inDeactivateExecutePath,
    input logic         inDeactivateMemoryPath,

    input logic [7:0]   inImmediate,
    input logic [15:0]  inInstructionAddress,

    input logic [15:0]  inExecuteOutputData,
    input logic [3:0]   inExecuteOutputDataSrc,
    input logic [15:0]  inDataMemoryOutputData,
    input logic [3:0]   inDataMemoryOutputDataSrc,

    input logic         inWriteToRegisterEnable,
    input logic         inWriteToMemoryEnable,   

    output logic [3:0]  outOperation,
    output logic [3:0]  outDstAddress,
    output logic [15:0] outData1,
    output logic [15:0] outData2,
    output logic [3:0]  outData1Address,
    output logic [3:0]  outData2Address,

    output logic        outDeactivateExecutePath,
    output logic        outDeactivateMemoryPath,

    output logic [7:0]  outImmediate,
    output logic [15:0] outInstructionAddress,

    output logic [15:0] outExecuteOutputData,
    output logic [3:0]  outExecuteOutputDataSrc,
    output logic [15:0] outDataMemoryOutputData,
    output logic [3:0]  outDataMemoryOutputDataSrc,

    output logic        outWriteToRegisterEnable,
    output logic        outWriteToMemoryEnable    
);
    always_ff @(posedge clk)
    begin
        if(reset)
            begin
                outExecuteOutputData <= 16'h0000;
                outExecuteOutputDataSrc <= 4'hF;
                outDataMemoryOutputData <= 16'h0000;
                outDataMemoryOutputDataSrc <= 4'hF;

                outWriteToRegisterEnable = 0;
                outWriteToMemoryEnable = 0;
            end
        else if(hold)
            begin
                outOperation <= outOperation;
                outDstAddress <= outDstAddress;
                outData1 <= outData1;
                outData2 <= outData2;
                outData1Address <= outData1Address;
                outData2Address <= outData2Address;

                outDeactivateExecutePath <= outDeactivateExecutePath;
                outDeactivateMemoryPath <= outDeactivateMemoryPath;
            
                outImmediate <= outImmediate;
                outInstructionAddress <= outInstructionAddress;

                outExecuteOutputData <= outExecuteOutputData;
                outExecuteOutputDataSrc <= outExecuteOutputDataSrc;
                outDataMemoryOutputData <= outDataMemoryOutputData;
                outDataMemoryOutputDataSrc <= outDataMemoryOutputDataSrc;
            
                outWriteToRegisterEnable <= outWriteToRegisterEnable;
                outWriteToMemoryEnable <= outWriteToMemoryEnable;
            end
        else if(flush)
            begin
                outOperation <= 4'hF;
                outDstAddress <= 4'hF;
                outData1 <= 16'h0000;
                outData2 <= 16'h0000;
                outData1Address <= 4'h0;
                outData2Address <= 4'h0;
                outImmediate = 8'h0;
                outInstructionAddress <= 16'h0000;

                outDeactivateExecutePath <= 1'b0;
                outDeactivateMemoryPath <= 1'b0;

                outExecuteOutputData <= 16'h0000;
                outExecuteOutputDataSrc <= 4'hF;
                outDataMemoryOutputData <= 16'h0000;
                outDataMemoryOutputDataSrc <= 4'hF;

                outWriteToRegisterEnable <= 1'b0;
                outWriteToMemoryEnable <= 1'b0;
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

                outDeactivateExecutePath <= inDeactivateExecutePath;
                outDeactivateMemoryPath <= inDeactivateMemoryPath;

                outExecuteOutputData <= inExecuteOutputData;
                outExecuteOutputDataSrc <= inExecuteOutputDataSrc;
                outDataMemoryOutputData <= inDataMemoryOutputData;
                outDataMemoryOutputDataSrc <= inDataMemoryOutputDataSrc;
            
                outWriteToRegisterEnable <= inWriteToRegisterEnable;
                outWriteToMemoryEnable <= inWriteToMemoryEnable;
            end
    end
endmodule