# Design a CPU with verilog on FPGA

We design a CPU with verilog. This responsitory contains the source codes and simulation results of the designed CPU.

Zhiyu Mou, Luxi He

The whole project codes are avaiable on 
https://cloud.tsinghua.edu.cn/f/f2756af1126f495b8e99/ or https://drive.google.com/file/d/1dpocVqQ6oqilHt0QoGOrNsJc2w286cJ0/view?usp=sharing

## General Architecture

Our CPU embodies two parts: the CPU_Main part and the Machine Code ROM part, and they are affixed by a data bus of 8 bits. Besides, the CLK wire and the RESET wire employ the clock signals and the reset signals for the whole CPU. The general architecture of our CPU is shown below. We use 8 bits to represent the data in this CPU and 16 bits for instructions.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/general_architecture.jpeg" width="640" alt="general_architecture"> 

## Simulations

We are simulating |a+b-c| for example. 

E.g. |48+16-64| = 16
The instructions in the Machine Code ROM are:
```verilog
  //Example_1_:|32+16-64|
  //MOV AL, 32
  ALL_instruction[63:48] <= 16'b000_1_1_000_00100000;
  //ADD AL, 16
  ALL_instruction[47:32] <= 16'b001_1_1_000_00010000;
  //SUB AL, 64
  ALL_instruction[31:16] <= 16'b010_1_1_000_01000000;
  //ABS AL
  ALL_instruction[15:0] <= 16'b011_0_z_000_zzzzzzzz;
```

The time diagram result is shown below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/example_2.jpeg" width="800" alt="13"> 

The following shows the outputs of the ALU of each instruction.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/table_3.png" width="640" alt="13"> 

## Detailed Architecture

The six detailed modules are shown below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_register_module.jpeg" width="220" alt="1">  <img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/instruction_decoder.jpeg" width="220" alt="3"> <img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/data_register.jpeg" width="220" alt="4"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/mul_reg_to_alu.png" width="220" alt="6"> <img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/alu_module.jpeg" width="220" alt="7"> <img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/machine_code_rom.png" width="220" alt="8"> 

### CPU Main
CPU_Main involves 5 sub parts.

#### Instruction Register Module

The Instruction Register receives the instructions from the Machine Code ROM through the Data Bus. As one instruction is in 16 bits while the width of Data Bus is in 8 bits, two clocks are necessary to completely receive one instruction. The instruction registers inside will update after two clocks and they will send the first half instruction to the Instruction Decoder and the second half to the Multiplexer_Reg_to_ALU. The following shows the Instruction Register Module.

#### Instruction Decoder Module
The Instruction Decoder is utterly one of the most important parts of the CPU, since it controls the activities of all the parts. It receives the first half of the instruction and sends the orders to other modules (ALU, Data Register, etc.). The vital control signals are listed below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/table.png" width="640" alt="2">

#### Data Register Module
There are three sub parts of the Data Register: data registers, data write decoder, and data read multiplexers.Fig 4 elucidates the Data Register Module.

A data register contains 8 bits(one byte) memories. 8 data registers with the addresses from 000 to 111 are all set, each of them can accommodate 8 bytes data. We can actually create more registers to save more data. There are two multiplexers to enable data A and data B to be the output. The control signals are from Instruction Decoder.There is also a write data decoder which enables the data to write in a certain register according to the address. The hierarchy of the data register is shown below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/hierarchy.png" width="640" alt="5">



#### Multiplexer_Reg_to_ALU Module
This multiplexer is to designate which data will serve as data A to be calculated in ALU. There are two inputs: one is immediate data from directly the instructions, another is the data from the Data Register output :data A. The selection signal is controlled by the Instruction Decoder. The following shows this multiplexer.


#### ALU Module
The ALU Module does the arithmetic and logic calculations of the CPU according to the input signal FS, and it can do 8 kind of calculations(see in PartⅡ:opcode). The outputs are directly sent to the Data Register and written in one of the registers. Fig 7 shows the ALU Module.

### Machine Code ROM
The Machine Code ROM holds the instructions the CPU will execute. The instructions are written manually, ready to be sent to the Data Bus automatically at proper time.


## Time Diagrams
### Data Configurations 
All data in CPU are 8 bits width. The type of the data is integer, and the range of the data is -128~127.
### Instruction Configurations
All instructions are 16 bits width. The meaning of each bit is demonstrated below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/table_1.png" width="640" alt="9"> 

### Instructions Time Diagrams
Each instruction execution lasts for 8 clocks. There are time counters in Machine Code ROM, Instruction Register, and Instruction Decoder, which help them to keep track of the time line and behavior at the right time. Instruction Decoder generates the control signals and tells the other modules what to do in certain clocks. The time diagrams are shown below.

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/Mov.png" width="640" alt="10"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/table_4.png" width="640" alt="11"> 

<img src="https://github.com/nobodymx/CPU-design-verilog-FPGA/blob/main/Img/table_5.png" width="640" alt="12"> 


