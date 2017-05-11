`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 09:58:14
// Design Name: 
// Module Name: keyboard
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


module keyboard(key_clk,rst_n,row,col,val); 

input  key_clk;        //系统时钟 
input  rst_n;          //复位键 
input  [3:0] row;       //矩阵键盘行 
output reg [3:0] col;        //矩阵键盘列 
output reg [3:0] val; 

 parameter NO_KEY_PRESSED=3'b000;//没有键按下 
 parameter SCAN_COL0     =3'b001;//扫描第 0 列 
 parameter SCAN_COL1     =3'b010;//扫描第 1 列 
 parameter SCAN_COL2     =3'b011;//扫描第 2 列 
 parameter SCAN_COL3     =3'b100;//扫描第 3 列 
 parameter KEY_PRESSED   =3'b101;//有键按下 
// parameter CHECK_1       =3'b110;//检查开始
// parameter CHECK_2       =3'b111;//检查结束
 
 reg [ 2: 0 ] current_state, next_state;  //现态和次态 
 reg key_pressed_flag;


 always @( posedge key_clk or negedge rst_n ) 
  if(!rst_n) 
   current_state <= NO_KEY_PRESSED; 
  else  
   current_state <= next_state; 

 always @ (*)   //表示该部分涉及到所有状态，根据条件转移状态 
 begin
 case (current_state) 
    NO_KEY_PRESSED:      //没有键按下                          
        if( row!=4'hf ) //检测到按下
            next_state = SCAN_COL0;
        else
            next_state=NO_KEY_PRESSED;       
    SCAN_COL0:           //扫描第 0 列 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else 
            next_state=SCAN_COL1;
    SCAN_COL1:          //扫描第 1 列 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else  
            next_state=SCAN_COL2; 
    SCAN_COL2:         //扫描第 2 列 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else  
            next_state=SCAN_COL3;
    SCAN_COL3:        //扫描第 3 列 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else  
            next_state=NO_KEY_PRESSED; 
    KEY_PRESSED:    //有按键按下 
        if( row!=4'hf )
            next_state = KEY_PRESSED;
        else
            next_state=NO_KEY_PRESSED;
endcase 
end
 

reg [3:0]col_val;   //列值 
reg [3:0]row_val;   //行值  
//根据次态，给相应的寄存器赋值 
always @(posedge key_clk or negedge rst_n) 
begin
    if(!rst_n)       //复位 
    begin 
        col <= 4'h0; 
        key_pressed_flag <= 0; 
    end 
    else
    begin 
    case (next_state) 
        NO_KEY_PRESSED: 
        begin 
            col <= 4'h0; 
            key_pressed_flag <= 0; 
        end 
        SCAN_COL0:       //扫描第 0 列 
            col <= 4'b1110; 
        SCAN_COL1:       //扫描第 1 列 
            col <= 4'b1101; 
        SCAN_COL2:       //扫描第 2 列 
            col <= 4'b1011; 
        SCAN_COL3:        //扫描第 3 列 
            col <= 4'b0111; 
        KEY_PRESSED:   //有按键按下 
        begin 
        col_val <= col; // 锁存列值 
        row_val <= row; // 锁存行值 
        key_pressed_flag <= 1;    // 置键盘按下标 
        end
    endcase  
    end
end

// 扫描行列值部分 开始
always @(posedge key_clk or negedge rst_n) 
begin
if(!rst_n) 
    val <= 15;
else 
    if( key_pressed_flag ) 
    case({col_val,row_val}) 
        8'b1110_1110:val<=1;
        8'b1110_1101:val<=4;
        8'b1110_1011:val<=7;
        8'b1110_0111:val<=0;    

        8'b1101_1110:val<=2;
        8'b1101_1101:val<=5;
        8'b1101_1011:val<=8;
        8'b1101_0111:val<=15; 

        8'b1011_1110:val<=3;
        8'b1011_1101:val<=6;
        8'b1011_1011:val<=9;
        8'b1011_0111:val<=14; 

        8'b0111_1110:val<=10;
        8'b0111_1101:val<=11;
        8'b0111_1011:val<=12;
        8'b0111_0111:val<=13; 
    endcase
    else
        val <= 15;
end

//always@ (val ) key_board_val = val;
//reg [1:0] flag;
//always@ ( posedge key_clk )
//begin
//    flag <= {flag[0],val};
//    if( flag[0] != flag[1] )
//        key_board_val <= flag[1];
//    else
//        key_board_val <= 15;
//end

endmodule