`timescale 1ns/1ns

module WriteBack_tb();
    logic [15:0] result;
    logic [3:0] writeBackDst;
    logic enableWrite;

    logic [15:0] writeToRegisterData;
    logic [3:0] writeToRegisterDst;
    logic enableRegisterWrite;

    WriteBack dut(
        .result(result),
        .writeBackDst(writeBackDst),
        .enableWrite(enableWrite),

        .writeToRegisterData(writeToRegisterData),
        .writeToRegisterDst(writeToRegisterDst),
        .enableRegisterWrite(enableRegisterWrite)
    );

    initial
    begin
        $dumpfile("WriteBack.vcd");
        $dumpvars(0, WriteBack_tb);

        result = 16'h0FAC; writeBackDst = 4'h1; enableWrite = 1;
        #4;
        
        result = 16'h0AAC; writeBackDst = 4'h3; enableWrite = 1;
        #4;

        $finish;
    end
endmodule