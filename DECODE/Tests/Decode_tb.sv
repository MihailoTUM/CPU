


module Decode_tb();
    

    initial clk = 1;
    always #2 clk = ~clk;

    initial
    begin
        $dumpfile("Decode.vcd");
        $dumpvars(0, Decode_tb);

        /*  1.cycle

        */
        instruction = 16'hXXXX; dataToStore = 16'hFFFF; writeBackDst = 4'h0;
        #4;

        instruction = 16'hXXXX; dataToStore = 16'hAAAA; writeBackDst = 4'h1;
        #4;

        instruction = 16'h0201; dataToStore = 16'hBBBB; writeBackDst = 4'h8;
        #4;

        $finish;
    end

endmodule