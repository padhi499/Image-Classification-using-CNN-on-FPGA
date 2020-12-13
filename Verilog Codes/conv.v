`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2019 03:16:23 PM
// Design Name: 
// Module Name: conv
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


module conv #(parameter In_d_W=8, R=3, C=3, In_Add_W=4, Timeperiod=10)(
    input clk,clk_en,rst,clr,en_wr,en_rd,wr,en_MAC,en_MAC_out,   //wr=1 (Write), wr=0 (Read)
    input [(C*R*In_d_W)-1:0] A, //[71:0] A as 9*8=72
    input [(C*R*In_d_W)-1:0] B, //[71:0] B as 9*8=72
    output [((2*In_d_W)+2)-1:0] Y
    );
    
    wire [((2**In_Add_W)*In_d_W)-1:0] Wrow;
    wire [((2**In_Add_W)*In_d_W)-1:0] Wcol;
    wire [In_Add_W-1:0] addr_com;
    wire [In_d_W-1:0] din_r,din_c;
    
    generate
    genvar j;
    for(j=0;j<((2**In_Add_W)*In_d_W);j=j+In_d_W)
    begin
        if(j<R*C*In_d_W)
        begin
            assign Wrow[j+In_d_W-1:j]=A[j+In_d_W-1:j];
            assign Wcol[j+In_d_W-1:j]=B[j+In_d_W-1:j];
        end
                
        else if(j>=R*C*In_d_W)
        begin
            assign Wrow[j+In_d_W-1:j]='d0;
            assign Wcol[j+In_d_W-1:j]='d0;
        end
    end
    endgenerate
    
    c_counter_binary_0 common(
      .CLK(clk),    // input wire CLK
      .CE(clk_en),      // input wire CE
      .SCLR(clr),  // input wire SCLR
      .Q(addr_com)        // output wire [3 : 0] Q
    );
    
    mux_g #((In_d_W*(2**In_Add_W)),In_Add_W) MUXrow(.A(Wrow),.S(addr_com),.Y(din_r));
    
    mux_g #((In_d_W*(2**In_Add_W)),In_Add_W) MUXcol(.A(Wcol),.S(addr_com),.Y(din_c));   
    
    matrix_multiplier #(In_d_W,In_Add_W,R*C,Timeperiod) DUT(.clk(clk),.rst(rst),.clr(clr),.ena_r(en_wr),.ena_c(en_wr),.enb_r(en_rd),
    .enb_c(en_rd),.wea_r(wr),.wea_c(wr),.din_r(din_r),.din_c(din_c),.addra_r(addr_com),.addrb_r(addr_com),.addra_c(addr_com),
    .addrb_c(addr_com),.en_MAC(en_MAC),.en_MAC_out(en_MAC_out),.y(Y));
   
endmodule