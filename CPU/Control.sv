

module Control(
    input logic clk,
    input logic reset,
    output logic [15:0] instruction
);
    // program counter (PC)
    logic [15:0] address;

    // ROM based memory
    Memory memory(
        .address(address),
        .instruction(instruction)
    );

    // 
    always_ff @(posedge clk) 
    begin
        if(reset) address <= 16'h0000;
        else address <= address + 2;
    end

endmodule