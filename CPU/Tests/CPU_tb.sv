

module CPU_tb();
    logic clk;
    logic [15:0] instruction;

    CPU dut(
        .clk(clk),
        .instruction(instruction)
    );

    initial clk = 1;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("CPU.vcd");
        $dumpvars(0, CPU_tb);

        // first cycle, store in register 0, the number 5
        instruction = 16'h0005; 
        // wait a cycle (simulation) 
        #4;

        // second cycle, store in register 1, the number 4
        instruction = 16'h0104;
        // wait a cycle (simulation)
        #4;

        // third cycle, add register 0 and register 1, store in register 2
        instruction = 16'h1201;
        #4;

        // finsh the 4th cycle
        #4;
        // finsih the 5th cycle
        #4;

        #20;


        $finish;
    end
endmodule