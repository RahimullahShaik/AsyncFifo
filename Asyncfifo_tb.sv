//Test bench to test the FIFO design 
module Asyncfifo_tb #(parameter data_Size = 8, address_Size = 3);
        logic fifo_Full;  					//gets asserted when the FIFO is full
		logic fifo_Empty; 					// gets asserted when the FIFO is empty
		logic [data_Size-1:0]read_Data;  	//output data read from the FIFO by the receiver block
		logic [data_Size-1:0]write_Data;  	//input data to be written to the FIFO by the transmitter block
		logic w_Clk; 						    //Write clock, clock domain 1
		logic r_Clk;  					    //Read clock, clock domain 2
		logic w_Rst;       					//Write reset inorder to reset the write pointer 
		logic r_Rst; 	   					    //Read reset inorder to reset the read pointer 
		logic w_Inc;       					//To incremnet Write pointer 
		logic r_Inc;  	   					// To increment Read pointer 

	integer i,j;
//Instantiating the DUT						
Asyncfifo #(data_Size, address_Size) Asyncfifoo (
        .fifo_Full(fifo_Full),
        .fifo_Empty(fifo_Empty),
        .read_Data(read_Data),
        .write_Data(write_Data),
        .w_Clk(w_Clk),
        .r_Clk(r_Clk),
        .w_Rst(w_Rst),
        .r_Rst(r_Rst),
        .w_Inc(w_Inc),
        .r_Inc(r_Inc));

// instantiating write and read clocks
    
 always #5 w_Clk = ~w_Clk;
 always #10 r_Clk = ~r_Clk;

initial begin
    write_Data = 0;
    w_Clk = 1'b0;
    r_Clk = 1'b0;
    w_Inc = 1'b0;
    r_Inc = 1'b0;
end 
/*
//wrote the following tests to test if the data being written to the FIFO is being read properly
//Tested the Full and empty conditions, stopped writing data and reading data when they are empty and full respectively 
//Also checked if we are getting synchronized write and read pointers 
*/
initial begin 
    w_Rst = 1'b0;
    @(posedge w_Clk);
    w_Rst = 1'b1;
    for(i=0; i<15; i++) begin
        @(posedge w_Clk);
        if(fifo_Full!=1)begin
        w_Inc = 1'b1;
        write_Data = i;
        $display("Data %h is being written in the FIFO",write_Data);
        end
    end
    @(posedge w_Clk);
        w_Inc = 1'b0;
end
    
initial begin
    r_Rst = 1'b0;
    @(negedge r_Clk);
    r_Rst = 1'b1;
    for(j=0; j<15; j++) begin
        @(negedge r_Clk);
        if(fifo_Empty!=0)begin 
        r_Inc = 1'b1;
        $display("Data %h is being read from the FIFO",read_Data);
        end
    end
   
end
endmodule