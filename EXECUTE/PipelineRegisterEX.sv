

module PipelineRegisterEX(
    // control inputs
    input logic clk,
    input logic hold,
    input logic reset,

    // data inputs
    input logic [3:0] inOperation,
    input logic [3:0] inDstAddress,
    input logic [3:0] inSrc1Address,
    input logic [3:0] inSrc2Address,

    input logic [15:0] inSrc1,
    input logic [15:0] inSrc2,
    input logic [7:0] inImmediate,
    input logic [15:0] inInstructionAddress,

    input logic [15:0] forwardPathInputExecute,
    input logic [3:0] forwardPathInputExecuteSrc,

    input logic [15:0] forwardPathInputDataMemory,
    input logic [3:0] forwardPathInputDataMemorySrc,

    // data outputs
    output logic [3:0] outOperation,
    output logic [3:0] outDstAddress,
    output logic [15:0] outSrc1Data,
    output logic [15:0] outSrc2Data,
    output logic [7:0] outImmediate,

    output logic [15:0] forwardPathOutputExecute,
    output logic [3:0] forwardPathOutputExecuteSrc,

    output logic [15:0] forwardPathOutputDataMemory,
    output logic [3:0] forwardPathOutputDataMemorySrc,

    output logic [15:0] outInstructionAddress,
    output logic [15:0] outStackPointerAddress,
    
    output logic [3:0] outSrc1Address,
    output logic [3:0] outSrc2Address
);
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1;
    logic [15:0] localSrc2;
    logic [7:0] localImmediate;

    logic [15:0] localInstructionAddress;

    logic [15:0] localForwardPathInputExecute;
    logic [3:0] localForwardPathInputExecuteSrc;

    logic [15:0] localForwardPathInputDataMemory;
    logic [3:0] localForwardPathInputDataMemorySrc;

    logic [3:0] localInputSrc1Address;
    logic [3:0] localInputSrc2Address;


    always_ff @(posedge clk)
    begin
        if(hold)
            begin
                localOperation <= localOperation;
                localDstAddress <= localDstAddress;
                localSrc1 <= localSrc1;
                localSrc2 <= localSrc2;
                localImmediate <= localImmediate;

                localForwardPathInputExecute <= localForwardPathInputExecute;
                localForwardPathInputExecuteSrc <= localForwardPathInputExecuteSrc;

                localForwardPathInputDataMemory <= localForwardPathInputDataMemory;
                localForwardPathInputDataMemorySrc <= localForwardPathInputDataMemorySrc;

                localInstructionAddress <= localInstructionAddress;

                localInputSrc1Address <= localInputSrc1Address;
                localInputSrc2Address <= localInputSrc2Address;
            end

        else if(reset)
            begin
                localForwardPathInputExecute <= 16'h0000;
                localForwardPathInputExecuteSrc <= 4'hF;

                localForwardPathInputDataMemory <= 16'h0000;
                localForwardPathInputDataMemorySrc <= 4'hF;
            end
        else
            begin
                localOperation <= inOperation;
                localDstAddress <= inDstAddress;
                localSrc1 <= inSrc1;
                localSrc2 <= inSrc2;
                localImmediate <= inImmediate;
                localDstAddress <= inDstAddress;

                localForwardPathInputExecute <= forwardPathInputExecute;
                localForwardPathInputExecuteSrc <= forwardPathInputExecuteSrc;

                localForwardPathInputDataMemory <= forwardPathInputDataMemory;
                localForwardPathInputDataMemorySrc <= forwardPathInputDataMemorySrc;
                
                localInstructionAddress <= inInstructionAddress;

                localInputSrc1Address <= inSrc1Address;
                localInputSrc2Address <= inSrc2Address;
            end
    end

    assign outOperation = localOperation;
    assign outDstAddress = localDstAddress;
    assign outSrc1Data = localSrc1;
    assign outSrc2Data = localSrc2;
    assign outImmediate = localImmediate;
    
    assign forwardPathOutputExecute = localForwardPathInputExecute;
    assign forwardPathOutputExecuteSrc = localForwardPathInputExecuteSrc;

    assign forwardPathOutputDataMemory = localForwardPathInputDataMemory;
    assign forwardPathOutputDataMemorySrc = localForwardPathInputDataMemorySrc;

    assign outInstructionAddress = localInstructionAddress;

    assign outSrc1Address = localInputSrc1Address;
    assign outSrc2Address = localInputSrc2Address;

endmodule