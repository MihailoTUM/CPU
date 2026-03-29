

module InstructionMemory_tb();
    logic [15:0] address;
    logic [15:0] instruction;

    InstructionMemory dut(
        .address(address),
        .instruction(instruction)
    );

    initial 
    begin
        $dumpfile("InstructionMemory.vcd");
        $dumpvars(0, InstructionMemory_tb);

    end
endmodule