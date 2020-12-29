
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2020 06:55:43 PM
// Design Name: 
// Module Name: prosim
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


module prosim();
reg clk;
reg rst;
reg [1:0]ledSel;
reg [3:0] ssdSel;
wire [7:0] DP_leds;
wire[12:0] num;

RISCV_pipeline DP( clk,  rst, ledSel, ssdSel,DP_leds,num );
initial begin
clk = 0;
forever #50 clk = ~clk;
end
initial begin
rst = 1; #100
rst = 0;

end
endmodule
