# Single cycle RISC-V implementation in System Verilog with Verification
Fully implemented single cycle RISC-V with support of R, I, J, S, B and U instructions. Also, formal verification test benches are written.  

## Dependencies
i. QuestaSim (vlog, vsim)  
ii. gtkwave  
iii. make command  
iv. GNU tool chain for RISC-V and should be in path  (https://github.com/AhsanAliUet/gnu-tool-chain-for-riscv-lite)

## Using the project
Clone/download the repository.  
```
git clone https://github.com/AhsanAliUet/single-cycle-risc-v-implementation-in-system-verilog-with-verification
```
and then:
```
cd single-cycle-risc-v-implementation-in-system-verilog-with-verification
```

and finally run the Makefile using the following command (provided that QuestaSim is installed):
```
make run
```

if you want to see the waveforms, just try (if gtkwave is installed and is in PATH):
```
make wave
```

And enjoy RISC-V.

## Author
- [@Ahsan Ali](https://github.com/AhsanAliUet)
