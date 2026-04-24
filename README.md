This project is about building a simple CPU with SystemVerilog (HDL) that can be uploaded onto a FPGA.

- SystemVerilog (HDL) for designing the hardware
- FPGA boad: Terasic DE10-Lite

### Design 1
- CPU reads instructions sequentially from a ROM (FETCH)
- register block where the data is comming from (DECODE)
- ALU where the data is being processed (EXECUTE)
- // so far there is no seperate data memory or writeable instruction memory
- store ALU result into the register block (WRITE BACK)


# Instruction Set
- 0000 (0) -> CONST
- 0001 (1) -> ADD
- 0010 (2) -> SUB
- 0011 (3) -> MUL
- 0100 (4) -> DIV
- 0101 (5) -> AND
- 0110 (6) -> OR
- 0111 (7) -> XOR
- 1000 (8) -> JMP
- 1001 (9) -> BRANCH
- 1010 (10) -> 
- 1011 (11) ->
- 1100 (12) ->
- 1101 (13) -> LOAD
- 1110 (14) -> STORE
- 1111 (F) -> NOP 
