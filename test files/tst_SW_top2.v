`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/07 20:52:38
// Design Name: 
// Module Name: tst_SW_top2
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


module tst_SW_top2();
reg clk;
reg rst;
reg buf1_empty;
reg buf2_empty;
reg [3:0] buf1_out;
reg [3:0] buf2_out;
reg [251:0] ref, read;
reg [251:0]memreg[0:100];
wire rd1_en, rd2_en;
wire [9:0] score;

SW_top SW(.clk(clk),.rst(rst),.buf1_empty(buf1_empty),.buf2_empty(buf2_empty),.buf1_out(buf1_out),.buf2_out(buf2_out),.rd1_en(rd1_en),.rd2_en(rd2_en),.score(score));

always #1 clk = ~clk;

integer i,j;
initial
begin
    clk = 0;
    rst = 0;
    $readmemb("C:/Users/yujie/Desktop/zyj_work/gene_mismatch3/gene_mismatch3/error.txt",memreg);
#5
    buf1_empty = 1; buf2_empty = 1;
    buf1_out = 0; buf2_out = 0;
#4
    rst = 1;
#4
    buf1_empty = 0; buf2_empty = 0;
    for(i = 0;i < 100;i = i+1)
        begin
        ref = memreg[0];
        read = memreg[i+1];

        for(j = 0;j < 63;j = j+1)
            begin
            buf1_out = ref[251: 248];
            buf2_out = read[251: 248];#2
            ref = ref << 4;
            read = read << 4;
            end
#6
    $display("%d",score);

        end
 #10
    buf1_empty = 1; buf2_empty = 1;
end

endmodule
