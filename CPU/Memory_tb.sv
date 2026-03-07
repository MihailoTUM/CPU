`timescale 1ns/1ns

module Memory_tb();
    logic [15:0] address;
    logic [15:0] instruction;

    Memory dut(
        .address(address),
        .instruction(instruction)
    );

    initial 
    begin
        $dumpfile("Memory.vcd");
        $dumpvars(0, Memory_tb);

        address = 16'h0000; #2;
        
        address = 16'h0002; #2;

        address = 16'h0007; #2;
        
        address = 16'h000A; #2;

        $finish;
    end

endmodule