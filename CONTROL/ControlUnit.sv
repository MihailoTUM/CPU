

module ControlUnit(
    // control inputs
    input logic clk,
    input logic reset,

    // control signals from ALU
    input logic holdSignalFromALU,
    input logic jumpSignalFromALU,

    // data inputs
    input logic [15:0] JMPAddressFromALU,
    inout logic JMPSignalFromALU,

    // data outputs
    output logic [3:0] controlSignals
);
    typedef enum logic [2:0] { run, hold, jump, reset1, reset2 } statetype;
    statetype state, nextState;

    always_ff @(posedge clk)
    begin
        if(reset)   state <= reset1;
        else        state <= nextState;
    end

    logic [15:0] localAddress;

    always_ff @(posedge clk)
    begin
        if(JMPAddressFromALU) localAddress <= JMPAddressFromALU;
        else if(reset) localAddress <= 16'h0000;
        else localAddress <= localAddress;
    end

    always_comb 
    begin
        case(state)
        run:    if(holdSignalFromALU) nextState = hold;
                else if(jumpSignalFromALU) nextState = jump;
                else nextState = run;
        hold:   if(holdSignalFromALU) nextState = hold;
                else nextState = run;
        jump:   nextState = run;
        reset1: nextState = reset2;
        reset2: nextState = run;
        endcase
    end

    // controlSignals
    // 3: hold
    // 2: reset

    always_comb
    begin
        case(state)
            run:    controlSignals = { 1'b0, 3'b000 };
            hold:   controlSignals = { 1'b1, 3'b000 };
            jump:   controlSignals = { 1'b0, 3'b000 };
            reset1: controlSignals = { 1'b0, 1'b0, 2'b00 };
            reset2: controlSignals = { 1'b0, 1'b1, 2'b00 };
        endcase
    end
    

endmodule