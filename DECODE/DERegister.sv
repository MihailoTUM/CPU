// pipeline register

module DERegister(
    input logic clk,
    input logic [15:0] instruction,
    output logic [3:0] opcode,
    output logic [3:0] dst,
    output logic [3:0] src1,
    output logic [3:0] src2
);
   always_ff @(posedge clk)
   begin
        opcode <= instruction[15:12];
        dst <= instruction[11:8];
        src1 <= instruction[7:4];
        src2 <= instruction[3:0];
   end
endmodule