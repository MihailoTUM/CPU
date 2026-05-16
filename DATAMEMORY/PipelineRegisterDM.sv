

module PipelineRegisterDM(
    input logic clk,
    // input logic hold,

    input logic [15:0] ALUResult,
    input logic [3:0] writeBackDst,
    input logic writeBackEnable, 
    input logic [3:0] operation,
    input logic [15:0] inDataToStoreInMemory,
    
    output logic [15:0] result,
    output logic [3:0] dst,
    output logic enableSignal,
    output logic [3:0] operationOut,
    output logic [15:0] outDataToStoreInMemory
);

    always_ff @(posedge clk)
    begin
        result <= ALUResult;
        dst <= writeBackDst;
        enableSignal <= writeBackEnable;
        operationOut <= operation;
        outDataToStoreInMemory <= inDataToStoreInMemory;
    end

endmodule