`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2019 01:35:53 PM
// Design Name: 
// Module Name: ReLU_Activation
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

module ReLU_Activation #(parameter In_d_W=18,R=3,C=3) ( //
    input clk,clr,en_act,en_act_out,
    input [(In_d_W * R * C)-1:0] X,
    output [(In_d_W * R * C)-1:0] Z
    );
    
    wire [In_d_W-1:0] B [0:R*C-1];
    wire [In_d_W-1:0] D [0:R*C-1];
    
    generate
    genvar i;
    for(i=0; i<R*C; i=i+1)
        begin
            assign B[i]=X[(In_d_W*(i+1))-1:In_d_W*i];
        end
    endgenerate
    
    generate
    genvar j;
    for(j=0; j<R*C; j=j+1)
    begin
        ReLU #(In_d_W) relu(.clk(clk),.clr(clr),.en_act(en_act),.en_act_out(en_act_out),.A(B[j]),.Y(D[j]));
    end
    endgenerate
    
    generate
    genvar k;
    for(k=0; k<R*C; k=k+1)
    begin
        assign Z[(In_d_W*(k+1))-1 : In_d_W*k]=D[k];
    end
    endgenerate
    
endmodule
