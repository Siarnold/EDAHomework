`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 23:26:57
// Design Name: 
// Module Name: seg_decoder
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


module seg_decoder(
    in,
    out,    
    );

//describe
input [3:0] in;
output reg [6:0] out;

//always
always@ ( in ) begin
    case( in )
        4'b0000: out = 7'b1000000;
        4'b0001: out = 7'b1111001;
        4'b0010: out = 7'b0100100;
        4'b0011: out = 7'b0110000;
        4'b0100: out = 7'b0011001;
        4'b0101: out = 7'b0010010;
        4'b0110: out = 7'b0000011;
        4'b0111: out = 7'b1111000;
        4'b1000: out = 7'b0000000;
        4'b1001: out = 7'b0010000;
        default: out = 7'b1111111;
    endcase
end
endmodule
