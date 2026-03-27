`timescale 1ns/1ns

module DataMemory_tb();
    logic clk;
    logic we;
    logic [15:0] address;
    logic [15:0] inputData;
    logic [15:0] outputData;

    DataMemory dut(
        .clk(clk),
        .we(we),
        .address(address),
        .inputData(inputData),
        .outputData(outputData)
    );

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile("DataMemory.vcd");
        $dumpvars(0, DataMemory_tb);

        // write 
        we = 1; address = 16'h0000; inputData = 16'hFACC;
        #5;

        // read
        we = 0; address = 16'h0000; 
        #5; 


        $finish;
    end 
endmodule