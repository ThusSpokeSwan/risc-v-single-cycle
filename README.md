# 32-bit Single-Cycle RISC-V Core in Verilog

A complete, 32-bit single-cycle processor core implementing a foundational subset of the RISC-V (RV32I) instruction set architecture. Designed in Verilog, this project features a fully modular data path, a centralized control unit, and an exhaustive verification environment. 

## 🚀 Features

* **Architecture**: 32-bit Single-Cycle Data Path.
* **R-Type Instructions**: `add`, `sub`, `and`, `or`, `slt`.
* **I-Type Instructions**: `lw` (Load Word).
* **S-Type Instructions**: `sw` (Store Word).
* **B-Type Instructions**: `beq` (Branch if Equal).
* **Memory Integration**: Word-aligned byte-addressable Data Memory and Instruction Memory.
* **Verification**: Includes a self-checking testbench (`tb_Single_Cycle.v`) with integrated execution reporting and branch-target verification.

## 📂 Project Structure

* `src/Single_Cycle_Top.v`: The top-level module connecting the data path and control logic.
* `src/ALU.v` & `src/Alu_Decoder.v`: Handles arithmetic and logical operations.
* `src/Control_Unit.v` & `src/Decoder.v`: Generates multiplexer selections and write-enable signals based on instruction opcodes.
* `src/Register_File.v`: 32x32-bit register file with hardwired `x0`.
* `src/Data_Memory.v` & `src/Instruction_Memory.v`: Synthesizable memory models.
* `src/Sign_Extend.v`: Handles I, S, and B-type immediate generation.
* `src/tb_Single_Cycle.v`: The main simulation testbench.
* `src/program.hex`: Compiled machine code used to initialize the instruction memory during simulation.

## 📋 Included Verification Program

The included `src/program.hex` executes the following RV32I assembly program to verify arithmetic, logical, memory, and branch functionality:

```assembly
lw x1, 0(x0)      // mem[0]=15 -> x1 = 15
lw x2, 4(x0)      // mem[1]=25 -> x2 = 25
lw x3, 8(x0)      // mem[2]=10 -> x3 = 10

add x4, x1, x2    // x4 = 15 + 25 = 40
sub x5, x2, x1    // x5 = 25 - 15 = 10
and x6, x1, x3    // x6 = 15 & 10 = 10
or  x7, x1, x2    // x7 = 15 | 25 = 31
slt x8, x2, x1    // x8 = (25 < 15) ? 1 : 0 = 0
slt x9, x1, x2    // x9 = (15 < 25) ? 1 : 0 = 1

sw x4, 12(x0)     // Store 40 into mem[3]
sw x6, 16(x0)     // Store 10 into mem[4]

beq x3, x5, 8     // x3 == x5, branch forward and skip the next instruction
sw x9, 20(x0)     // Skipped

sw x7, 24(x0)     // Store 31 into mem[6]

beq x0, x0, 0     // Infinite loop to halt execution
```

### Expected Results

**Registers**

| Register | Expected Value |
|----------|---------------:|
| x1 | 15 |
| x2 | 25 |
| x3 | 10 |
| x4 | 40 |
| x5 | 10 |
| x6 | 10 |
| x7 | 31 |
| x8 | 0 |
| x9 | 1 |

**Data Memory**

| Address | Word | Expected Value |
|--------:|-----:|---------------:|
| 12 | mem[3] | 40 |
| 16 | mem[4] | 10 |
| 20 | mem[5] | Unchanged (store skipped by branch) |
| 24 | mem[6] | 31 |


## 🛠️ Getting Started

### Prerequisites
* **Xilinx Vivado** (or any standard Verilog simulator like ModelSim or Icarus Verilog).

### Simulation & Testing
1. Clone the repository to your local machine.
2. Open the project in Vivado and set `src/tb_Single_Cycle.v` as the top simulation module.
3. Ensure `src/program.hex` is located in the simulation directory. 
4. Run the behavioral simulation. The testbench will output a detailed pass/fail report in the TCL console verifying register states (`x4` through `x9`) and memory targets (`mem[3]` through `mem[6]`).

## 🔮 Future Work

* **Pipelining**: Convert the single-cycle data path into a 5-stage pipelined architecture.
* **Extended RV32I Support**: Implement additional branch conditions (`bne`, `blt`, `bge`), shifts (`sll`, `srl`), and immediate logic instructions (`addi`, `andi`).

## 📝 License
This project is licensed under the MIT License.