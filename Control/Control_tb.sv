`timescale 1ns/1ns

module Control_tb();
    logic clk;
    logic reset;
    logic [15:0] instruction;

    Control dut(
        .clk(clk),
        .reset(reset),
        .instruction(instruction)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial 
    begin
        $dumpfile("Control.vcd");
        $dumpvars(0, Control_tb);

        // initial values
        reset = 1; #10;

        reset = 0; #200;
    
        $finish;
    end
endmodule