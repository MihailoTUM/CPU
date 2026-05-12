

module ALUControl(
    // control inputs
    input logic clk,
    input logic divFinished,

    // data inputs
    input logic [3:0] operation,
    input logic [3:0] dstAddress,
    input logic [15:0] data1Input,
    input logic [15:0] data2Input,

    // forward path
    input logic [15:0] forwardPathInput,
    input logic [3:0] forwardPathInputSrc,
    input logic [3:0] forwardPathSrc1Address,
    input logic [3:0] forwardPathSrc2Address,

    output logic [3:0] controlSignals,
    output logic [15:0] data1Output,
    output logic [15:0] data2Output
);  
    logic multiCycle;

    assign data1Output = |(dstAddress ^ forwardPathSrc1Address) ? data1Input : forwardPathInput;
    assign data2Output = |(dstAddress ^ forwardPathSrc2Address) ? data2Input : forwardPathInput;


    always_comb
    begin 
        case(operation)
            4'h4: multiCycle = 1;
            default: multiCycle = 0;
        endcase
    end

    typedef enum logic [1:0] { reset1, reset2, loop, finished } statetype;
    statetype state, nextState;

    always_comb 
    begin 
        case(state)
        finished:   if(multiCycle) nextState = reset1;
                    else nextState = finished;
        reset1:     nextState = reset2;
        reset2:     nextState = loop;
        loop:       if(divFinished) nextState = finished;
                    else nextState = loop;
        default: nextState = finished;
        endcase
    end

    always_ff @(posedge clk)
    begin
        state <= nextState;
    end
    /*
        controlSignals
        0: reset,
        1: hold
    */

    always_comb
    begin
        case(state)
        finished: controlSignals = { 4'b0000 };
        reset1: controlSignals = { 1'b1, 1'b1, 2'b00 };
        reset2: controlSignals = { 1'b0, 1'b1, 2'b00 };
        loop: controlSignals = { 4'b0100 };
        endcase
    end

endmodule