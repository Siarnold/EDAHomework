`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/11 16:16:34
// Design Name: 
// Module Name: fm_top
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


module fm_top(
    clk,
    seg_sel, seg_out
);
input clk;//clk = 100MHz, in is measured signal
output wire [3:0] seg_sel;
output wire [6:0] seg_out;

//other variables
wire in;//256Hz
wire clk0; //1Hz
wire clk_seg;//200Hz
wire [3:0] d2, d1, d0;

//call modules
timedivider
DIV0(clk, 50000000, clk0),//1Hz
DIV_SEG(clk, 250000, clk_seg),//200Hz
DIV_IN(clk, 195312, in);//256Hz
fq_cnt FC0(clk0, in, d2, d1, d0);
segments SEG0(clk_seg, 0, d2, d1, d0, seg_sel, seg_out);

endmodule
