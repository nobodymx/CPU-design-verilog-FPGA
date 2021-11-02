`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: nobodymzy.com
// Engineer: MZY
// 
// Create Date:    10:14:41 02/08/2019 
// Design Name: CPU_General
// Module Name:    CPU 
// Project Name: CPU_General
// Target Devices: FPGA
// Tool versions: 1.0
// Description: 
	//It can contains generally 5 parts
//
// Dependencies: None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU(
	input clk,
	input reset,
	output [7:0]databus,
	output check_instruction_register,
	output check_instruction_decoder,
	output check_data_register,
	output check_alu,
	output check_mul
    );
	 wire [7:0]Data_Bus;
	 wire [2:0]wire_Opcode;
	 wire [7:0]wire_Operand_2;
	 wire wire_Operand_num;
	 wire wire_Operand_2_type;
	 wire [2:0] wire_Operand_1_address;
	 wire [2:0] wire_Opcode_out;
	 assign databus = Data_Bus;
	 
	 //Machine_Code_ROM
	 Machine_Code_ROM_Module machine_code_rom(
		.CLK(clk),
		.RESET(reset),
		.half_instruction(Data_Bus)
	 );
	 //Instruction Register
	 Instruction_Register_Module instruction_register(
		.CLK(clk),
		.Instruction_in(Data_Bus),
		.RESET(reset),
		.Opcode(wire_Opcode),
		.Operand_2(wire_Operand_2),
		.Operand_num(wire_Operand_num),
		.Operand_2_type(wire_Operand_2_type),
		.Operand_1_address(wire_Operand_1_address),
		.check(check_instruction_register)
	 );
	 
	 wire wire_Enable_RegALU_mul;
	 wire wire_Enable_ALU;
	 wire wire_Enable_Write_Data;
	 wire wire_Enable_Read_Data_A;
	 wire wire_Enable_Read_Data_B;
	 wire [2:0] wire_Operand_1_address_to_write;
	 wire [2:0] wire_Operand_1_address_to_A;
	 wire [2:0] wire_Operand_1_address_to_B;
	 //Instruction Decoder
	 Instruction_Decoder_Module instruction_decoder(
		.CLK(clk),
		.RESET(reset),
		.Opcode(wire_Opcode),
	 	.Operand_1_address(wire_Operand_1_address),
		.Operand_2_type(wire_Operand_2_type),
		.Operand_number(wire_Operand_num),
		.Opcode_out(wire_Opcode_out),
		.Enable_RegALU_mul(wire_Enable_RegALU_mul),
		.Enable_ALU(wire_Enable_ALU),
		.Enable_Write_Data(wire_Enable_Write_Data),
		.Enable_Read_Data_A(wire_Enable_Read_Data_A),
		.Enable_Read_Data_B(wire_Enable_Read_Data_B),
		.Operand_1_address_to_write(wire_Operand_1_address_to_write),
		.Operand_1_address_to_A(wire_Operand_1_address_to_A),
		.Operand_1_address_to_B(wire_Operand_1_address_to_B),
		.check(check_instruction_decoder)
		
	 );
	 wire [7:0] wire_Data_write;
	 wire [7:0] wire_Data_out_A;
	 wire [7:0] wire_Data_out_B;
	 //Data Register
	 Data_Register_Module data_register(
		.Enable_write(wire_Enable_Write_Data),
		.Data_write(wire_Data_write),
		.Data_write_address(wire_Operand_1_address_to_write),
		.Enable_Read_Data_B(wire_Enable_Read_Data_B),
		.Enable_Read_Data_A(wire_Enable_Read_Data_A),
		.Data_B_address(wire_Operand_1_address_to_B),
		.Data_A_address(wire_Operand_1_address_to_A),
		.Data_out_A(wire_Data_out_A),
		.Data_out_B(wire_Data_out_B),
		.check(check_data_register)
	 );
	 
	 wire [7:0] wire_MUL_to_ALU;
	 //ALU
	 ALU_Module alu(
		.CLK(clk),
		.Enable_cal(wire_Enable_ALU),
		.FS(wire_Opcode_out),
		.Data_in_A(wire_MUL_to_ALU),
		.Data_in_B(wire_Data_out_B),
		.Result_out(wire_Data_write),
		.check(check_alu)
		
	 );
	 //Mul_Reg_to_ALU
	 Mul_Reg_to_ALU_Module mul_reg_to_alu(
		.selection(wire_Enable_RegALU_mul),
		.Immediate_data(wire_Operand_2),
		.Register_data(wire_Data_out_A),
		.Data_out(wire_MUL_to_ALU),
		.check(check_mul)
		
	 ); 


endmodule
