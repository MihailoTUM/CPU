

module EXRegister(
    input logic clk,
    input logic [3:0] dstEXRegister,
    input logic [7:0] directOperandEXRegister,
    input logic [15:0] srcAEXRegister,
    input logic [15:0] srcBEXRegister,
    output logic [15:0] ALU1EXRegister,
    output logic [15:0] ALU2EXRegister,
    output logic [3:0] writeBackDstEXRegister,
    output logic [7:0] immediateOperandEXRegister
);

    always_ff @(posedge clk)
    begin 
        ALU1EXRegister <= srcAEXRegister;
        ALU2EXRegister <= srcBEXRegister;
        writeBackDstEXRegister <= dstEXRegister;
        immediateOperandEXRegister <= directOperandEXRegister;
    end
endmodule