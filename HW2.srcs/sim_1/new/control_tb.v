`timescale 1us / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/21 00:27:05
// Design Name: 
// Module Name: control_tb
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

module control_tb;

//declare variables
reg clk;
reg rst;
reg [3:0] val;
wire shutdown;
wire [3:0] d3, d2, d1, d0;

//call control
control U0( clk, rst, val, shutdown, d3, d2, d1, d0 );

initial
begin
    clk <= 1'b0; rst <= 1'b1;
    #3000 rst <= 1'b0;
    #3000 rst <= 1'b1;
    val <= 15; #5000
    
    //press STT that is (0,4)
    val <= 10; #1000 val <= 15; #10000
//    #1500 row = 4'b1110;
//    wait(col == 4'b1110);//scan1
//    row = 4'hf;//scan1,2,3
//    wait(col == 4'b0111);//scan4
//    row = 4'b1110;//select
//    #10000 row = 4'hf;   
      
    //press 1 that is (0,0)
    val <= 1; #1000 val <= 15; #10000  
    //clr
    val <= 12; #1000 val <= 15; #10000
    //press 3
    val <= 3; #1000 val <= 15; #10000 
    //press AFM that is (1,4)
    val <= 11; #1000 val <= 15;

end

always #100 clk <= ~clk;//200us * 5 = 1000us = 1ms

initial $monitor( "clk=%b rst=%b val=%b shutdown=%b d3=%b d2=%b d1=%b d0=%b",clk,rst,val,shutdown,d3,d2,d1,d0);

endmodule
