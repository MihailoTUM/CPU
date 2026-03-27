// working DataMemory (RAM)

module DataMemory(
    input logic clk,
    input logic we,
    input logic [15:0] address,
    input logic [15:0] inputData,
    output logic [15:0] outputData
);

    logic [15:0] memory [0:(2**16 - 1)];

    // writing 
    always_ff @(posedge clk) 
    begin
        if(we) memory[address] <= inputData;
    end

    // reading
    assign outputData = memory[address];

endmodule