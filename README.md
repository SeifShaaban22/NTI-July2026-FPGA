# NTI July 2026 FPGA Course Projects

A complete collection of my **NTI July 2026 FPGA** work, implemented in **Verilog**.

## Repository Overview

This repository contains the labs and final projects completed during the course, organized under the `projects/` directory.

- **Repository:** [SeifShaaban22/NTI-July2026-FPGA](https://github.com/SeifShaaban22/NTI-July2026-FPGA)
- **Primary language:** Verilog (100%)
- **Course track:** FPGA Digital Design

## What I Built

This repository documents my progress from basic digital logic exercises to complete FPGA-style systems. It includes:

- 12 labs covering core Verilog and digital design concepts
- 2 final projects focused on real-world embedded digital systems
- A full modular datapath project combining memory, serial/parallel conversion, and ALU control

## Labs Overview

> Note: Some lab folders may contain more than one source file, including testbenches.

### Lab 1 — Introductory digital logic
Likely focused on the very basics of Verilog and hardware design foundations.

### Lab 2 — SIPO shift register
Implemented a **Serial-In Parallel-Out (SIPO)** shift register.

**What it does:**
- Accepts serial input bit-by-bit
- Shifts data into a parallel register on each clock edge
- Supports active-low reset
- Uses a shift enable signal to control loading

**What I learned:**
- Shift-register design
- Sequential always blocks
- Reset handling
- Bit-wise data movement

### Lab 3 — Core combinational/sequential logic practice
Likely covered additional Verilog fundamentals and logic building blocks.

### Lab 4 — Tri-state driver / output enable
Implemented a simple **driver** module.

**What it does:**
- Passes `data_in` to `data_out` when enabled
- Drives high impedance (`Z`) when disabled

**What I learned:**
- Tri-state behavior
- Output enable control
- Bus-style signal sharing

### Lab 5 — ALU design
Implemented an **ALU** module with multiple operations.

**What it does:**
- Supports add, subtract, AND, XOR, OR, and pass-through
- Detects when input `a` is zero
- Selects operation using a 3-bit opcode

**What I learned:**
- Arithmetic and logic operations in Verilog
- `case`-based control logic
- Output flags
- Parameterized module design

### Lab 6 — Additional Verilog design practice
Likely focused on extending combinational and sequential design skills.

### Lab 7 — Additional Verilog design practice
Likely focused on building and testing more hardware modules.

### Lab 8 — RAM / memory module
Implemented a basic **RAM** module.

**What it does:**
- Stores data in an internal memory array
- Supports read and write operations
- Uses an address input to access memory locations
- Shares data through an `inout` bus in the lab version

**What I learned:**
- Memory modeling in Verilog
- Read/write control logic
- Indexed arrays for hardware storage
- Bus interfacing concepts

### Lab 9 — Counter design and verification
Implemented a parameterized **counter**.

**What it does:**
- Resets the count to zero
- Loads a specific value when `load` is active
- Increments when `enab` is active
- Includes a testbench that checks different scenarios

**What I learned:**
- Register-based counters
- Priority of control signals
- Simulation-based verification
- Testbench stimulus and expected checking

### Lab 10 — FSM design
Implemented a **finite state machine**.

**What it does:**
- Uses a 2-segment FSM structure
- Tracks states `S0`, `S1`, and `S2`
- Produces outputs based on both state and input conditions
- Includes a dedicated testbench

**What I learned:**
- FSM state encoding
- State register and next-state logic separation
- Moore/Mealy-style output thinking
- FSM simulation and transition testing

### Lab 11 — Debouncer and sequence detector
Implemented a **button debouncer** and a **sequence detector** FSM.

**Debouncer:**
- Filters noisy push-button input
- Waits for stable input before changing state
- Uses a counter-based timing approach

**Sequence detector:**
- Detects a specific input pattern using states
- Uses FSM-style pattern recognition

**What I learned:**
- Debouncing real-world signals
- FSMs for input conditioning
- Sequence detection concepts
- Timing-based validation of mechanical inputs

### Lab 12 — Edge detection
Implemented a **rising edge detector**.

**What it does:**
- Detects when a signal transitions from low to high
- Compares Moore-style and Mealy-style tick outputs
- Includes a testbench for waveform observation

**What I learned:**
- Edge detection logic
- Comparing Moore and Mealy outputs
- One-cycle pulse generation
- Timing-aware digital design

## Final / Major Projects

### Final Project (Modulus)
A final project focused on modulus-based digital logic. This project likely built on arithmetic and control concepts developed across the labs.

### Final Project (Traffic Light)
A complete **traffic light controller** project.

**What it does:**
- Controls traffic light outputs for multiple directions
- Uses FSM-based control
- Includes support for button input, emergency behavior, and empty-sensor input
- Drives seven-segment display outputs for status information
- Includes a full testbench for simulation

**What I learned:**
- Realistic FSM system design
- Multi-input control logic
- Output coordination across several subsystems
- Integrating counters, resets, and display logic in one design

### Full Project
A modular end-to-end digital datapath.

**Architecture:**
- RAM stores 20-bit words
- PISO converts parallel data to serial
- SIPO reconstructs serial data into parallel form
- ALU processes the decoded word
- Top module connects everything together

**Word format:**
- `alu_en` in bit 19
- `opcode` in bits 18:16
- `in_a` in bits 15:8
- `in_b` in bits 7:0

**What I learned:**
- Modular system integration
- Datapath construction
- Serial and parallel data conversion
- Control signal routing between hardware blocks
- Building and verifying a complete FPGA-style pipeline

## Skills I Practiced

Across these projects, I practiced:

- Verilog RTL design
- Combinational and sequential logic
- FSM design and pattern detection
- Memory and counter design
- Serial/parallel data conversion
- Debouncing and edge detection
- Testbench creation and simulation
- Modular hardware system integration

## Summary

This repository shows my progression from basic Verilog exercises to more complete digital systems. I learned how to design, connect, and test hardware blocks, and how to organize FPGA projects in a structured and reusable way.

## Notes

This repo serves as my course portfolio for NTI July 2026 FPGA training and documents my progress from introductory labs to full final implementations.
