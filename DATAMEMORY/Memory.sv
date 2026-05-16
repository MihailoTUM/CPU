

module Memory(
    // control inputs
    input logic clk,
    input logic allowWriteToMemory,

    // data inputs
    input logic [15:0] memoryAddress,
    input logic [15:0] dataToStoreInMemory

    // data outputs
    output logic [15:0] dataToLoad
);
    logic [15:0] memory [0: (2**16 - 1)];

    always_ff @(posedge clk)
    begin
        if(allowWriteToMemory) memory[memoryAddress]<= dataToStoreInMemory;
    end

    assign dataToLoad = memoryAddress[memoryAddress];

endmodule