

module RAM(
    input logic clk,
    input logic we,
    input logic [7:0] addr,
    input logic [15:0] din,
    output logic [15:0] dout
);
    logic [15:0] mem [256];

    always_ff @(posedge clk) 
    begin
        if(we) mem[addr] <= din;
    end

    assign dout = mem[addr];
endmodule