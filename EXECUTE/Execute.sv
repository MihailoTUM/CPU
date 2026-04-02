

module Execute(
    input logic clk,
    input logic [3:0] opcodeExecute,
    input logic [3:0] dstExecute,
    input logic [15:0] srcAExecute,
    input logic [15:0] srcBExecute,
    input logic [7:0] iOperandExecute,
    output logic [15:0] dataExecute,
    output logic [3:0] writeBackDstExecute
);

    logic [15:0] ALU1;
    logic [15:0] ALU2;

    logic [7:0] localImmediateOperand;
    logic [3:0] localWriteBackDst;

    EXRegister exregister(
        .clk(clk),
        .dstEXRegister(dstExecute),
        .directOperandEXRegister(iOperandExecute),
        .srcAEXRegister(srcAExecute),
        .srcBEXRegister(srcBExecute),
        .ALU1EXRegister(ALU1),
        .ALU2EXRegister(ALU2),
        .writeBackDstEXRegister(localWriteBackDst),
        .immediateOperandEXRegister(localImmediateOperand)
    );

    // ALU
    ALU alu(    
        .opcode(opcodeExecute),
        .a(ALU1),
        .b(ALU2),
        .immediateOperand(localImmediateOperand),
        .result(dataExecute)  
    );

    assign writeBackDstExecute = localWriteBackDst;

endmodule