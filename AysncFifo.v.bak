
//Asynchronous FIFO Design 

module Asyncfifo #(parameter data_Size = 8, parameter address_Size = 5 ) (

			output fifo_Full,  					//gets asserted when the FIFO is full
			output fifo_Empty, 					// gets asserted when the FIFO is empty
			output [data_Size-1:0]read_Data,  	//output data read from the FIFO by the receiver block
			input [data_Size-1:0]write_Data,  	//input data to be written to the FIFO by the transmitter block
			input w_Clk, 						//Write clock, clock domain 1
			input r_Clk,  					//Read clock, clock domain 2
			input w_Rst,       					//Write reset inorder to reset the write pointer 
			input r_Rst, 	   					//Read reset inorder to reset the read pointer 
			input w_Inc,       					//To incremnet Write pointer 
			input r_Inc);  	   					// To increment Read pointer 

	wire [address_Size-1:0] w_Addr, r_Addr; 				//Read and write addresses
	wire [address_Size:0]w_Ptr, r_Ptr, wsync_Rptr, rsync_Wptr;  //the size of the read and write pointer is less than address because to distingush empty and full conditions 
																//wsync_Rptr, rsync_Wptr are the synchronised pointers to write and read blocks 
																
	//instantiating the synchronous blocks which synchronizes read and write pointers in different domians in order to compare them so that we can write and read the data in correct order 
	//and to prevent data loss or overwriting 
	//sync_r2w - synch read pointer with write pointer at write block, sync_w2r - sync write pointer with read pointer at read block 
	sync_r2w #(address_Size) sync_r2w(.wsync_Rptr(wsync_Rptr), .w_Clk(w_Clk), .w_Rst(w_Rst), .r_Ptr(r_Ptr));
	sync_w2r #(address_Size) sync_w2r(.rsync_Wptr(rsync_Wptr), .r_Clk(r_Clk), .r_Rst(r_Rst), .w_Ptr(w_Ptr));
	
	//instantiating the memory block DRAM from where we can read and write data 
	fifomem #(data_Size, address_Size) fifomem(.read_Data(read_Data), .write_Data(write_Data), .w_Clk(w_Clk), .w_Enable(w_Inc), .w_Addr(w_Addr), .r_Addr(r_Addr), .fifo_Full(fifo_Full));

	//instantiating wirte and read blocks which contains the logic for read and write pointers handling write and read requests
	FIFO_Empty #(address_Size) rptr_Empty(.r_Addr(r_Addr), .r_Clk(r_Clk), .r_Inc(r_Inc), .r_Ptr(r_Ptr), .r_Rst(r_Rst), .fifo_Empty(fifo_Empty), .rsync_Wptr(rsync_Wptr));
	FIFO_Full #(address_Size) wptr_Full(.w_Addr(w_Addr), .w_Clk(w_Clk), .w_Inc(w_Inc), .w_Ptr(w_Ptr), .w_Rst(w_Rst), .fifo_Full(fifo_Full), .wsync_Rptr(wsync_Rptr));


endmodule 
			