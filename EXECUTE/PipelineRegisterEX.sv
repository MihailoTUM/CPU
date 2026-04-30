

module PipelineRegisterEX(
    // clk
    input logic clk,
    // hold
    input logic hold,
    // flush
    input logic flush,
    input logic [3:0] operationIn,
    input logic [3:0] dstAddressIn,
    input logic [15:0] src1DataIn,
    input logic [15:0] src2DataIn,
    input logic [7:0] immediateOperandOutputIn,
    output logic [3:0] operation,
    output logic [3:0] dstAddress,
    output logic [15:0] src1Data,
    output logic [15:0] src2Data,
    output logic [7:0] immediateOperandOutput,
    output logic [3:0] writeBackDst
);

    always_ff @(posedge clk)
    begin
        // hold current values of register
        if(hold)
            begin
                operationIn <= operation;
                dstAddressIn <= dstAddress;
                src1DataIn <= src1Data;
                src2DataIn <= src2Data;
                immediateOperandOutputIn <= immediateOperandOutput;
                dstAddressIn <= writeBackDst;
            end
        // reset values of register to 0
        else if (flush)
            begin
                operation <= 4'h0;
                dstAddress <= 4'h0;
                src1Data <= 4'h0;
                src2Data <= 4'h0;
                immediateOperandOutput <= 8'h00;
                writeBackDst <= 4'h0;
            end
        // normal register development
        else
            begin
                operation <= operationIn;
                dstAddress <= dstAddressIn;
                src1Data <= src1DataIn;
                src2Data <= src2DataIn;
                immediateOperand <= immediateOperandOutputIn;
                writeBackDst <= dstAddressIn;
            end
    end

endmodule