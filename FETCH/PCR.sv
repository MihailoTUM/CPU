

module PCR(
    input logic clk,
    input logic [15:0] instructionToStore,
    output logic [15:0] instructionToShare
);

    always_ff @(posedge clk)
    begin
        instructionToShare <= instructionToStore;
    end

endmodule