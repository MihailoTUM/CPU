

module ControlUnit(
    input logic clk,
    input logic reset,
    input logic inHoldSignalFromDataMemory,
    input logic [15:0] inNewInstructionAddress,
    input logic inChangeToNewInstructionAddress,

    output logic outHoldSignalFromControl,
    output logic outResetSignalFromControl,

    output logic [15:0] outInstructionAddress
);
    logic [15:0] currentInstructionAddress;

    typedef enum logic [2:0] { reset_1, reset_2, run_1, hold_1, jump_1 } statetype;

    statetype currentState, nextState;

    always_ff @(posedge clk)
    begin
        if(reset)   
        begin
            currentInstructionAddress <= 16'h0000;
            currentState <= reset_1;
        end
        else
        begin
            currentState <= nextState;
            if(nextState == run_1)
                currentInstructionAddress <= currentInstructionAddress + 2;
            else if(nextState == jump_1)
                currentInstructionAddress <= inNewInstructionAddress;
            else 
                currentInstructionAddress <= currentInstructionAddress;
        end
    end

    assign outInstructionAddress = currentInstructionAddress;

    always_comb
    begin
        case(currentState)
            reset_1: nextState = reset_2;
            reset_2: nextState = run_1;

            run_1: 
                if(inHoldSignalFromDataMemory) nextState = hold_1;
                else if(inChangeToNewInstructionAddress) nextState = jump_1;
                else nextState = run_1;

            jump_1:
                if(inHoldSignalFromDataMemory) nextState = hold_1;
                else if(inChangeToNewInstructionAddress) nextState = jump_1;
                else nextState = run_1;

            hold_1:
                if(inHoldSignalFromDataMemory) nextState = hold_1;
                else if(inChangeToNewInstructionAddress) nextState = jump_1;
                else nextState = run_1;
        endcase
    end

    always_comb
    begin
        case(currentState)
            reset_1: 
            begin
                outHoldSignalFromControl = 0;
                outResetSignalFromControl = 1;
            end
            reset_2:
            begin
                outHoldSignalFromControl = 0;
                outResetSignalFromControl = 0;
            end
            run_1:
            begin
                outHoldSignalFromControl = 0;
                outResetSignalFromControl = 0;
            end
            hold_1:
            begin
                outHoldSignalFromControl = 1;
                outResetSignalFromControl = 0;
            end
        endcase
    end

endmodule