module iic_write(

input wire sys_clk,
input wire sys_rst_n,
input wire key1,
input wire key2,
input wire [7:0] iic_wrdata,

output reg [7:0] cnt_128btye,
output wire SCL,
inout reg SDA

);

parameter cnt_20ms_max = 20'd5000;



reg [19:0]cnt_20ms;
reg [4:0]cnt_clk_1MHz;
reg clk_1MHz;
reg [1:0]cnt_clk_250KHz;
reg clk_250KHz;
reg SCL_clk_250KHz;



//按键消抖
always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_20ms <= 20'd0;
			else if(key1 == 1'b1 && key2 == 1'b1)
				cnt_20ms <= 20'd0;
			else if(cnt_20ms == cnt_20ms_max)
				cnt_20ms <= cnt_20ms;
			else
				cnt_20ms <= cnt_20ms + 20'd1;
//1MHz计数器			
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_clk_1MHz <= 5'd0;
			else if(cnt_clk_1MHz == 5'd24)
				cnt_clk_1MHz <= 5'd0;
			else
				cnt_clk_1MHz <= cnt_clk_1MHz + 5'd1;
				
//1MHz时钟				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)				
				clk_1MHz <= 1'b0;
			else if(cnt_clk_1MHz == 5'd24)
				clk_1MHz <= ~clk_1MHz;
			else
				clk_1MHz <= clk_1MHz;
//250KHz时钟计数器				
always @(posedge clk_1MHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_clk_250KHz <= 2'd0;
			else
				cnt_clk_250KHz <= cnt_clk_250KHz + 2'd1;

//250KHz时钟
always @(posedge clk_1MHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				clk_250KHz <= 1'b0;
			else if(cnt_clk_250KHz == 2'd3 || cnt_clk_250KHz == 2'd1)
				clk_250KHz <= ~clk_250KHz;
			else	
				clk_250KHz <= clk_250KHz;
				
//读写时钟				
always @(posedge clk_1MHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				SCL_clk_250KHz <= 1'b1;
			else if(cnt_clk_250KHz == 2'd2 || cnt_clk_250KHz == 2'd0)
				SCL_clk_250KHz <= ~SCL_clk_250KHz;
			else	
				SCL_clk_250KHz <= SCL_clk_250KHz;
				

/***************************************************************************************************************************/				
				
parameter IDIE = 8'd0,
				start = 8'd1,
				slave_address = 8'd2,
				wr_te = 8'd3,
				ack_1 = 8'd4,
				word_address = 8'd5,
				ack_2 = 8'd6,
				data_n = 8'd7,
				ack_3 = 8'd8,
				stop = 8'd9,
				stop1 = 8'd10;
				
parameter IDIE_r = 8'd11,
				start_r = 8'd12,
				slave_address_r = 8'd13,
				wr_te_r = 8'd14,
				ack_1_r = 8'd15,
				word_address_r = 8'd16,
				ack_2_r = 8'd17,
				read_address_r = 8'd18,
				kong_r = 8'd19,
				data_n_r = 8'd20,
				ack_3_r = 8'd21,
				stop_r = 8'd22,
				stop1_r = 8'd23;
				
				
reg [7:0]state;
reg [3:0]cnt_9;
reg [7:0]cnt_128;
reg en;
				
				
always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				state <= IDIE;
			else
				case(state)
					IDIE : 
						if((cnt_20ms == cnt_20ms_max - 2)&&(key1 == 1'b0))
							state <= start;
						else
							state <= state;
					start :
							state <= slave_address;
					slave_address:
						if(cnt_9 == 4'd7 && cnt_128 == 8'd0)
							state <= wr_te;
						else
							state <= state;
					wr_te :
							state <= ack_1;
					ack_1 :
							state <= word_address;
					word_address :
						if(cnt_9 == 4'd8 && cnt_128 == 8'd2)
							state <= ack_2;
						else
							state <= state;
					ack_2 :
							state <= data_n;
					data_n :
						if(cnt_9 == 4'd8 && cnt_128 == 8'd130)
							state <= ack_3;
						else
							state <= state;
					ack_3 :
							state <= stop;
					stop :
							state <= stop1;
					stop1 : 
							state <= IDIE;
					default : state <= state;
				endcase
						
				

				
always @(posedge SCL_clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				en <= 1'b0;
			else if(cnt_20ms == cnt_20ms_max - 2)
				en <= 1'b1;
			else if(cnt_128 == 8'd131 && cnt_9 == 4'd1)
				en <= 1'b0;
			else
				en <= en;
				

always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_9 <= 4'd0;
			else if(cnt_128 == 8'd131)
				cnt_9 <= 4'd0;
			else if(cnt_9 == 4'd9)
				cnt_9 <= 4'd1;
			else if(en == 1'b1 && cnt_20ms >= cnt_20ms_max - 1)
				cnt_9 <= cnt_9 + 4'd1;
			else
				cnt_9 <= 4'd0;
				
always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_128 <= 8'd0;
			else if(en == 1'b0)
				cnt_128 <= 8'd0;
			else if(cnt_9 == 4'd9)
				cnt_128 <= cnt_128 + 8'd1;
			else
				cnt_128 <= cnt_128;

assign SCL = ((cnt_9 >= 4'd1 && cnt_9 <= 4'd9 && cnt_128 <= 8'd130) || 
				(cnt_9_r >= 4'd1 && cnt_9_r <= 4'd9 &&
				((cnt_128_r >= 8'd0 && cnt_128_r <= 8'd2) || 
				(cnt_128_r >= 8'd4 && cnt_128_r <= 8'd132))))?(SCL_clk_250KHz):(1'b1);					
				
				
always @(*) 
		begin
		//写数据
			if(sys_rst_n == 1'b0)
				SDA <= 1'b1;
			else if(state == start)
				SDA <= 1'b0;
			else if(state == slave_address)
				begin
					if(cnt_9 == 4'd1 || cnt_9 == 4'd3 || cnt_9 == 4'd6 || cnt_9 == 4'd7)
						SDA <= 1'b1;
					else
						SDA <= 1'b0;
				end
			else if(state == wr_te)
				SDA <= 1'b0;
			else if(state == ack_1)
				SDA <= 1'bz;
			else if(state == word_address && (cnt_9 >= 4'd1 && cnt_9 <= 4'd8))
				SDA <= 1'b0;
			else if(state == ack_2)
				SDA <= 1'bz;
			else if(state == data_n)
				begin
					case(cnt_9)
						4'd1 : SDA <= iic_wrdata[7];
						4'd2 : SDA <= iic_wrdata[6];
						4'd3 : SDA <= iic_wrdata[5];
						4'd4 : SDA <= iic_wrdata[4];
						4'd5 : SDA <= iic_wrdata[3];
						4'd6 : SDA <= iic_wrdata[2];
						4'd7 : SDA <= iic_wrdata[1];
						4'd8 : SDA <= iic_wrdata[0];
						4'd9 : SDA <= 1'bz;
						default : SDA <= 1'B1;
					endcase
				end
			else if(state == ack_3)
				SDA <= 1'bz;
			else if(state == stop)
				SDA <= 1'b0;
			else if(state == stop1)
				SDA <= 1'b1;
			//读数据
			else if(cnt_9_r == 4'd0 && en_r == 1'b1)
				SDA <= 1'b0;
			else if(state_r == slave_address_r)
				begin
					if(cnt_9_r == 4'd1 || cnt_9_r == 4'd3 || cnt_9_r == 4'd6 || cnt_9_r == 4'd7)
						SDA <= 1'b1;
					else
						SDA <= 1'b0;
				end
			else if(state_r == wr_te_r)
				SDA <= 1'b0;
			else if(state_r == ack_1_r)
				SDA <= 1'bz;
			else if(state_r == word_address_r)
				if(cnt_9_r >= 4'd1 && cnt_9_r <= 4'd8)
					SDA <= 1'b0;
				else
					SDA <= 1'bz;
			else if(state_r == ack_2_r)
				SDA <= 1'bz;
			else if(state_r == kong_r)
				begin
					if(cnt_9_r >= 4'd2)
						SDA <= 1'b0;
					else
						SDA <= 1'b1;
				end
			else if(state_r == read_address_r)
				begin
					if(cnt_9_r == 4'd1 || cnt_9_r == 4'd3 || cnt_9_r == 4'd6 || cnt_9_r == 4'd7 || cnt_9_r == 4'd8)
						SDA <= 1'b1;
					else if(cnt_9_r == 4'd9)
						SDA <= 1'bz;
					else
						SDA <= 1'b0;
				end
			else if(state_r == data_n_r)
				if(cnt_9_r == 4'd9)
					SDA <= 1'b0;
				else
					SDA <= 1'bz;
			else if(state_r == ack_3_r)
				SDA <= 1'b1;
			else if(state_r == stop_r)
				SDA <= 1'b0;
			else if(state_r == stop1_r)
				SDA <= 1'b1;
			else 
				SDA <= 1'b1;
		end
				
				
always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_128btye <= 8'd1;
			else if(cnt_128 == 8'd131)
				cnt_128btye <= 8'd1;
			else if(cnt_128 >= 8'd3 && cnt_128 <= 8'd131 && cnt_9 == 4'd9)
				cnt_128btye <= cnt_128btye + 8'd1;
			else
				cnt_128btye <= cnt_128btye;
				

/*******************************************************************************/				
				
				
				

				
reg [7:0]state_r;
reg [3:0]cnt_9_r;
reg [7:0]cnt_128_r;
reg en_r;
				
				
always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				state_r <= IDIE_r;
			else
				case(state_r)
					IDIE_r : 
						if((cnt_20ms == cnt_20ms_max - 2)&&(key2 == 1'b0))
							state_r <= start_r;
						else
							state_r <= state_r;
					start_r :
							state_r <= slave_address_r;
					slave_address_r:
						if(cnt_9_r == 4'd7 && cnt_128_r == 8'd0)
							state_r <= wr_te_r;
						else
							state_r <= state_r;
					wr_te_r :
							state_r <= ack_1_r;
					ack_1_r :
							state_r <= word_address_r;
					word_address_r :
						if(cnt_9_r == 4'd8 && cnt_128_r == 8'd2)
							state_r <= ack_2_r;
						else
							state_r <= state_r;
					ack_2_r :
							state_r <= kong_r;
					kong_r :
							if(cnt_9_r == 4'd9 && cnt_128_r == 8'd3)
								state_r <= read_address_r;
							else 
								state_r <= state_r;
					read_address_r :
						if(cnt_9_r == 4'd9 && cnt_128_r == 8'd4)
							state_r <= data_n_r;
						else 
							state_r <= state_r;
					data_n_r :
						if(cnt_9_r == 4'd8 && cnt_128_r == 8'd132)
							state_r <= ack_3_r;
						else
							state_r <= state_r;
					ack_3_r :
							state_r <= stop_r;
					stop_r :
							state_r <= stop1_r;
					stop1_r :
							state_r <= IDIE_r;
					default : state_r <= state_r;
				endcase
						
				

				
always @(posedge SCL_clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				en_r <= 1'b0;
			else if(cnt_20ms == cnt_20ms_max - 2)
				en_r <= 1'b1;
			else if(cnt_128_r == 8'd133 && cnt_9_r == 4'd1)
				en_r <= 1'b0;
			else
				en_r <= en_r;
				

always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_9_r <= 4'd0;
			else if(cnt_128_r == 8'd133)
				cnt_9_r <= 4'd0;
			else if(cnt_128_r == 8'd3 && cnt_9_r == 4'd1)
				cnt_9_r <= 4'd9;
			else if(cnt_9_r == 4'd9)
				cnt_9_r <= 4'd1;
			else if(en_r == 1'b1)
				cnt_9_r <= cnt_9_r + 4'd1;
			else
				cnt_9_r <= 4'd0;
				
				
				
always @(posedge clk_250KHz or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_128_r <= 8'd0;
			else if(en_r == 1'b0)
				cnt_128_r <= 8'd0;
			else if(cnt_9_r == 4'd9 )
				cnt_128_r <= cnt_128_r + 8'd1;
			else
				cnt_128_r <= cnt_128_r;

			


endmodule
