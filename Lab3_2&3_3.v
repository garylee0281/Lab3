`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:06 08/19/2015 
// Design Name: 
// Module Name:    Lab3_2 
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
module Lab3_2( clk , rst_n , display ,display_ctl
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
always @(bcd)
begin
	tmp<=bcd+4'd1;
end

always @(posedge clk_out or negedge rst_n)
begin
		if (~rst_n)
		begin
		bcd<=4'd0;
		ten<=4'd0;
		end
		else
		begin
			if(tmp>4'd9)
			begin
				if(ten==4'd9)
				begin
					ten<=4'd0;
					bcd<=4'd0;	
				end	
				else
					begin
					bcd<=4'd0;
					ten<=ten+4'd1;
					end
			end	
			else
			begin
			bcd<=tmp;
			end
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
