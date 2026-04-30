// pipeline register

module PipelineRegisterDE(
    // clk
    input logic clk,
    // hold current values from previous cycle until resolved
    input logic hold,
    // reset the current values to 0
    input logic flush,
    input logic [15:0] instruction,
    output logic [3:0] operation,
    output logic [3:0] dstAddress,
    output logic [3:0] src1Address,
    output logic [3:0] src2Address,
    output logic [7:0] immediateOperand
);
   always_ff @(posedge clk)
   begin
        if(hold)
        begin
            // holding current register values
            operation <= operation;
            dstAddress <= dstAddress;
            src1Address <= src1Address;
            src2Address <= src2Address;
            immediateOperand <= immediateOperand;
        end
        else if(flush)
            // flushing the pipeline
            begin 
                operation <= 4'hF;
                dstAddress <= 4'h0;
                src1Address <= 4'h0;
                src2Address <= 4'h0;
                immediateOperand <= 8'h00;
            end
        else 
            begin 
                operation <= instruction[15:12];
                dstAddress <= instruction[11:8];
                src1Address <= instruction[7:4];
                src2Address <= instruction[3:0];
                immediateOperand <= instruction[7:0];
            end
   end
endmodule