`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2019 12:38:00 PM
// Design Name: 
// Module Name: ReLU
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


module ReLU #(parameter In_d_W=18)(
    input clk, clr, en_act, en_act_out,
    input signed [In_d_W-1:0] A,
    output reg  signed [In_d_W-1:0] Y
    );
    reg  signed [In_d_W-1:0] X;
    always@(posedge clk)
    begin
    if(clr==1)
        begin Y<=0;  X<=0; end
    else if(clr==0) begin
    case({en_act,en_act_out})
    2'b00:  Y<=Y; 
    2'b01:  Y<=X;
    2'b10:  begin 
                if(A<0) X<='d0;
                else if(A>=0)  X<=A;
             end
    2'b11:  begin
                if(A<0) X<='d0;
                else if(A>=0) X<=A;
                Y<=X;
             end
    endcase
    end
    end
endmodule
