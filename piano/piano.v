module piano(clk, rst, key, buzzer);
input clk, rst;
input [7:0] key;
output buzzer;

parameter INIT = 0;
parameter PLAY = 1;


reg state;
reg [21:0] beat_cnt;
reg [16:0] tone_cnt;
reg [16:0] tone_value;
reg [0:20] record;
reg [0:10] music;
reg buzzer;

always @(posedge clk or posedge rst)
if (rst) state = INIT;
else
	case (state)
		INIT: if (key != 0) begin
				beat_cnt = 0;
				tone_cnt = 0;
				buzzer = 0;
				state = PLAY;
				if (key[7] == 1) tone_value = 95750; //c 1915us/20ns=95750
				if (key[6] == 1) tone_value = 85000; //d
				if (key[5] == 1) tone_value = 75950; //e
				if (key[4] == 1) tone_value = 71600; //f
				if (key[3] == 1) tone_value = 63750; //g
				if (key[2] == 1) tone_value = 56800; //a
				if (key[1] == 1) tone_value = 50700; //b
				if (key[0] == 1) tone_value = 47800; //c
			end
		PLAY : begin
				beat_cnt = beat_cnt + 1;
				if (beat_cnt == 0)state = INIT;
				tone_cnt = tone_cnt + 1;
				if (tone_cnt == tone_value) begin
					buzzer = !buzzer;
					tone_cnt = 0;
				end
			end
		default: state = INIT;
	endcase
endmodule 