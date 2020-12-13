`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 12:02:06 PM
// Design Name: 
// Module Name: mac_generic
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

module mac_generic #(parameter I_W=8)(
    input clk,
    input rst,
    input clr,
    input en_MAC,
    input signed [I_W-1:0] A,
    input signed [I_W-1:0] B,
    input en_MAC_out,
    output reg signed [(2*I_W)+1:0] Y
    );
    reg [(2*I_W)+1:0] temp1,temp2;
    always@(posedge clk)
    begin
    if(rst==0) begin temp1<=0; temp2<=0; Y<=0; end
    
    else if(clr==1) begin temp1<=0; temp2<=0; Y<=0; end
    
    else if(rst==1 & clr==0) begin
    case({en_MAC,en_MAC_out})
    2'b00: begin temp1<=0; temp2<=temp2+temp1; Y<=0; end
    2'b01: begin temp1<=0; temp2<=temp2+temp1; Y<=temp2; end
    2'b10: begin temp1<=A*B;  temp2<=temp2+temp1; Y<=0; end
    2'b11: begin temp1<=A*B;  temp2<=temp2+temp1; Y<=temp2; end
    endcase
    end
    end
endmodule
