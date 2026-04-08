// pipeline register

module PipelineRegister(
    input logic clk,
    input logic [15:0] instruction,
    output logic [3:0] operation,
    output logic [3:0] dstAddress,
    output logic [3:0] src1Address,
    output logic [3:0] src2Address,
    output logic [7:0] immediateOperand
);
   always_ff @(posedge clk)
   begin
        operation <= instruction[15:12];
        dstAddress <= instruction[11:8];
        src1Address <= instruction[7:4];
        src2Address <= instruction[3:0];
        immediateOperand <= instruction[7:0];
   end
endmodule