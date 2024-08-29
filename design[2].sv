module Synch_FIFO(input clk,
input rst,
input [15:0] data_in,
output full_flag,
output empty_flag,
output reg [5:0] fifo_count,
input rd_en,
input wr_en  ,
                  output reg [15:0] data_out
 );
    
reg [15:0] mem [63:0];
reg [5:0] rd_ptr;
 reg [5:0] wr_ptr;

///// updating the full and empty flag

  assign full_flag = (fifo_count == 10'd64);
  assign empty_flag = (fifo_count == 10'd0);


////updating the fifo count value based on rd_en and wr_en
  always@(posedge clk or rst )
begin
if (rst)
fifo_count <= 0;
else if (rd_en && ~empty_flag)
fifo_count <= fifo_count - 1;
else if(wr_en && ~full_flag)
fifo_count <= fifo_count + 1;
else if (rd_en && ~empty_flag && wr_en && ~full_flag)
fifo_count <=  fifo_count;
end

////updating the rd_ptr and wr_ptr value

always@(posedge clk or rst)
if (rst) begin
rd_ptr <= 0;
wr_ptr <= 0;
end
else 
begin
  if (rd_en)
    rd_ptr <= rd_ptr + 1;
 if (wr_en)
    wr_ptr <= wr_ptr + 1;
 
end

///taking the data in
  always@(posedge clk or rst)begin
 if (wr_en && ~full_flag)
mem[wr_ptr] <= data_in;

end

////updating the data out
  always@(posedge clk or rst) begin
if(rst)
data_out <= 0;
else if (rd_en && ~empty_flag)
data_out <= mem[rd_ptr];
end-

endmodule

