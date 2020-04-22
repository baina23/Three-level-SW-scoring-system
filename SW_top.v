`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/25 18:54:14
// Design Name: 
// Module Name: SW_top
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


module SW_top(clk,rst,buf1_empty,buf2_empty,buf1_out,buf2_out,rd1_en,rd2_en,score);
parameter BUF_WIDTH = 4;
parameter TOTAL_WIDTH = 252;
parameter PE_WIDTH = 72;
parameter PE_SOLID = 60;

input                          clk;
input                          rst;
input                          buf1_empty;
input                          buf2_empty;
input[BUF_WIDTH - 1:0]         buf1_out;
input[BUF_WIDTH - 1:0]         buf2_out;   
output                         rd1_en;
output                         rd2_en;
output[9:0]                    score;

reg                           rst_DA, rst_PE, rst_SC;
reg                           PE_empty;
wire[TOTAL_WIDTH - 1:0]       REF,READ;
wire[TOTAL_WIDTH - 1:0]       ref,read;
reg[PE_WIDTH - 1:0]           sub_ref1, sub_ref2, sub_ref3, sub_ref4, sub_read1, sub_read2, sub_read3, sub_read4;                  
wire                          readyout1, readyout2; 
wire[6:0]                     Max1, Max2, Max3, Max4;
reg[6:0]                      max1, max2, max3, max4;
wire[12:0]                    Loc1, Loc2, Loc3, Loc4;
reg[12:0]                     loc1, loc2, loc3, loc4;
wire                          SC_finish;
wire                          PE1_finish, PE2_finish, PE3_finish, PE4_finish;
    

Data_arrange DA_ref(.clk(clk), .data_in(buf1_out), .buf_empty(buf1_empty), .rst(rst_DA), .PE_empty(PE_empty), .rd_en(rd1_en), .data_out(ref), .arrange_ready(readyout1));
Data_arrange DA_read(.clk(clk), .data_in(buf2_out), .buf_empty(buf2_empty), .rst(rst_DA), .PE_empty(PE_empty), .rd_en(rd2_en), .data_out(read), .arrange_ready(readyout2));

SW1 PE1(.clk(clk),.rst(rst_PE),.ref(sub_ref1),.read(sub_read1),.max(Max1),.loc(Loc1),.finish(PE1_finish));
SW PE2(.clk(clk),.rst(rst_PE),.ref(sub_ref2),.read(sub_read2),.max(Max2),.loc(Loc2),.finish(PE2_finish));
SW PE3(.clk(clk),.rst(rst_PE),.ref(sub_ref3),.read(sub_read3),.max(Max3),.loc(Loc3),.finish(PE3_finish));
SW PE4(.clk(clk),.rst(rst_PE),.ref(sub_ref4),.read(sub_read4),.max(Max4),.loc(Loc4),.finish(PE4_finish));

Score_calculate SC(.clk(clk),.rst(rst_SC),.max1(max1),.max2(max2),.max3(max3),.max4(max4),.loc1(loc1),.loc2(loc2),.loc3(loc3),.loc4(loc4),.score(score),.finish(SC_finish));

assign REF = (readyout1)? ref : REF;
assign READ = (readyout2)? read : READ; 

always @(posedge clk)
begin
    if(!rst)
        begin
        rst_DA <= 0;
        end
    else
        begin
        rst_DA <= 1;
        end
end

always@(posedge readyout1 or posedge PE1_finish)
begin
    if(readyout1)
        PE_empty = 0;
    else if(PE1_finish)
        PE_empty = 1;
end

always@(posedge clk)
begin
   if(rst)
        if(!PE_empty)
        begin
            rst_PE <= 1;
            sub_ref1 <= REF[TOTAL_WIDTH - 1: TOTAL_WIDTH - PE_WIDTH];
            sub_ref2 <= REF[TOTAL_WIDTH - PE_SOLID - 1: TOTAL_WIDTH - PE_WIDTH - PE_SOLID];
            sub_ref3 <= REF[TOTAL_WIDTH - 2*PE_SOLID - 1: TOTAL_WIDTH - PE_WIDTH - 2*PE_SOLID];
            sub_ref4 <= REF[TOTAL_WIDTH - 3*PE_SOLID - 1: TOTAL_WIDTH - PE_WIDTH - 3*PE_SOLID];
            sub_read1 <= READ[TOTAL_WIDTH - 1: TOTAL_WIDTH - PE_WIDTH];
            sub_read2 <= READ[TOTAL_WIDTH - PE_SOLID - 1: TOTAL_WIDTH - PE_WIDTH - PE_SOLID];
            sub_read3 <= READ[TOTAL_WIDTH - 2*PE_SOLID - 1: TOTAL_WIDTH - PE_WIDTH - 2*PE_SOLID];
            sub_read4 <= READ[TOTAL_WIDTH - 3*PE_SOLID - 1: TOTAL_WIDTH - PE_WIDTH - 3*PE_SOLID];
        end
        else
        begin
            rst_PE <= 0;    
        end
    else if(!rst)
        begin
        rst_PE <= 0;
        sub_ref1 <= 0; sub_ref2 <= 0; sub_ref3 <= 0; sub_ref4 <= 0;
        sub_read1 <= 0;sub_read2 <= 0;sub_read3 <= 0;sub_read4 <= 0;
        end       
end 

always@(posedge PE1_finish or posedge SC_finish)
begin  
    if(PE1_finish && rst)
        rst_SC = 1;
    else if(SC_finish || !rst)
        rst_SC = 0;
end

always@(posedge rst_SC)
begin
        max1 <= Max1;loc1 <= Loc1;
        max2 <= Max2;loc2 <= Loc2;
        max3 <= Max3;loc3 <= Loc3;
        max4 <= Max4;loc4 <= Loc4;
end
   
    
endmodule