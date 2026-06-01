# 16-BIT CPU

In this project, I am trying to design a CPU in SystemVerilog completely from Scratch.
The CPU is based on a custom instruction set, however, it is inspired by RISC-V.
Below, you will find further information about the IS, datapaths and more.
The final goal is to bring these designs onto a FPGA and test it on real silicon.

# Features

Obviously designing a complete CPU would be insane. My goal with this project was to
build a functioning fundamental pipeline similar to RISC-V, covering as much features and ideas as possible. Understanding how does information actually pass inside a CPU. What are the limitations in comparison to parallel yet less dynamic processors. Another simplification was that my FPGA board has a large SRAM, that my CPU does not have long cycles waiting for a potential DRAM to retrieve or store information.

# Insights

As you see by the size and choice of my instructions, the core idea of a CPU is not the computation itself but rather the organziation of instructions. It is about control flow. Other microprocessor such as GPUs, and custom hardware are responsbile for the computation-intensive tasks.

# Instruction Set
- 0000 (0) -> CONST
- 0001 (1) -> ADD
- 0010 (2) -> SUB
- 0011 (3) -> (MUL)
- 0100 (4) -> (DIV)
- 0101 (5) ->
- 0110 (6) ->
- 0111 (7) -> 
- 1000 (8) -> JMP
- 1001 (9) -> BZ (BRANCH ZERO)
- 1010 (A) -> ADDI
- 1011 (B) -> CALL 
- 1100 (C) -> RET
- 1101 (D) -> LOAD
- 1110 (E) -> STORE
- 1111 (F) -> NOP 

# Register Assignment
- R14: address to jump after CALL
- R15: stack pointer address

# Instruction Structure
## CONST, ADDI
- 4-BIT OPCODE, 4-BIT DST REGISTER, 8-BIT IMMEDIATE

(for ADDI the DST REGISTER = SOURCE REGISTER)

## ADD, SUB
- 4-BIT OPCODE, 4-BIT DST REGISTER, 4-BIT SOURCE REGISTER_1, 4-BIT SOURCE REGISTER_2

## JMP
- 4-BIT OPCODE, 4-BIT EMPTY, 8-BIT ADDRESS

(relative address)

## BZ
- 4-BIT OPCODE, 4-BIT REGISTER, 8-BIT ADDRESS

(absolute ADDRESS)

## CALL
- 4-BIT OPCODE, 4-BIT EMPTY, 8-BIT ADDRESS

(absolute ADDRESS)

## LOAD, STORE
- 4-BIT OPCODE, 4-BIT SOURCE/DST REGISTER, 4-BIT BASE ADDRESS REGISTER (F), 4-BIT OFFSET

## NOP, RET
- 4-BIT OPCODE, 12-BIT EMPTY

