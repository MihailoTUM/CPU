

module PipelineRegisterEX(
    // control inputs
    input logic clk,
    input logic hold,
    // input logic flush,

    // data inputs
    input logic [3:0] inputOperation,
    input logic [3:0] inputDstAddress,
    input logic [15:0] inputSrc1,
    input logic [15:0] inputSrc2,
    input logic [7:0] inputImmediate,

    // data outputs
    output logic [3:0] operation,
    output logic [3:0] dstAddress,
    output logic [15:0] src1Data,
    output logic [15:0] src2Data,
    output logic [7:0] immediate
);
    logic [3:0] localOperation;
    logic [3:0] localDstAddress;
    logic [15:0] localSrc1;
    logic [15:0] localSrc2;
    logic [7:0] localImmediate;

    always_ff @(posedge clk)
    begin
        if(hold)
            begin
                localOperation <= localOperation;
                localDstAddress <= localDstAddress;
                localSrc1 <= localSrc1;
                localSrc2 <= localSrc2;
                localImmediate <= localImmediate;
            end
        // else if (flush)
        //     begin
        //         operation <= 4'h0;
        //         dstAddress <= 4'h0;
        //         src1Data <= 4'h0;
        //         src2Data <= 4'h0;
        //         immediateOperandOutput <= 8'h00;
        //         writeBackDst <= 4'h0;
        //     end
        else
            begin
                localOperation <= inputOperation;
                localDstAddress <= inputDstAddress;
                localSrc1 <= inputSrc1;
                localSrc2 <= inputSrc2;
                localImmediate <= inputImmediate;
                localDstAddress <= inputDstAddress;
            end
    end

    assign operation = localOperation;
    assign dstAddress = localDstAddress;
    assign src1Data = localSrc1;
    assign src2Data = localSrc2;
    assign immediate = localImmediate;

endmodule