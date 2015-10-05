`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:20:57 08/20/2015 
// Design Name: 
// Module Name:    Lab3_3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Lab3_3(
clk , rst_n , display ,display_ctl
    );
input clk;
input rst_n;
output [14:0]display;
output [3:0]display_ctl;
wire [3:0]display_ctl;
wire clk_out;
reg [3:0]bcd;
reg [3:0]tmp;
reg [3:0]ten;
reg [3:0]ten_tmp;
wire [3:0]bcd_in;
wire[1:0]clk_ctl;
wire zero = 4'd0;
Lab3_1_frequency_divider d1(
.clk(clk),
.clk_out(clk_out),
.rst_n(rst_n),
.clk_ctl(clk_ctl)
);
always @(posedge clk_out or negedge rst_n)
begin
	if(~rst_n)
	begin
	tmp<=4'd0;
	ten_tmp<=4'd3;
	end
	else
	begin
			if (tmp==4'd0)
			begin
				if(ten_tmp==4'd0)
				begin
				end
				else
				begin
				ten_tmp<=ten_tmp-4'd1;
				tmp <=4'd9;
				end
			end
			else
			begin
			tmp <= tmp - 4'd1;
			end
	end	
end

always @(posedge clk_out or negedge rst_n)
begin
		if (~rst_n)
		begin
		bcd<=4'd0;
		end
		else
		begin
		ten<=ten_tmp;
		bcd<=tmp;
		end
end		
scan_ctl s1(
	.ftsd_ctl(display_ctl), // ftsd display control signal 
	.ftsd_in(bcd_in), // output to ftsd display
	.in0(bcd), // 1st input
	.in1(ten), // 2nd input
	.in2(zero), // 3rd input
	.in3(zero), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);
bcd_14display disp(
.bcd(bcd_in),
.display(display)
);
endmodule
