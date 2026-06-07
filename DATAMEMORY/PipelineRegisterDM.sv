

module PipelineRegisterDM(
    input logic         clk,
    input logic         reset,
    input logic         hold,
    input logic         flush,

    input logic [15:0]  inDataResult,
    input logic [3:0]   inWriteBackDataResultDst,
    input logic         inWriteBackDataResultEnable, 
    input logic [3:0]   inOperation,
    input logic [15:0]  inMemoryAddress,
    
    output logic [15:0] outDataResult,
    output logic [3:0]  outWriteBackDataResultDst,
    output logic        outWriteBackDataResultEnable,
    output logic [3:0]  outOperation,
    output logic [15:0] outMemoryAddress
);

    always_ff @(posedge clk)
        begin
            if(hold)
                begin 
                    outDataResult <= outDataResult;
                    outWriteBackDataResultDst <= outWriteBackDataResultDst;
                    outWriteBackDataResultEnable <= outWriteBackDataResultEnable;
                    outOperation <= outOperation;
                    outMemoryAddress <= outMemoryAddress;
                end
            else if(flush)
                begin
                    outDataResult <= 16'h0000;
                    outWriteBackDataResultDst <= 4'hF;
                    outWriteBackDataResultEnable <= 1'b0;
                    outOperation <= 4'hF;
                    outMemoryAddress <= 16'h0000;
                end
            else if(reset)
                begin
                    outDataResult <= 16'h0000;
                    outWriteBackDataResultDst <= 4'hF;
                    outWriteBackDataResultEnable <= 1'b0;
                    outOperation <= 4'hF;
                    outMemoryAddress <= 16'h0000;
                end
            else 
                begin
                    outDataResult <= inDataResult;
                    outWriteBackDataResultDst <= inWriteBackDataResultDst;
                    outWriteBackDataResultEnable <= inWriteBackDataResultEnable;
                    outOperation <= inOperation;
                    outMemoryAddress <= inMemoryAddress; 
                end
        end

endmodule