

module RET(
    input logic [15:0] inReturnAddress,

    output logic [15:0] outReturnAddress
);

    assign outReturnAddress = inReturnAddress;

endmodule