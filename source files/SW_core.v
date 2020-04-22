`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/19 15:26:54
// Design Name: 
// Module Name: SW_core
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


module SW_core(
input[5:0] seq,
input[5:0] targ,
input clk,
input rst,

input[6:0] f00,
input[6:0] f01,
input[6:0] f02,
input[6:0] f03,
input[6:0] f10,
input[6:0] f20,
input[6:0] f30,

output reg[6:0] f11,
output reg[6:0] f12,
output reg[6:0] f13,
output reg[6:0] f21,
output reg[6:0] f22,
output reg[6:0] f23,
output reg[6:0] f31,
output reg[6:0] f32,
output reg[6:0] f33
    );
parameter w = 1;
parameter s = 2; 
parameter l = 4;
wire[2:0] s11, s12, s13, s21, s22, s23, s31, s32, s33;
wire[6:0] p110, p111, p112;
wire[6:0] p120, p121, p122, p123, p124;
wire[6:0] p210, p211, p212, p213, p214;
wire[6:0] p130, p131, p132, p133, p134, p135, p136;
wire[6:0] p310, p311, p312, p313, p314, p315, p316;
wire[6:0] p220, p221, p222;
wire[6:0] p230, p231, p232, p233, p234; 
wire[6:0] p320, p321, p322, p323, p324;  
wire[6:0] p330, p331, p332;
reg[6:0] F11,F12,F13,F21,F31;
reg[6:0] F22,F23,F32,F33;
reg[1:0] state;

assign s33 = (seq[1:0]==targ[1:0])? 3'b100:3'b000;
assign s32 = (seq[1:0]==targ[3:2])? 3'b100:3'b000;
assign s31 = (seq[1:0]==targ[5:4])? 3'b100:3'b000;
assign s23 = (seq[3:2]==targ[1:0])? 3'b100:3'b000;
assign s22 = (seq[3:2]==targ[3:2])? 3'b100:3'b000;
assign s21 = (seq[3:2]==targ[5:4])? 3'b100:3'b000;
assign s13 = (seq[5:4]==targ[1:0])? 3'b100:3'b000;
assign s12 = (seq[5:4]==targ[3:2])? 3'b100:3'b000;
assign s11 = (seq[5:4]==targ[5:4])? 3'b100:3'b000;

always@(posedge clk)
begin
    if(!rst)
        begin            
            state <= 0;
        end
    else 
        case(state)
            2'b00:begin
                    state <= state + 1;
                  end                
            2'b01:begin
                   f11 <= F11;f12 <= F12;f13 <= F13;
                   f21 <= F21;f31 <= F31;
                    state <= state + 1;
                  end
            2'b10:begin
                    f22 <= F22;f23 <= F23;
                    f32 <= F32;f33 <= F33;
                    state <= 0;
                   end
            default:begin
                        state <= 0;
                    end
         endcase
end

//f11
assign p110 = f00 + s11 - s;
assign p111 = f01 - w;
assign p112 = f10 - w;
always@(p110 or p111 or p112)
begin
  if(p110 >= p111) F11 = p110; else F11 = p111;
  if(p112 >= F11) F11 = p112; 
  if(l >= F11) F11 = l;
end

//f12
assign p120 = f01 + s12 - s;
assign p121 = f00 + s11 - w - s;
assign p122 = f10 - 2*w;
assign p123 = f02 - w;
assign p124 = f01 - 2*w;
always@(p120 or p121 or p122 or p123 or p124)
begin
  if(p120 >= p121) F12 = p120; else F12 = p121;
  if(p122 >= F12) F12 = p122;
  if(p123 >= F12) F12 = p123;
  if(p124 >= F12) F12 = p124;
  if(l >= F12) F12 = l;
end

//f21
assign p210 = f10 + s21 - s;
assign p211 = f00 + s11 - w - s;
assign p212 = f01 - 2*w;
assign p213 = f20 - w;
assign p214 = f10 - 2*w;
always@(p210 or p211 or p212 or p213 or p214)
begin
  if(p210 >= p211) F21 = p210; else F21 = p211;
  if(p212 >= F21) F21 = p212;
  if(p213 >= F21) F21 = p213;
  if(p214 >= F21) F21 = p214;
  if(l >= F21) F21 = l;
end

//f13
assign p130 = f02 + s13 - s;
assign p131 = f01 + s12 - w - s;
assign p132 = f00 + s11 - 2*w - s;
assign p133 = f10 - 3*w;
assign p134 = f03 - w;
assign p135 = f02 - 2*w;
assign p136 = f01 - 3*w;
always@(p130 or p131 or p132 or p133 or p134 or p135 or p136)
begin
  if(p130 >= p131) F13 = p130; else F13 = p131;
  if(p132 >= F13) F13 = p132;
  if(p133 >= F13) F13 = p133;
  if(p134 >= F13) F13 = p134;
  if(p135 >= F13) F13 = p135;
  if(p136 >= F13) F13 = p136;
  if(l >= F13) F13 = l;
end

//f31
assign p310 = f20 + s31 - s;
assign p311 = f30 - w;
assign p312 = f10 + s21 - w - s;
assign p313 = f00 + s11 - 2*w - s;
assign p314 = f01 - 3*w;
assign p315 = f20 - 2*w;
assign p316 = f10 - 3*w;
always@(p310 or p311 or p312 or p313 or p314 or p315 or p316)
begin
  if(p310 >= p311) F31 = p310; else F31 = p311;
  if(p312 >= F31) F31 = p312;
  if(p313 >= F31) F31 = p313;
  if(p314 >= F31) F31 = p314;
  if(p315 >= F31) F31 = p315;
  if(p316 >= F31) F31 = p316;
  if(l >= F31) F31 = l;
end

//f22
assign p220 = f11 + s22 - s;
assign p221 = f12 - w;
assign p222 = f21 - w;
always@(p220 or p221 or p222)
begin
  if(p220 >= p221) F22 = p220; else F22 = p221;
  if(p222 >= F22) F22 = p222; 
  if(l >= F22) F22 = l;
end

//f23
assign p230 = f12 + s23 - s;
assign p231 = f11 + s22 - w - s;
assign p232 = f21 - 2*w;
assign p233 = f13 - w;
assign p234 = f12 - 2*w;
always@(p230 or p231 or p232 or p233 or p234)
begin
  if(p230 >= p231) F23 = p230; else F23 = p231;
  if(p232 >= F23) F23 = p232;
  if(p233 >= F23) F23 = p233;
  if(p234 >= F23) F23 = p234;
  if(l >= F23) F23 = l;
end

//f32
assign p320 = f21 + s32 - s;
assign p321 = f11 + s22 - w - s;
assign p322 = f12 - 2*w;
assign p323 = f31 - w;
assign p324 = f21 - 2*w;
always@(p320 or p321 or p322 or p323 or p324)
begin
  if(p320 >= p321) F32 = p320; else F32 = p321;
  if(p322 >= F32) F32 = p322;
  if(p323 >= F32) F32 = p323;
  if(p324 >= F32) F32 = p324;
  if(l >= F32) F32 = l;
end

//f33
assign p330 = F22 + s33 - s;
assign p331 = F23 - w;
assign p332 = F32 - w;
always@(p330 or p331 or p332)
begin
  if(p330 >= p331) F33 = p330; else F33 = p331;
  if(p332 >= F33) F33 = p332; 
  if(l >= F33) F33 = l;
end
 
//found max
//always@(f11 or f12 or f13 or f21 or f22 or f23 or f31 or f32 or f33)
//begin
//    if(f11 >= f12) max = f11;else max = f12;
//    if(f13 >= max) max = f13;
//    if(f21 >= max) max = f21;
//    if(f22 >= max) max = f22;
//    if(f23 >= max) max = f23;
//    if(f31 >= max) max = f31;
//    if(f32 >= max) max = f32;
//    if(f33 >= max) max = f33;   
//end


   
endmodule
