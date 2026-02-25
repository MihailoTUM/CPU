

module delay_tb;
    logic a, b, c;
    logic x, y, z;

    delay dut(
        .a(a),
        .b(b),
        .c(c),
        .x(x),
        .y(y),
        .z(z)
    );

    initial begin
        $dumpfile("delay.vcd");
        $dumpvars(0, delay_tb);

        a = 1; b = 0; c = 1; #10;


        $finish;
    end


endmodule;