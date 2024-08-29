/////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module tb_synch_fifo;
reg [15:0] data_in;
reg clk;
reg rst;
wire[15:0] data_out;
reg rd_en;
reg wr_en;
wire full_flag;
wire empty_flag;
wire [5:0] fifo_count;
 

////instantiating the module
Synch_FIFO uut(.clk(clk),
.rst(rst),
.rd_en(rd_en),
.wr_en(wr_en),
.data_out(data_out),
.data_in(data_in),
.full_flag(full_flag),
               .empty_flag(empty_flag),
               .fifo_count(fifo_count)
              );

////generating the clock using forever
initial begin
clk = 0;
forever #10 clk = ~clk;
end

////applying the input for testing
initial
begin
 ///initialising the signals
 
 rst = 1;

 
 #10
 rst = 0 ;
wr_en = 1;
rd_en = 0;
data_in = 68 ;
 
 #10 
  rst = 0;
wr_en = 1;
 rd_en = 0;
data_in = 123 ;
  
  #10 
  rst = 0;
wr_en = 1;
 rd_en = 0;
data_in = 53;
  
 #10
 wr_en = 1;
 rd_en = 1;
 data_in = 10'd9;
 
 #20 
  $finish;
 end
 
 ////monitoring the results
initial begin
  $monitor(" %d |clk = %b | rst = %b  | wr_en = %b  | rd_en = %b  | fifo_count = %d | data in =%d| full_flag = %b | empty_flag = %b | data_out = %d",
                 $time,clk, rst, wr_en,rd_en,fifo_count, data_in, full_flag, empty_flag, data_out);
    end
endmodule 

