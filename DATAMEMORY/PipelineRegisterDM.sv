

module PipelineRegisterDM(
    input logic clk,
    input logic [15:0] ALUResult,
    input logic [3:0] writeBackDst,
    input logic writeBackEnable, 
    input logic [3:0] operation,
    output logic [15:0] result,
    output logic [3:0] dst,
    output logic enableSignal,
    output logic [3:0] operationOut;
);

    always_ff @(posedge clk)
    begin
        result <= ALUResult;
        dst <= writeBackDst;
        enableSignal <= writeBackEnable
        operationOut <= operation;
    end

endmodule