`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 14:54:24
// Design Name: 
// Module Name: Data_arrange
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


module Data_arrange (clk, data_in, buf_empty, rst, PE_empty, rd_en, data_out, arrange_ready);
parameter IN_WIDTH = 4;
parameter OUT_WIDTH = 252;
parameter PE_NUM = 4;

input                        clk;
input [IN_WIDTH - 1:0]       data_in;
input                        buf_empty;// 0:not empty,   1:empty 
input                        rst;
input                        PE_empty;// 0:inavailable,  1:available  
output                       rd_en;
output[OUT_WIDTH - 1:0]      data_out;
output                       arrange_ready;// 0:output unready,  1:output ready

reg[OUT_WIDTH - 1:0]         data_out;
reg                          arrange_ready;
reg[OUT_WIDTH - 1:0]         DATA;
reg[7:0]                     count;
wire                          rd_en;
wire[OUT_WIDTH - 1:0]        DATA_SHIFT;

assign DATA_SHIFT = DATA << IN_WIDTH;
assign rd_en = (rst && (count < OUT_WIDTH + 1))? 0:1;

always@(posedge clk)
begin
    if (!rst)            
        begin        
            DATA <= 0;
            count <= 0;           
        end           
    else begin
            if (buf_empty)
            begin;
                DATA <= 0;
                count <= 0;
            end              
            else if (!buf_empty && count < OUT_WIDTH + 1 )
            begin
                DATA <= {DATA_SHIFT[OUT_WIDTH - 1:IN_WIDTH],data_in};
                if(count == 0)
                    count <= count + 1;
                else
                    count <= count + IN_WIDTH;
            end
            else
            begin 
                data_out <= DATA;
                if(arrange_ready)
                    begin                       
                        DATA <= 0;
                        count <= 0;                    
                    end
                else if (!arrange_ready)
                    begin
                        DATA <= DATA;
                        count <= count;    
                    end
             end
       end
end

always@(posedge clk)
begin
    if(!rst)
        arrange_ready <= 0;
    else
        if(PE_empty && count >= OUT_WIDTH + 1 )
            arrange_ready <= 1;
        else arrange_ready <= 0;
end
endmodule
