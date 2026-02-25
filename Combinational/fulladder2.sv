

module fulladder2(
    input logic a, b, cin,
    output logic s, cout
);
    logic p, g;

    always_comb 
    begin
        p = a ^ b;
        g = a & b;
        s = p ^ cin;
        c = g | (p & cin);    
    end

endmodule