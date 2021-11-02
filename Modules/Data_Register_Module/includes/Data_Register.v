module Data_Register(
	input Enable_write,
	input [7:0]Data_write,
	output [7:0]Data
    );
	 
	 //inside
	 reg[7:0] data;
	 assign Data = data;
	 always@(*)
		if(Enable_write)
			data <= Data_write;


endmodule
