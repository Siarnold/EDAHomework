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

input  key_clk;        //ϵͳʱ�� 
input  rst_n;          //��λ�� 
input  [3:0] row;       //��������� 
output reg [3:0] col;        //��������� 
output reg [3:0] val; 

 parameter NO_KEY_PRESSED=3'b000;//û�м����� 
 parameter SCAN_COL0     =3'b001;//ɨ��� 0 �� 
 parameter SCAN_COL1     =3'b010;//ɨ��� 1 �� 
 parameter SCAN_COL2     =3'b011;//ɨ��� 2 �� 
 parameter SCAN_COL3     =3'b100;//ɨ��� 3 �� 
 parameter KEY_PRESSED   =3'b101;//�м����� 
// parameter CHECK_1       =3'b110;//��鿪ʼ
// parameter CHECK_2       =3'b111;//������
 
 reg [ 2: 0 ] current_state, next_state;  //��̬�ʹ�̬ 
 reg key_pressed_flag;


 always @( posedge key_clk or negedge rst_n ) 
  if(!rst_n) 
   current_state <= NO_KEY_PRESSED; 
  else  
   current_state <= next_state; 

 always @ (*)   //��ʾ�ò����漰������״̬����������ת��״̬ 
 begin
 case (current_state) 
    NO_KEY_PRESSED:      //û�м�����                          
        if( row!=4'hf ) //��⵽����
            next_state = SCAN_COL0;
        else
            next_state=NO_KEY_PRESSED;       
    SCAN_COL0:           //ɨ��� 0 �� 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else 
            next_state=SCAN_COL1;
    SCAN_COL1:          //ɨ��� 1 �� 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else  
            next_state=SCAN_COL2; 
    SCAN_COL2:         //ɨ��� 2 �� 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else  
            next_state=SCAN_COL3;
    SCAN_COL3:        //ɨ��� 3 �� 
        if( row!=4'hf ) 
            next_state=KEY_PRESSED; 
        else  
            next_state=NO_KEY_PRESSED; 
    KEY_PRESSED:    //�а������� 
        if( row!=4'hf )
            next_state = KEY_PRESSED;
        else
            next_state=NO_KEY_PRESSED;
endcase 
end
 

reg [3:0]col_val;   //��ֵ 
reg [3:0]row_val;   //��ֵ  
//���ݴ�̬������Ӧ�ļĴ�����ֵ 
always @(posedge key_clk or negedge rst_n) 
begin
    if(!rst_n)       //��λ 
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
        SCAN_COL0:       //ɨ��� 0 �� 
            col <= 4'b1110; 
        SCAN_COL1:       //ɨ��� 1 �� 
            col <= 4'b1101; 
        SCAN_COL2:       //ɨ��� 2 �� 
            col <= 4'b1011; 
        SCAN_COL3:        //ɨ��� 3 �� 
            col <= 4'b0111; 
        KEY_PRESSED:   //�а������� 
        begin 
        col_val <= col; // ������ֵ 
        row_val <= row; // ������ֵ 
        key_pressed_flag <= 1;    // �ü��̰��±� 
        end
    endcase  
    end
end

// ɨ������ֵ���� ��ʼ
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