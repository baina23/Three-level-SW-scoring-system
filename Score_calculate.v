`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 14:54:24
// Design Name: 
// Module Name: Score_calculate
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


module Score_calculate(clk,rst,max1,max2,max3,max4,loc1,loc2,loc3,loc4,score,finish);

input               clk;
input               rst;
input[6:0]          max1;
input[6:0]          max2;
input[6:0]          max3;
input[6:0]          max4;
input[12:0]         loc1;
input[12:0]         loc2;
input[12:0]         loc3;
input[12:0]         loc4;
output[9:0]         score;
output              finish;


wire[12:0]          loc0;
reg[12:0]           LOC1, LOC2, LOC3,LOC4;
reg [2:0]           state;
reg [6:0]           sum1, sum2, sum3, sum4;
reg[9:0]            score;
reg                 finish;

assign loc0 = 13'b0000001000000;

always@(posedge clk)        
begin
   if(!rst)
    begin
        score <= 0;
        state <= 0;
        finish <= 0;
      end
   else 
      begin   
        case(state)
        3'd0: 
            begin
            state <= state + 1;
            if (loc0 & loc1)
               begin
                sum1 <= 0;
                LOC1 <= loc1 & loc0;
               end
            else if (((loc0<<1)&loc1)||((loc0>>1)&loc1))
               begin
                sum1 <= 1;
                LOC1 <= ((loc0<<1)&loc1)|((loc0>>1)&loc1);
               end
            else if (((loc0<<2)&loc1)||((loc0>>2)&loc1))
               begin
                sum1 <= 2;
                LOC1 <= ((loc0<<2)&loc1)|((loc0>>2)&loc1);
               end
            else if (((loc0<<3)&loc1)||((loc0>>3)&loc1))
               begin
                sum1 <= 3;
                LOC1 <= ((loc0<<3)&loc1)|((loc0>>3)&loc1);
               end
            else if (((loc0<<4)&loc1)||((loc0>>4)&loc1))
               begin
                sum1 <= 4;
                LOC1 <= ((loc0<<4)&loc1)|((loc0>>4)&loc1);
               end
           else if (((loc0<<5)&loc1)||((loc0>>5)&loc1))
               begin
                sum1 <= 5;
                LOC1 <= ((loc0<<5)&loc1)|((loc0>>5)&loc1);
               end
           else if (((loc0<<6)&loc1)||((loc0>>6)&loc1))
               begin
                sum1 <= 6;
                LOC1 <= ((loc0<<6)&loc1)|((loc0>>6)&loc1);
               end                       
            else
                begin
                 sum1 <= 127;
                 LOC1 <= 13'd0; 
                end
            end
          
        3'd1:
            begin   
            state <= state + 1;
            if (LOC1 & loc2)
               begin
                sum2 <= 0;
                LOC2 <= loc2 & LOC1;
               end
            else if (((LOC1<<1)&loc2)||((LOC1>>1)&loc2))
               begin
                sum2 <= 1;
                LOC2 <= ((LOC1<<1)&loc2)|((LOC1>>1)&loc2);
               end
            else if (((LOC1<<2)&loc2)||((LOC1>>2)&loc2))
               begin
                sum2 <= 2;
                LOC2 <= ((LOC1<<2)&loc2)|((LOC1>>2)&loc2);
               end
            else if (((LOC1<<3)&loc2)||((LOC1>>3)&loc2))
               begin
                sum2 <= 3;
                LOC2 <= ((LOC1<<3)&loc2)|((LOC1>>3)&loc2);
               end
            else if (((LOC1<<4)&loc2)||((LOC1>>4)&loc2))
               begin
                sum2 <= 4;
                LOC2 <= ((LOC1<<4)&loc2)|((LOC1>>4)&loc2);
               end
            else if (((LOC1<<5)&loc2)||((LOC1>>5)&loc2))
               begin
                sum2 <= 5;
                LOC2 <= ((LOC1<<5)&loc2)|((LOC1>>5)&loc2);
               end
            else if (((LOC1<<6)&loc2)||((LOC1>>6)&loc2))
               begin
                sum2 <= 6;
                LOC2 <= ((LOC1<<6)&loc2)|((LOC1>>6)&loc2);
               end
            else
                begin
                 sum2 <= 127;
                 LOC2 <= 13'd0; 
                end
            end
       
        3'd2:
        begin   
            state <= state + 1;
            if (LOC2 & loc3)
               begin
                sum3 <= 0;
                LOC3 <= loc3 & LOC2;
               end
            else if (((LOC2<<1)&loc3)||((LOC2>>1)&loc3))
               begin
                sum3 <= 1;
                LOC3 <= ((LOC2<<1)&loc3)|((LOC2>>1)&loc3);
               end
            else if (((LOC2<<2)&loc3)||((LOC2>>2)&loc3))
               begin
                sum3 <= 2;
                LOC3 <= ((LOC2<<2)&loc3)|((LOC2>>2)&loc3);
               end
            else if (((LOC2<<3)&loc3)||((LOC2>>3)&loc3))
               begin
                sum3 <= 3;
                LOC3 <= ((LOC2<<3)&loc3)|((LOC2>>3)&loc3);
               end
            else if (((LOC2<<4)&loc3)||((LOC2>>4)&loc3))
               begin
                sum3 <= 4;
                LOC3 <= ((LOC2<<4)&loc3)|((LOC2>>4)&loc3);
               end
            else if (((LOC2<<5)&loc3)||((LOC2>>5)&loc3))
               begin
                sum3 <= 5;
                LOC3 <= ((LOC2<<5)&loc3)|((LOC2>>5)&loc3);
               end
            else if (((LOC2<<6)&loc3)||((LOC2>>6)&loc3))
               begin
                sum3 <= 6;
                LOC3 <= ((LOC2<<6)&loc3)|((LOC2>>6)&loc3);
               end
            else
                begin
                 sum3 <= 127;
                 LOC3 <= 13'd0; 
                end
            end
            
        3'd3:
        begin   
            state <= state + 1;
            if (LOC3 & loc4)
               begin
                sum4 <= 0;
                LOC4 <= loc4 & LOC3;
               end
            else if (((LOC3<<1)&loc4)||((LOC3>>1)&loc4))
               begin
                sum4 <= 1;
                LOC4 <= ((LOC3<<1)&loc4)|((LOC3>>1)&loc4);
               end
            else if (((LOC3<<2)&loc4)||((LOC3>>2)&loc4))
               begin
                sum4 <= 2;
                LOC4 <= ((LOC3<<2)&loc4)|((LOC3>>2)&loc4);
               end
            else if (((LOC3<<3)&loc4)||((LOC3>>3)&loc4))
               begin
                sum4 <= 3;
                LOC4 <= ((LOC3<<3)&loc4)|((LOC3>>3)&loc4);
               end
            else if (((LOC3<<4)&loc4)||((LOC3>>4)&loc4))
               begin
                sum4 <= 4;
                LOC4 <= ((LOC3<<4)&loc4)|((LOC3>>4)&loc4);
               end
            else if (((LOC3<<5)&loc4)||((LOC3>>5)&loc4))
               begin
                sum4 <= 5;
                LOC4 <= ((LOC3<<5)&loc4)|((LOC3>>5)&loc4);
               end
            else if (((LOC3<<6)&loc4)||((LOC3>>6)&loc4))
               begin
                sum4 <= 6;
                LOC4 <= ((LOC3<<6)&loc4)|((LOC3>>6)&loc4);
               end
            else
                begin
                 sum4 <= 127;
                 LOC4 <= 13'd0; 
                end
            end
    
         3'd4:
           begin
            state <= state + 1;
            score <= max1 + max2 + max3 + max4 - sum1 - sum2 - sum3 - sum4;                
           end    
           
         3'd5:
            begin
              finish <= 1;
              score <= score;
              state <= state;
            end
        default: state <= 0;         
       endcase
     end
 end 

endmodule
