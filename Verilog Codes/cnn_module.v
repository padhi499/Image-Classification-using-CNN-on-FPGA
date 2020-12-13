`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2020 12:50:42 PM
// Design Name: 
// Module Name: cnn_module
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

module cnn_module #(parameter In_d_W=8, In_Add_W=4, R_N_Conv=5, C_N_Conv=5, R_F_Conv=3, C_F_Conv=3, P_Conv=0, S_Conv=1, 
    R_Pool_In=(((R_N_Conv+(2*P_Conv)-R_F_Conv)/S_Conv)+1), C_Pool_In=(((C_N_Conv+(2*P_Conv)-C_F_Conv)/S_Conv)+1), 
    R_Pool_Area=2, C_Pool_Area=2, P_Pool=0, S_Pool=1, Timeperiod=10) (
    input clk,rst,clr,wr,
    input en_clk,en_wr,en_rd,en_MAC,en_MAC_out,en_act,en_act_out,en_pool,en_pool_out,
    input [(C_N_Conv*R_N_Conv*In_d_W)-1:0] N, // [199:0] N
    input [(C_F_Conv*R_F_Conv*In_d_W)-1:0] F, // [71:0] F
    output [((((R_Pool_In+(2*P_Pool)-R_Pool_Area)/S_Pool)+1)*(((C_Pool_In+(2*P_Pool)-C_Pool_Area)/S_Pool)+1)*((2*In_d_W)+2))-1 : 0] Y 
    // [2*2*18-1:0]Y
    );
    //parameter R_Pool_In=(((R_N_Conv+(2*P_Conv)-R_F_Conv)/S_Conv)+1); //3
    //parameter C_Pool_In=(((C_N_Conv+(2*P_Conv)-C_F_Conv)/S_Conv)+1); //3
    parameter R_Conv_Out=R_Pool_In;
    parameter C_Conv_Out=C_Pool_In;
    parameter R_Pool_Out=(((R_Pool_In+(2*P_Pool)-R_Pool_Area)/S_Pool)+1); //2
    parameter C_Pool_Out=(((C_Pool_In+(2*P_Pool)-C_Pool_Area)/S_Pool)+1); //2
    parameter Out_d_W_Conv=((2*In_d_W)+2); //18
    parameter In_d_W_Pool=Out_d_W_Conv; //18
    wire [(R_Conv_Out * C_Conv_Out * Out_d_W_Conv)-1:0] W1; //[3*3*18-1:0] W1
    wire [(R_Pool_In * C_Pool_In * In_d_W_Pool)-1:0] W2; //[3*3*18-1:0] W2
    
    slide_window_conv #(In_d_W, In_Add_W, R_N_Conv, C_N_Conv, R_F_Conv, C_F_Conv, P_Conv, S_Conv, Timeperiod) SWC
    (.clk(clk),.clk_en(en_clk),.rst(rst),.clr(clr),.en_wr(en_wr),.en_rd(en_rd),.wr(wr),.en_MAC(en_MAC),.en_MAC_out(en_MAC_out),
    .N(N),.F(F),.Y(W1));
    
    ReLU_Activation #(Out_d_W_Conv,R_Conv_Out,C_Conv_Out) RA (.clk(clk),.clr(clr),.en_act(en_act),.en_act_out(en_act_out),.X(W1),.Z(W2));
    
    max_pooling #(In_d_W_Pool,R_Pool_In,C_Pool_In,R_Pool_Area,C_Pool_Area,P_Pool,S_Pool,Timeperiod) MP (.clk(clk),.rst(rst),
    .clr(clr),.en_pool(en_pool),.en_pool_out(en_pool_out),.N(W2),.Y(Y));
    
endmodule
