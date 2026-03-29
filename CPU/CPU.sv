

module CPU(
    input logic clk,
    input logic reset
);
    logic [15:0] instructionAddress;
    logic [15:0] instruction;
    
    logic [15:0] rOutput1;
    logic [15:0] rOutput2;

    logic [15:0] outputALU;
    logic [3:0] flag;

    // increaces program counter by 2 (2-byte instruction)
    Control control(
        .clk(clk),
        .reset(reset),
        .instructionAddress(instructionAddress)
    );

    // reads from memory the 2-byte instruction (FETCH)
    InstructionMemory InstructionMemory(
        .instructionAddress(instructionAddress),
        .instruction(instruction)
    );

    /*  
        4-bit opcode, 4-bit destination, 4-bit source1, 4-bit source2
    */

    // gets operands from registers (ENCODE)
    Register register(
        .clk(clk),
        .reset(reset),
        .writeEnable(1'b1),
        .destination(instruction[11:8]),
        .source1(instruction[7:4]),
        .source2(instruction[3:0]),
        .rOutput1(rOutput1),
        .rOutput2(rOutput2)
    );

    // executes instruction (EXECUTE)
    ALU alu(
        .instruction(instruction[15:12]),
        .inputALU1(rOutput1),
        .inputALU2(rOutput2),
        .outputALU(outputALU),
        .flag(flag)
    );

    

endmodule