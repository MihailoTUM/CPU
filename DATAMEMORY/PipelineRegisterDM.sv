

module PipelineRegisterDM(
    input logic clk,
    // input logic hold,

    input logic [15:0] inALUDataResult,
    input logic [3:0] inWriteBackDataResultDst,
    input logic inWriteBackDataResultEnable, 
    input logic [3:0] inOperation,
    input logic [15:0] inMemoryAddress,
    
    output logic [15:0] outALUDataResult,
    output logic [3:0] outWriteBackDataResultDst,
    output logic outWriteBackDataResultEnable,
    output logic [3:0] outOperation,
    output logic [15:0] outMemoryAddress
);

    always_ff @(posedge clk)
        begin
            outALUDataResult <= inALUDataResult;
            outWriteBackDataResultDst <= inWriteBackDataResultDst;
            outWriteBackDataResultEnable <= inWriteBackDataResultEnable;
            outOperation <= inOperation;
            outMemoryAddress <= inMemoryAddress; 
        end

endmodule