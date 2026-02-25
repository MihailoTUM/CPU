
// moore automat

module div3FSM(
    input logic clk,
    input logic reset,
    output logic y
);

    typedef enum logic [1:0] { s0, s1, s2 } stateype;
    stateype state, nextstate;

    // state regsiter 
    always_ff @(posedge clk)
        if(reset) state <= S0;
        else state <= nextstate;

    always_comb
    begin
        case(state)
            s0: nextstate = s1;
            s1: nextstate = s2;
            s2: nextstate = s0;
            default: nextstate = s0;
        endcase
    end 

    assign y = (state == s0);

endmodule;