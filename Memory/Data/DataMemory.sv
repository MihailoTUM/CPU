// address 16 bit

module DataMemory(
    input logic clk,
    input logic [15:0] address,
    input logic [15:0] dataInput,
    output logic [15:0] dataOuput
);

    logic [15:0] storage [0: (2**8 - 1)];

    always_ff @(posedge clk)
    begin
        storage[address] <= dataInput;
    end

    assign storage[address];

endmodule