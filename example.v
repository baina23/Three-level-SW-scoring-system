`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/13 14:51:55
// Design Name: 
// Module Name: example
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module example(clk, rst, score);
parameter DATA_WIDTH = 4;
parameter BUF_SIZE = 101;
parameter BUF_WIDTH = 7;
parameter IN_SIZE = 252;
parameter IN_WIDTH = 8;

input       clk;
input       rst;
output[9:0] score;         

reg buf1_empty, buf2_empty;
reg[DATA_WIDTH-1:0] buf1_out, buf2_out;
wire rd1_en, rd2_en;  
reg[IN_SIZE-1:0] memreg [0:BUF_SIZE-1];
reg[BUF_WIDTH-1:0] ptr_depth;
reg[IN_WIDTH-1:0] ptr_width;
reg  buf_en, buf_finish;    
reg[IN_SIZE-1:0] current;
wire[IN_SIZE-1:0] REF_shift,READ_shift;

    SW_top SW(.clk(clk),.rst(rst),.buf1_empty(buf1_empty),.buf2_empty(buf2_empty),.buf1_out(buf1_out),.buf2_out(buf2_out),.rd1_en(rd1_en),.rd2_en(rd2_en),.score(score));

assign READ_shift = current << ptr_width;
assign REF_shift = memreg[0] << ptr_width;

always@(negedge rd1_en or posedge buf_finish)
begin    
   if(!ptr_depth)
        buf_en = 0;
   else if(!rd1_en)
        begin
        buf_en = 1;
        current = memreg[ptr_depth];
        end
   else if(buf_finish)
        buf_en = 0;
end

always@(posedge clk)
begin
    if(!rst)
        begin
        ptr_depth <= 1;
        ptr_width <= 0;
        buf1_empty <= 1;
        buf2_empty <= 1;
        end
    else
    begin
        
        if(ptr_depth)
        begin
        buf1_empty <= 0;
        buf2_empty <= 0;
        end
        else
        begin
        buf1_empty <= 1;
        buf2_empty <= 1;
        end
        
        if(buf_en)
        begin
            buf_finish <= 0;
            if(ptr_width < IN_SIZE - 1)
            begin
                ptr_width <= ptr_width + 4;
                buf1_out <= REF_shift[IN_SIZE-1:IN_SIZE-4];
                buf2_out <= READ_shift[IN_SIZE-1:IN_SIZE-4];
            end
            else
            begin
                ptr_width <= 0;
                buf_finish <= 1;
               
                if(ptr_depth < BUF_SIZE)
                    ptr_depth <= ptr_depth + 1;
                else
                    ptr_depth <= 0;

            end
        end
        else
            begin              
                ptr_width <= ptr_width;
                ptr_depth <= ptr_depth;
                buf_finish <= buf_finish;             
                
            end
    end
end


initial
begin
  $readmemb("C:/Users/yujie/Desktop/zyj_work/gene_mismatch3/gene_mismatch3/error.txt",memreg);
end
    
    
endmodule
