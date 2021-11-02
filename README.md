# Design a CPU with verilog on FPGA

We design a CPU with verilog. This responsitory contains the source codes and simulation results of the designed CPU.

Zhiyu Mou, Luxi He

## General Architecture

Our CPU embodies two parts: the CPU_Main part and the Machine Code ROM part, and they are affixed by a data bus of 8 bits. Besides, the CLK wire and the RESET wire employ the clock signals and the reset signals for the whole CPU. The general architecture of our CPU is shown below. We use 8 bits to represent the data in this CPU and 16 bits for instructions.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/general_architecture.jpeg" width="640" alt="general_architecture"> 

## Detailed Architecture
### CPU Main
CPU_Main involves 5 sub parts.

#### Instruction Register Module

The Instruction Register receives the instructions from the Machine Code ROM through the Data Bus. As one instruction is in 16 bits while the width of Data Bus is in 8 bits, two clocks are necessary to completely receive one instruction. The instruction registers inside will update after two clocks and they will send the first half instruction to the Instruction Decoder and the second half to the Multiplexer_Reg_to_ALU. The following shows the Instruction Register Module.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="1"> 

#### Instruction Decoder Module
The Instruction Decoder is utterly one of the most important parts of the CPU, since it controls the activities of all the parts. It receives the first half of the instruction and sends the orders to other modules (ALU, Data Register, etc.). The vital control signals are listed below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/table.png" width="640" alt="2"> 

Details of the controls and activities of our CPU will be illustrated below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_decoder.jpeg" width="640" alt="3"> 
#### Data Register Module
There are three sub parts of the Data Register: data registers, data write decoder, and data read multiplexers.Fig 4 elucidates the Data Register Module.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="4"> 
A data register contains 8 bits(one byte) memories. 8 data registers with the addresses from 000 to 111 are all set, each of them can accommodate 8 bytes data. We can actually create more registers to save more data. There are two multiplexers to enable data A and data B to be the output. The control signals are from Instruction Decoder.There is also a write data decoder which enables the data to write in a certain register according to the address.The hierarchy of the data register is shown below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="5"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="6"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="7"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="8"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="9"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="10"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="11"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="12"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="640" alt="13"> 
