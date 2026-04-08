

module RegisterBlock(
    input logic clk,
    input logic [15:0] dataToStore,
    input logic [3:0] writeBackDst,
    input logic [3:0] src1Address,
    input logic [3:0] src2Address,
    input logic [7:0] immediateOperandInput,
    output logic [15:0] src1Data,
    output logic [15:0] src2Data,
    output logic [7:0] immediateOperandOutput
);

    logic [15:0] registers [15:0];

    always_ff @(posedge clk)
    begin
        registers[writeBackDst] <= dataToStore;
    end

    always_comb 
    begin
       src1Data = registers[src1Address];
       src2Data = registers[src2Address];
       immediateOperandOutput = immediateOperandInput;
    end
endmodule