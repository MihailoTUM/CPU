`timescale 1ns/1ns

module ADDI16_tb();
    logic [15:0] inData;
    logic [7:0] offset;
    logic [15:0] outData;

    ADDI16 dut(
        .inData(inData),
        .offset(offset),
        .outData(outData)
    );

    initial 
    begin
        $dumpfile("ADDI16.vcd");
        $dumpvars(0, ADDI16_tb);

        inData = 16'h0010; offset = 8'h02; 
        #1;
        assert(outData == 16'h0012) else $error("Test 1 failed");

        $finish;
    end
endmodule