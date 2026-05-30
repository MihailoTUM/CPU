

module CONST16U(
    input logic [7:0] inData,

    output logic [15:0] outData
);

    assign outData = {{8{ 1'b0 }}, inData };

endmodule