`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 12:32:33 PM
// Design Name: 
// Module Name: matrix_multiplier
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

module matrix_multiplier #(parameter In_W=8,In_D_Add_W=4,In_Items=6,Timeperiod=10)(
input clk,
input rst,
input clr,
input ena_r,ena_c,
input enb_r,enb_c,
input wea_r,wea_c,
//input web_r,web_c,
input signed [In_W-1:0] din_r,din_c,
input [In_D_Add_W-1:0] addra_r,addrb_r,addra_c,addrb_c,
input en_MAC,
input en_MAC_out,
output signed [((2*In_W)+2)-1:0] y );

wire [In_D_Add_W-1:0] addr_r,addr_c;
wire [In_W-1:0] row_in,col_in;

blk_mem_gen_0 ROW (
  .clka(clk),    // input wire clka
  .ena(ena_r),      // input wire ena
  .wea(wea_r),      // input wire [0 : 0] wea
  .addra(addra_r),  // input wire [3 : 0] addra
  .dina(din_r),    // input wire [7 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(enb_r),      // input wire enb
  .addrb(addrb_r),  // input wire [3 : 0] addrb
  .doutb(row_in)  // output wire [7 : 0] doutb
);

blk_mem_gen_0 COLUMN (
  .clka(clk),    // input wire clka
  .ena(ena_c),      // input wire ena
  .wea(wea_c),      // input wire [0 : 0] wea
  .addra(addra_c),  // input wire [3 : 0] addra
  .dina(din_c),    // input wire [7 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(enb_c),      // input wire enb
  .addrb(addrb_c),  // input wire [3 : 0] addrb
  .doutb(col_in)  // output wire [7 : 0] doutb
);

mac_generic #(In_W) MAC(.clk(clk),.rst(rst),.clr(clr),.en_MAC(en_MAC),.A(row_in),.B(col_in),.en_MAC_out(en_MAC_out),.Y(y)); 

endmodule