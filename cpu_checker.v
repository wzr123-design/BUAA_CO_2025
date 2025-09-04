`timescale 1ns / 1ps

module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
    output [1:0]format_type
    );

wire isd,ish;
assign isd=(char>="0"&&char<="9");
assign ish=((char>="0"&&char<="9")||(char>="a"&&char<="f"));

assign format_type= (s==12)?1:
                    (s==19)?2:
                    0;

reg[4:0] s=0;
reg[3:0] cnt1=0,cnt2=0,cnt3=0,cnt4=0,cnt5=0; 
always@(posedge clk)begin
	if(reset)begin
		cnt1<=0;
		cnt2<=0;
		cnt3<=0;
		cnt4<=0;
		cnt5<=0;
		s<=0;
	end
	else begin
		case(s)
			0: begin
				if(char=="^") s<=1;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			1: begin
				if(isd)begin 
					s<=2; cnt1<=1; 
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			2: begin
				if(isd)begin
					cnt1=cnt1+1;
					if(cnt1>4)begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
					else s<=2;
				end 
				else if(char=="@") s<=3;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			3: begin
				if(ish)begin
					s<=4;
					cnt2<=1;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			4: begin
				if(ish)begin
					cnt2=cnt2+1;
					if(cnt2>8)begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
					else s<=4;
				end
				else if(char==":")begin
					if(cnt2==8) s<=5;
					else begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
				end
				else begin cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;end
				//上面的else分支忘记写了，这个bug硬焊我两个小时
				//所以always块里面是可以写阻塞赋值块的
			end
			5: begin
				if(char==" ") s<=5;
				else if(char=="$") s<=6;
				else if(char=="*") s<=13;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			6: begin
				if(isd)begin
					s<=7;
					cnt3<=1;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			7: begin
				if(isd)begin
					cnt3=cnt3+1;
					if(cnt3>4)begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
					else s<=7;
				end
				else if(char==" ") s<=8;
				else if(char=="<") s<=9;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			8: begin
				if(char==" ") s<=8;
				else if(char=="<") s<=9;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			9: begin
				if(char=="=") s<=10;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			10: begin
				if(char==" ") s<=10;
				else if(ish) begin
					cnt5<=1;
					s<=11;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			11: begin
				if(ish)begin
					cnt5=cnt5+1;
					if(cnt5>8)begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
					else s<=11;
				end
				else if(char=="#")begin
					if(cnt5==8) s<=12;
					else begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			12: begin
				if(char=="^")begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;
					s<=1;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			13: begin
				if(ish)begin
					s<=14;
					cnt4<=1;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			14: begin
				if(ish)begin
					cnt4=cnt4+1;
					if(cnt4>8)begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
					else s<=14;
				end
				else if(char==" ")begin
					if(cnt4==8) s<=15;
					else begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
				end
				else if(char=="<")begin
					if(cnt4==8) s<=16;
					else begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			15: begin
				if(char==" ") s<=15;
				else if(char=="<") s<=16;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			16:begin
				if(char=="=") s<=17;
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			17:begin
				if(char==" ") s<=17;
				else if(ish) begin
					cnt5<=1;
					s<=18;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			18:begin
				if(ish)begin
					cnt5=cnt5+1;
					if(cnt5>8)begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
					else s<=18;
				end
				else if(char=="#")begin
					if(cnt5==8) s<=19;
					else begin
						cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
					end
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			19:begin
				if(char=="^")begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;
					s<=1;
				end
				else begin
					cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
				end
			end
			default: begin
                cnt1<=0;cnt2<=0;cnt3<=0;cnt4<=0;cnt5<=0;s<=0;
            end
		endcase
	end
end

endmodule
