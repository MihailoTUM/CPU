

module Register(
    input logic clk,
    input logic reset,
    input logic writeEnable,
    input logic [3:0] address

);

    always_ff @(posedge clk)
        begin

        end
endmodule