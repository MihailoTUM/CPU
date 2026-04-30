

module ALUControl(
    input logic clk,
    input logic hold,
    input logic [3:0] operation,
    input logic divFinished,
    output logic [3:0] controlSignals,
);  
    logic localHold;

    typedef enum logic [1:0] {
        reset1, reset2, loop, finished
    } statetype;
    statetype state, nextState;

    always_ff @(posedge clk)
    begin
        state <= nextState;
    end

    assign controlHold = localHold;

    always_comb
    begin
        case(operation)
            4'h4:
            begin
                localHold = 1'b1;
                nextState = reset;
            end
            default: 
            begin
                localHold = 1'b0;
                nextState = finished;
            end
        endcase
    end

    // determine next state
    always_comb
    begin
        case(state)
        reset1: nextState = reset2;
        reset2: nextState = loop;
        loop:   
            if(divFinished) nextState = finished;
            else nextState = loop;
        finished: nextState = finished;
        default: nextState = finished;
        endcase
    end

    // outputs
    always_comb
    begin
        case(state)
        reset1: controlSignals = { 1'b1, 1'b1, 2'b00  };
        reset2: controlSignals = { 1'b0, 1'b1, 2'b00 };
        loop: controlSignals = { 1'b0, 1'b1, 2'b00 };
        finished: controlSignals = { 1'b0, 1'b0, 2'b00 };
        default: controlSignals = { 1'b0, 1'b0, 2'b00 };
        endcase
    end

endmodule;