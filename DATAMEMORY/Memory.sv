

module Memory(
    // control inputs
    input logic clk,
    input logic inWriteToMemoryEnable,

    // data inputs
    input logic [15:0] inALUDataResult,
    input logic [15:0] inMemoryAddress,

    // data outputs
    output logic [15:0] outDataMemoryResult
);
    logic [15:0] memory [0: (2**16 - 1)];

    always_ff @(posedge clk)
    begin
        if(inWriteToMemoryEnable) memory[inMemoryAddress]<= inALUDataResult;
    end

    assign outDataMemoryResult = memory[inMemoryAddress];

endmodule