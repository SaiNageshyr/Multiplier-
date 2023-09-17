`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 10:37:19 PM
// Design Name: 
// Module Name: multiplier_8
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


module multiplier_8(multicand,multiplier,product);
parameter MULTICAND_WID = 8;
parameter MULTIPLIER_WID = 8;
    
    input [MULTICAND_WID-1:0] multicand;
    input [MULTIPLIER_WID-1:0] multiplier;
    output [(MULTICAND_WID + MULTIPLIER_WID - 1):0] product;
    
    wire [MULTICAND_WID - 1:0] multicand_tmp [MULTIPLIER_WID-1:0];
    wire [MULTICAND_WID - 1:0] product_tmp [MULTIPLIER_WID-1:0];
    wire [MULTIPLIER_WID -1:0] carry_tmp;

    genvar i, j;
    generate 
  
     for(j = 0; j < MULTIPLIER_WID; j = j + 1) begin: for_loop_j
     assign multicand_tmp[j] =  multicand & {MULTICAND_WID{multiplier[j]}};
     end
     
     assign product_tmp[0] = multicand_tmp[0];
     assign carry_tmp[0] = 1'b0;
     assign product[0] = product_tmp[0][0];

     for(i = 1; i < MULTIPLIER_WID; i = i + 1) begin: for_loop_i
     cla_8  add1 (
       
         .sum(product_tmp[i]),
         .cout(carry_tmp[i]),
     
       .cin(1'b0),
         .a(multicand_tmp[i]),
         .b({carry_tmp[i-1],product_tmp[i-1][7-:7]}));
     assign product[i] = product_tmp[i][0];
     end 
     assign product[(MULTIPLIER_WID+MULTIPLIER_WID-1):MULTIPLIER_WID] = {carry_tmp[MULTIPLIER_WID-1],product_tmp[MULTIPLIER_WID-1][7-:7]};
    endgenerate
endmodule
