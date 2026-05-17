

module Load(
    input logic [15:0] inBaseAddress,
    input logic [15:0] inOffsetAddress,

    output logic [15:0] outNewAddress
);

    CONST16 const();
    ADD16 add();

endmodule