

module DataMemmory_tb();
    logic clk;
    logic [15:0] address;
    logic [15:0] dataInput;
    logic [15:0] dataOutput;

    DataMemory dut(
        .clk(clk),
        .address(address),
        .dataInput(dataInput),
        .dataOutput(dataOutput)
    );

    // clk
    initial clk = 0;
    always #5; clk = ~clk;

    initial begin
        $dumpfile("DataMemory.vcd");
        $dumpvars(0, DataMemmory_tb);

        // write
        address = 16'h0000; dataInput = 16'hFFFF; #10;

        // load
        address = 16'h0000; #5;
        asssert(dataOutput == 16'hFFFF);

    end

endmodule