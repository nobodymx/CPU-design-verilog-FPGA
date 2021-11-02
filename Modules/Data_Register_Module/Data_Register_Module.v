
module Data_Register_Module(
	//inputs
	input Enable_write,
	input [7:0]Data_write,
	input [2:0]Data_write_address,
	
	input Enable_Read_Data_B,
	input Enable_Read_Data_A,
	input [2:0] Data_B_address,
	input [2:0] Data_A_address,
	
	//outputs
	output [7:0]Data_out_A,
	output [7:0]Data_out_B,
	output check
    );
	 
	 wire [7:0] enabler;
	 wire [7:0] data_out_000;
	 wire [7:0] data_out_001;
	 wire [7:0] data_out_010;
	 wire [7:0] data_out_011;
	 wire [7:0] data_out_100;
	 wire [7:0] data_out_101;
	 wire [7:0] data_out_110;
	 wire [7:0] data_out_111;
	 reg CHECK;
	 assign check = CHECK;
	 initial
	  begin
		CHECK = 1'b1;
	  end
	 
	 
	 //data write decoder
	 Data_write_Decoder_Module data_write_decoder(
		.Data_write_address_(Data_write_address),
		.Enable_write_(Enable_write),
		.Enabler(enabler)
	 );
	 //2 dataout multiplexers
	 Mul_Reg_Dataout multiplexer_A(
		.Dataout_address(Data_A_address),
		.Enable_out(Enable_Read_Data_A),
		.out_000(data_out_000),
		.out_001(data_out_001),
		.out_010(data_out_010),
		.out_011(data_out_011),
		.out_100(data_out_100),
		.out_101(data_out_101),
		.out_110(data_out_110),
		.out_111(data_out_111),
		.Dataout(Data_out_A)
		
	 );
	  Mul_Reg_Dataout multiplexer_B(
		.Dataout_address(Data_B_address),
		.Enable_out(Enable_Read_Data_B),
		.out_000(data_out_000),
		.out_001(data_out_001),
		.out_010(data_out_010),
		.out_011(data_out_011),
		.out_100(data_out_100),
		.out_101(data_out_101),
		.out_110(data_out_110),
		.out_111(data_out_111),
		.Dataout(Data_out_B)
		
	 );
	 
	 
	 //8 registers
	 Data_Register register_000(
		.Enable_write(enabler[0]),
		.Data_write(Data_write),
		.Data(data_out_000)
	 );
	 Data_Register register_001(
		.Enable_write(enabler[1]),
		.Data_write(Data_write),
		.Data(data_out_001)
	 );
	 Data_Register register_010(
		.Enable_write(enabler[2]),
		.Data_write(Data_write),
		.Data(data_out_010)
	 );
	 Data_Register register_011(
		.Enable_write(enabler[3]),
		.Data_write(Data_write),
		.Data(data_out_011)
	 );
	 Data_Register register_100(
		.Enable_write(enabler[4]),
		.Data_write(Data_write),
		.Data(data_out_100)
	 );
	 Data_Register register_101(
		.Enable_write(enabler[5]),
		.Data_write(Data_write),
		.Data(data_out_101)
	 );
	 Data_Register register_110(
		.Enable_write(enabler[6]),
		.Data_write(Data_write),
		.Data(data_out_110)
	 );
	 Data_Register register_111(
		.Enable_write(enabler[7]),
		.Data_write(Data_write),
		.Data(data_out_111)
	 );
endmodule
