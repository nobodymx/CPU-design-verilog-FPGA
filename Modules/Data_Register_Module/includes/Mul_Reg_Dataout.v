
module Mul_Reg_Dataout(
	//inputs
	input [2:0]Dataout_address,
	input Enable_out,
	input [7:0]out_000,
	input [7:0]out_001,
	input [7:0]out_010,
	input [7:0]out_011,
	input [7:0]out_100,
	input [7:0]out_101,
	input [7:0]out_110,
	input [7:0]out_111,
	
	//outputs
	output [7:0] Dataout
    );
	 
	 //inside 
	 reg [7:0] temp_data;
	 assign Dataout = temp_data;
	  parameter
		reg1 = 3'b000,
		reg2 = 3'b001,
		reg3 = 3'b010,
		reg4 = 3'b011,
		reg5 = 3'b100,
		reg6 = 3'b101,
		reg7 = 3'b110,
		reg8 = 3'b111;
	 
	 always@(*)
		if(Enable_out == 1)
			case(Dataout_address)
				reg1: temp_data = out_000;
				reg2: temp_data = out_001;
				reg3: temp_data = out_010;
				reg4: temp_data = out_011;
				reg5: temp_data = out_100;
				reg6: temp_data = out_101;
				reg7: temp_data = out_110;
				reg8: temp_data = out_111;
				default: temp_data = 8'bzzzz_zzzz;
				
			endcase
		else if(!Enable_out)
			temp_data = 8'bzzzz_zzzz;

endmodule
