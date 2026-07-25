# Lab 1 Documentation — Verilog Basics

## 1) Overview
This lab demonstrates basic combinational design in Verilog using:
- A parameterized arithmetic module with enable-controlled operation (addition/subtraction).
- A 1-bit full adder implemented behaviorally.

Repository: `SeifShaaban22/NTI-July2026-FPGA`  
Lab path: `projects/Lab 1/`

---

## 2) Module: `messi` (in `concatination_Ex.v`)

### Purpose
Performs arithmetic operation on two inputs:
- If `en = 1` → addition (`in1 + in2`)
- If `en = 0` → subtraction (`in1 - in2`)

Result is assigned using concatenation:
- `{carry, out}`

### Source
`projects/Lab 1/concatination_Ex.v`

### Interface
- **Parameter**
  - `w = 4` → input/output width
- **Inputs**
  - `in1 [w-1:0]`
  - `in2 [w-1:0]`
  - `en`
- **Outputs**
  - `out [w-1:0]` (registered type, combinational assignment)
  - `carry` (registered type, combinational assignment)

### Behavior
Inside `always @(*)`:
- `en == 1`:
  - `{carry, out} = in1 + in2;`
- Else:
  - `{carry, out} = in1 - in2;`

### Notes
- This is **combinational logic** (not clocked).
- `carry` in subtraction represents MSB/borrow-related bit from fixed-width arithmetic result.
- File name has typo: `concatination_Ex.v` (expected spelling: `concatenation`).

---

## 3) Module: `full_adder` (in `full_adder_Behavioral.v`)

### Purpose
Implements a 1-bit full adder using behavioral Verilog.

### Source
`projects/Lab 1/full_adder_Behavioral.v`

### Main Equation
For inputs `a`, `b`, and carry-in `c`:
- `sum = a ^ b ^ c`
- `cout = ((a ^ b) & c) | (a & b)`

### Interface (first implementation)
- **Inputs**
  - `a`, `b`, `c`
- **Outputs**
  - `sum`
  - `cout`

### Behavior
Combinational block:
- `sum = (a ^ b) ^ c;`
- `cout = ((a ^ b) & c) | (a & b);`

---

## 4) Important Code Issues Found

In `full_adder_Behavioral.v`, there is a **second module definition** with problems:

1. Duplicate module name: `full_adder` is declared twice in the same file.
2. Syntax error: missing `;` after second module declaration line.
3. Signal mismatch:
   - Declares outputs `cout` and `carry`
   - Uses `sum` in assignment without declaration.
4. Inconsistent output naming (`cout` vs `carry`).

### Recommended Fix
Keep **one** clean `full_adder` module only, e.g.:

```verilog
module full_adder (
    input  a,
    input  b,
    input  c,
    output reg sum,
    output reg cout
);
always @(*) begin
    {cout, sum} = a + b + c;
end
endmodule
```

---

## 5) Verification Ideas (Suggested Test Cases)

### A) `messi` module
Use width `w = 4` and test:
1. `en=1, in1=4'b0011, in2=4'b0101` → `out=1000`, `carry=0`
2. `en=1, in1=4'b1111, in2=4'b0001` → `out=0000`, `carry=1`
3. `en=0, in1=4'b0110, in2=4'b0010` → `out=0100`
4. `en=0, in1=4'b0010, in2=4'b0110` → wrapped subtraction result in 4-bit arithmetic

### B) `full_adder` module truth table

| a | b | c | sum | cout |
|---|---|---|-----|------|
| 0 | 0 | 0 |  0  |  0   |
| 0 | 0 | 1 |  1  |  0   |
| 0 | 1 | 0 |  1  |  0   |
| 0 | 1 | 1 |  0  |  1   |
| 1 | 0 | 0 |  1  |  0   |
| 1 | 0 | 1 |  0  |  1   |
| 1 | 1 | 0 |  0  |  1   |
| 1 | 1 | 1 |  1  |  1   |

---

## 6) Learning Outcomes
By completing this lab, you should be able to:
- Write combinational `always @(*)` logic.
- Use parameterized bus widths.
- Use concatenation in assignments (`{carry,out}`).
- Implement a behavioral full adder.
- Identify and fix common Verilog syntax/structure issues.

---

## 7) Suggested Folder Structure
```text
projects/
  Lab 1/
    concatination_Ex.v
    full_adder_Behavioral.v
docs/
  lab1-documentation.md
```