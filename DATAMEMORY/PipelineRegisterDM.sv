

module PipelineRegisterDM(
    input logic clk,
    input logic [15:0] ALUResult,
    input logic [3:0] writeBackDst,
    input logic writeBackEnable, 
    input logic [3:0] operation,
    output logic [15:0] result,
    output logic [15:0] dst,
    output logic enableSignal
);

    always_ff @(posedge clk)
    begin
        result <= ALUResult;
        dst <= writeBackEnable;
        enableSignal <= writeBackEnable
    end

endmodule