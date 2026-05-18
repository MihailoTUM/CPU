`timescale 1ns/1ns

module Load_tb();
    logic [15:0] inBaseAddress;
    logic [3:0] inOffsetAddress;    
    logic [15:0] outNewAddress;

    LOAD16 dut(
        .inBaseAddress(inBaseAddress),
        .inOffsetAddress(inOffsetAddress),

        .outNewAddress(outNewAddress)
    );

    initial 
    begin
        $dumpfile("LOAD.vcd");
        $dumpvars(0, Load_tb);

        inBaseAddress = 16'hFFFF;
        inOffsetAddress = 4'hD;
        #4;

        inBaseAddress = 16'h0000;
        inOffsetAddress = 4'h7;
        #4;

        $finish;
    end
endmodule