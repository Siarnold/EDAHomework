`timescale 1us / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 10:56:01
// Design Name: 
// Module Name: keyboard_tb
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

module keyboard_tb;

reg clk;
reg [3:0] row;
wire [3:0] col;
wire [3:0] key_value;
reg reset;

keyboard U0( clk, reset, row, col, key_value );

initial
begin
    clk <= 1'b0;
    reset <= 1'b1;
    row <= 4'hf;
    
    //press 1 row = 1110 when col = 1110
    //long press
    #1500 row <= 4'b1110;//pressed
    #200000 row <= 4'hf;//col = 1110 scanning
    
    //press  tremble
    #3000 row <= 4'b1110;
    #500 row <= 4'hf;
    
    //press 4 normally
    #100000 row <= 4'b1110;
    wait( col == 4'b1110 ); row <= 4'hf;
    wait( col == 4'b1101 ); row <= 4'b1110;
    #50000 row <= 4'hf;
    
end

always #1000 clk <= ~clk;//the period of clk is 2000us

initial $monitor("clk=%b row=%b col=%b key_value=%b", clk, row, col, key_value);

endmodule
