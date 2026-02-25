

module patternMoore (
    input logic clk,
    input logic reset,
    input logic a,
    output logic y
);

    typedef enum logic [1:0] { s0, s1, s2 } statetype;
    statetype state, nextstate;

    // state register
    always_ff @(posedge clk, posedge reset)
    if(reset) state <= s0;
    else state <= nextstate;


    // next state logic
    always_comb
    begin
        case(state)
        s0: if(a) nextstate = s0;
            else nextstate = s1;
        s1: if(a) nextstate = s2;
            else nextstate = s1;
        s2: if(a) nextstate = s0;
            else nextstate = s1;
        default: nextstate = s0;
        endcase
    end

    assign y = (state == s2);
    
endmodule