

module ControlUnit(
    // control inputs
    input logic clk,
    input logic reset,

    // control inputs from ALU
    input logic holdSignalFromALU,

    // data inputs
    input logic [15:0] inInstructionAddress,
    input logic changeInstructionAddress,

    // control outputs
   output logic holdSigFromControl,
   output logic resetSigFromControl,

    // data outputs
    output logic [15:0] outInstructionAddress
);
    logic [15:0] instructionAddress;
    assign outInstructionAddress = instructionAddress;

    typedef enum logic [2:0] { reset1, reset2, run1, hold1, jump1, flush1 } statetype;
    statetype state, nextState;

    always_ff @(posedge clk)
    begin
        if(reset)   state <= reset1;
        else        state <= nextState;
    end

    always_ff @(posedge clk)
    begin
        if(changeInstructionAddress)    instructionAddress <= inInstructionAddress;
        else if(reset)                  instructionAddress <= 16'h0000;
        else if(holdSigFromControl)     instructionAddress <= instructionAddress;
        else                            instructionAddress <= instructionAddress + 2;
    end

    always_comb 
    begin
        case(state)
        reset1: nextState = reset2;
        reset2: nextState = run1;
        run1:    if(holdSignalFromALU) nextState = hold1;
                else if(changeInstructionAddress) nextState = jump1;
                else nextState = run1;
        hold1:   if(holdSignalFromALU) nextState = hold1;
                else nextState = run1;
        jump1:   nextState = run1;
        flush1:  nextState = run1;
        endcase
    end

    always_comb 
    begin
        case(state)
        reset1:
        begin
            holdSigFromControl = 1;
            resetSigFromControl = 1;
        end
        reset2:
        begin
            holdSigFromControl = 1;
            resetSigFromControl = 0;
        end
        run1: 
        begin
            holdSigFromControl = 0;
            resetSigFromControl = 0;
        end
        hold1:
        begin
            holdSigFromControl = 1;
            resetSigFromControl = 0;
        end
        jump1:
        begin
            holdSigFromControl = 0;
            resetSigFromControl = 0;
        end
        flush1:
        begin
            holdSigFromControl = 0;
            resetSigFromControl = 0;
        end
        endcase
    end

endmodule