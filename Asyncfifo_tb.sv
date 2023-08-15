//Test bench to test the FIFO design 
module Asyncfifo_tb #(parameter data_Size = 8, address_Size = 5);
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

	integer i;
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

/*initial begin
    w_Rst = 1'b0;
    @(posedge w_Clk);
    w_Rst = 1'b1;
    @(posedge w_Clk);
    for(i=0; i<128; i++)begin 
        if(i%2)
            w_Inc = 1'b1;
        else 
            w_Inc = 1'b0;
        @(posedge w_Clk);
        if(w_Inc==1)begin 
            if(fifo_Full!=1'b1) begin
                write_Data = $urandom();
                $display("Data %h is being written in the FIFO",write_Data);
            end
        end
    end
end 
/*
initial begin 
    r_Rst = 1'b0;
    repeat(2)@(posedge r_Clk);
    r_Rst = 1'b1;
    for(i=0; i<128; i++)begin 
        if(i%2)
            r_Inc = 1'b1;
        else 
            r_Inc = 1'b0;
        @(posedge r_Clk);
        if(r_Inc==1)begin 
            if(fifo_Empty!=1'b1) begin
                read_Data = $urandom();
                $display("Data %h is being read from the FIFO",read_Data);
            end
        end
    end 
    $finish;
end */
//$finish;


//test for single read and write 
initial begin 
    w_Rst = 1'b0;
    @(posedge w_Clk);
    w_Rst = 1'b1;
    @(posedge w_Clk);
    for(i=0; i<10; i++) begin
    w_Inc = 1'b1;
    write_Data = $random();
    $display("Data %h is being written in the FIFO",write_Data);
    @(posedge w_Clk);
    w_Inc = 1'b0;
    end
end
    /*@(posedge w_Clk);
    w_Inc = 1'b1;
    write_Data = $random();
    $display("Data %h is being written in the FIFO",write_Data);
    @(posedge w_Clk);
    w_Inc = 1'b0;*/
initial begin
    r_Rst = 1'b0;
    @(posedge r_Clk);
    r_Rst = 1'b1;
    @(posedge r_Clk);
    r_Inc = 1'b1;
    //read_Data = $random();
    $display("Data %h is being read from the FIFO",read_Data);
    @(posedge r_Clk);
    r_Inc = 1'b0;
    @(posedge r_Clk);
    r_Inc = 1'b1;
    //read_Data = $random();
    $display("Data %h is being read from the FIFO",read_Data);
    @(posedge r_Clk);
    r_Inc = 1'b0;
end
endmodule