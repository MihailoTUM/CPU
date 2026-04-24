

module WriteBack(
    input logic [15:0] result, 
    input logic [3:0] writeBackDst,
    input logic enableWrite,
    output logic [15:0] writeToRegisterData,
    output logic [3:0] writeToRegisterDst,
    output logic enableRegisterWrite
);

    assign writeToRegisterData = result;
    assign writeToRegisterDst = writeBackDst;
    assign enableRegisterWrite = enableWrite;
endmodule