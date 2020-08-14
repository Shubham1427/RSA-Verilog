`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2019 22:04:54
// Design Name: 
// Module Name: tb
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


module tb;

reg [15:0] ms;
reg clk;
wire [15:0] ci;
reg btn1, btn2;

initial begin
    clk = 1;
    btn1 = 1;
    btn1 = 1;
   #1 btn1 = 0;
   btn2 = 0;
    ms = 4452;
end

always #0.5 clk = ~clk;
//always #10000000 btn1 = ~btn1;
//always #10000000 btn2 = ~btn2; 

rsa_fpga_dec R (clk, ms, btn1, btn2, ci); 

endmodule
