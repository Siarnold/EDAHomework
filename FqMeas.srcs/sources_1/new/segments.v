`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/11 15:20:57
// Design Name: 
// Module Name: segments
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


module segments(
    clk, d3, d2, d1, d0,
    sel, out
);
 input clk;
 input [3:0] d3, d2, d1, d0;
 output reg [3:0] sel = 4'b1110;//select signal output
 output wire [6:0] out;//segments output
 
 //other variables
 reg [3:0] now;
 
 //scan
 always@ (posedge clk)//shift one digit
     sel <= {sel[2:0],sel[3]};
 
 always@ (sel)
     case( sel )
         4'b1110: now = d0;
         4'b1101: now = d1;
         4'b1011: now = d2;
         4'b0111: now = d3;
         default: now = 4'hf;//for debugging
     endcase
     
 seg_decoder SEG_D0( now, out );
 
endmodule
