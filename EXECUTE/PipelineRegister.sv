

module PipelineRegister(
    input logic clk,
    input logic [3:0] operationIn,
    input logic [3:0] dstAddressIn,
    input logic [15:0] src1DataIn,
    input logic [15:0] src2DataIn,
    input logic [7:0] immediateOperandOutputIn,
    output logic [3:0] operation,
    output logic [3:0] dstAddress,
    output logic [15:0] src1Data,
    output logic [15:0] src2Data,
    output logic [7:0] immediateOperandOutput
);

    always_ff @(posedge clk)
    begin
        operation <= operationIn;
        dstAddress <= dstAddressIn;
        src1Data <= src1DataIn;
        src2Data <= src2DataIn;
        immediateOperandOutput <= immediateOperandOutputIn;
    end

endmodule