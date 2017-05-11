`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 23:23:23
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
    clk,
    shutdown,
    d3, d2, d1, d0,
    sel_out,
    out
);
input clk;
input shutdown;
input [3:0] d3, d2, d1, d0;
output reg [3:0] sel_out;
output wire [6:0] out;


//other variables
reg [3:0] sel = 4'b1110;
reg [3:0] now;

//scan
always@ (posedge clk)//shift one digit
    sel <= {sel[2:0],sel[3]};


always@ (sel)
    case( sel )
        4'b1110: now = d3;
        4'b1101: now = d2;
        4'b1011: now = d1;
        4'b0111: now = d0;
        default: now = 4'hf;//for debugging
    endcase
    
seg_decoder U0( now, out );

always@ ( shutdown )
begin
    if( shutdown == 1'b1 ) sel_out <= 4'b1111;
    else sel_out <= sel;
end

endmodule
