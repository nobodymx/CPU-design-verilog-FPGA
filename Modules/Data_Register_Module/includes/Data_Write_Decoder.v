
module Data_write_Decoder_Module(
	//inputs
	input [2:0] Data_write_address_,
	input Enable_write_,
	//outputs
	output [7:0]Enabler
    );
	 
	 reg[7:0] enabler;
	 assign Enabler = enabler;
	 parameter
		reg1 = 3'b000,
		reg2 = 3'b001,
		reg3 = 3'b010,
		reg4 = 3'b011,
		reg5 = 3'b100,
		reg6 = 3'b101,
		reg7 = 3'b110,
		reg8 = 3'b111;
		
	always@(Enable_write_ or Data_write_address_)
		if(Enable_write_ == 1)
			begin
				case(Data_write_address_)
					reg1: enabler = 8'b0000_0001;
					reg2: enabler = 8'b0000_0010;
					reg3: enabler = 8'b0000_0100;
					reg4: enabler = 8'b0000_1000;
					reg5: enabler = 8'b0001_0000;
					reg6: enabler = 8'b0010_0000;
					reg7: enabler = 8'b0100_0000;
					reg8: enabler = 8'b1000_0000;
					default: enabler = 8'b0000_0000;
				endcase
			end
		else if(!Enable_write_)
			enabler = 8'b0000_0000;
		

	 


endmodule
