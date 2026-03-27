

module Control(
    input logic clk,
    input logic reset,
    output logic [15:0] address
);
    // program counter: 0x0000 - 0xFFFF

    always_ff @(posedge clk)
    begin
        if(reset) address <= 16'h0000;
        else address <= address + 2;
    end

endmodule