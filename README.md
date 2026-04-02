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
0000 -> CONST
0001 -> ADD

// inmplement STALL