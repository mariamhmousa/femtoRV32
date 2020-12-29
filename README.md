# femtoRV32

Assumptions: 
1. Clock cycle Counter is 32 bits
2. Memory is 4kB then changed while trying to test on the FPGA to 1kB (small memory to be tested easily -- generating bitstream)
3. Instructions start from byte 2048 in the memory.

What is working: All RISCV-32I 40 instructions are supported. They have all been tested and the simulation results show that they are all working properly.

Issues:  
1. The hazard detection unit is still supported although it is no longer needed since a new instruction is fetched every two clock cycles instead of one. There was not just time to remove it and we believed this is OK since it has no negative impact on the performance of the processor.
2. The FPGA is not working well. We tried testing the code on the FPGA several times. Synthesis and implementation steps are done successfully, the bitstream is generated, but the code is not reflected on FPGA.
