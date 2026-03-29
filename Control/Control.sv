

module Control(
    input logic clk,
    input logic reset,
    output logic [15:0] instructionAddress
);
    // program counter: 0x0000 - 0xFFFF

    always_ff @(posedge clk)
    begin
        if(reset) instructionAddress <= 16'h0000;
        else instructionAddress <= instructionAddress + 2;
    end

endmodule