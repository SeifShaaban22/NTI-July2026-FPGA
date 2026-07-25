# Full Project Documentation

## Overview

The **Full project** is a modular Verilog design that demonstrates a simple end-to-end digital data path. It combines memory, serial/parallel conversion, and arithmetic logic processing into one pipeline.

The design is organized into the following blocks:

- **RAM**: stores 20-bit input words
- **PISO**: converts parallel data to serial data
- **SIPO**: reconstructs serial data back into parallel form
- **ALU**: performs arithmetic and logic operations
- **Top module**: connects all blocks together
- **Testbench**: verifies the complete system

---

## Architecture

```text
RAM -> PISO -> SIPO -> ALU
```

### Data Word Format

Each 20-bit word is structured as follows:

```text
[19]     alu_en
[18:16]  opcode
[15:8]   in_a
[7:0]    in_b
```

### Operation Selection

The ALU supports the following opcodes:

- `3'b000` — addition
- `3'b001` — subtraction
- `3'b010` — bitwise AND
- `3'b011` — bitwise XOR
- `3'b100` — bitwise OR
- `3'b101` — pass through `in_a`
- other values — output zero

---

## Module Details

### ALU
The ALU performs the selected operation when `alu_en` is asserted.

**Inputs**
- `in_a`
- `in_b`
- `opcode`
- `alu_en`

**Outputs**
- `alu_out`
- `a_is_zero`

**Behavior**
- If `alu_en = 0`, `alu_out` is forced to zero
- `a_is_zero` is asserted when `in_a == 0`

---

### RAM
The RAM module stores input data words and provides read/write access.

**Behavior**
- Clears memory on reset
- Writes `din` into `mem[addr]` when `wr` is asserted
- Reads data from memory when `rd` is asserted
- Asserts `valid` during read operations

---

### PISO
The PISO module converts a parallel word into a serial stream.

**Behavior**
- On enable, it outputs the most significant bit of the input word
- `valid` indicates that serial output is active

---

### SIPO
The SIPO module collects serial bits and rebuilds the full word.

**Behavior**
- Shifts in one bit on each clock edge when enabled
- Reconstructs the parallel word over time

---

### Top Module
The top module wires the system together and coordinates the flow of data through the pipeline.

---

## Testbench

The `tb_top.v` testbench demonstrates the full flow using sample vectors.

### Test Cases

1. `5 + 3 = 8`
2. `9 - 4 = 5`
3. `0 AND 7 = 0`
4. ALU disabled case, which forces the output to zero

### Purpose

The testbench is meant to verify:

- memory write and read behavior
- serial-to-parallel and parallel-to-serial conversion
- ALU function correctness
- zero-detection logic

---

## Notes

This project is a good educational example of:

- modular digital design
- datapath construction
- Verilog simulation
- basic FPGA system integration

It is especially useful for learning how independent hardware blocks can be connected into a complete processing pipeline.
