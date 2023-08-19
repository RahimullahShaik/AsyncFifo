//verilog code for Fifomemory -DRAM

module fifomem #( parameter data_Size = 8, parameter address_Size = 5 ) (

		input w_Clk,							//write clock
		input w_Enable, 						//write enable is deasserted when the fifo is full logic is written in write block
		input [address_Size-1:0]w_Addr,			//address to be written in fifo
		input [address_Size-1:0]r_Addr,			//address to be read from fifo
		input fifo_Full,						//asserted when fifo is full
		input [data_Size-1:0]write_Data,		//data to be written in fifo write address
		output [data_Size-1:0]read_Data );		//data to be read from fifo read address

		//depth of fifo calculation in order to assign memory according to the depth 
		localparam fifo_depth = 1<<address_Size;
		
		reg [data_Size-1:0] mem[0:fifo_depth];
		
		//output data is continuosly being assigned to read block
		assign read_Data = mem[r_Addr];
		
		//write data is done only when fifo is not full and w_Enable is asserted 
		always@(posedge w_Clk)
			if(!fifo_Full && w_Enable)
				mem[w_Addr] <= write_Data;
			
endmodule
