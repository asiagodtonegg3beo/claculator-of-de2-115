module clock_time( iclk, ikey, okey_count, ohour, omin, osec ,ledg,sw);

input iclk;
input [4:0] ikey;
input [3:0] sw;
output [7:0] ohour, omin, osec, okey_count;
output reg [8:0]ledg;

reg [27:24] counter;
reg [7:0] thour, tmin, tsec, tkey_count;

assign osec[3:0] = tsec%10;
assign osec[7:4] = tsec/10;

assign omin[3:0] = tmin%10;
assign omin[7:4] = tmin/10;

assign ohour[3:0] = thour%10;
assign ohour[7:4] = thour/10;

assign okey_count[3:0] = tkey_count%10;
assign okey_count[7:4] = tkey_count/10;
//
reg a=1;
reg b=0;
//
always @ ( posedge iclk )
begin
counter<=counter+1;
end

always @(posedge iclk)
begin
//
   case (sw)
            4'b0000: tkey_count<=8'd0; // 0
            4'b0001: tkey_count<=8'd1; // 1
            4'b0010: tkey_count<=8'd2; // 2
            4'b0011: tkey_count<=8'd3; // 3
            4'b0100: tkey_count<=8'd4; // 4
            4'b0101: tkey_count<=8'd5; // 5
            4'b0110: tkey_count<=8'd6; // 6
            4'b0111: tkey_count<=8'd7; // 7
            4'b1000: tkey_count<=8'd8; // 8
            4'b1001: tkey_count<=8'd9; // 9
        endcase
	if(!ikey[3]&&(~b))
	begin
		a=~a;
		b=1'b1;
end
//
	if(ikey[3])
	begin
		b=1'b0;

/*
	case ( counter[27:24] )
// case ( counter[27:24] )这一句希望初学者看明白,
// 也是分频的丶? // 只有在0的那一位 对应的LED灯才亮。
0: ledg<=8'b11111110;
1: ledg<=8'b11111101;
2: ledg<=8'b11111011;
3: ledg<=8'b11110111;
4: ledg<=8'b11101111;
5: ledg<=8'b11011111;
6: ledg<=8'b10111111;
7: ledg<=8'b01111111;
8: ledg<=8'b11111111;
9: ledg<=8'b01111111;
10: ledg<=8'b10111111;
11: ledg<=8'b11011111;
12: ledg<=8'b11101111;
13: ledg<=8'b11110111;
14: ledg<=8'b11111011;
15: ledg<=8'b11111101;
endcase	
*/

	end
//
	if(a)//go a==1 sw3
		begin
		if (!ikey[0])
	begin
	tkey_count<=0;
	end

else if (!ikey[2])
begin
	case ( counter[27:24] )
// case ( counter[27:24] )这一句希望初学者看明白,
// 也是分频的丶? // 只有在0的那一位 对应的LED灯才亮。
0: ledg<=8'b11111110;
1: ledg<=8'b11111101;
2: ledg<=8'b11111011;
3: ledg<=8'b11110111;
4: ledg<=8'b11101111;
5: ledg<=8'b11011111;
6: ledg<=8'b10111111;
7: ledg<=8'b01111111;
8: ledg<=8'b11111111;
9: ledg<=8'b01111111;
10: ledg<=8'b10111111;
11: ledg<=8'b11011111;
12: ledg<=8'b11101111;
13: ledg<=8'b11110111;
14: ledg<=8'b11111011;
15: ledg<=8'b11111101;
endcase	
end
	else if (!ikey[1])
		begin
			tkey_count <= tkey_count+1'b1;
			if (tmin ==59) tmin<=0; else	tmin <= tmin+1;
		end
	else if (thour==11 && tmin==59 && tsec==59)
		begin
			thour <= 0;
			tmin <= 0;
			tsec <= 0;
		end
	else if (tmin==59 && tsec==59)
		begin
			thour <= thour+1;
			tmin <= 0;
			tsec <= 0;
		end
	else if (tsec == 59)
		begin
			tmin <= tmin+1;
			tsec <= 0;
		end
	else
		tsec <= tsec + 1;
		end
//
/*
	if (!ikey[0])
	begin
		thour <= 0;
		tmin <= 0;
		tsec <= 0;
		tkey_count <= 0;		
	end
	else if (!ikey[2])
		begin
			tkey_count <= tkey_count+1'b1;
			if (thour==11) thour <= 0; else	thour <=thour+1;
		end
	else if (!ikey[1])
		begin
			tkey_count <= tkey_count+1'b1;
			if (tmin ==59) tmin<=0; else	tmin <= tmin+1;
		end
	else if (thour==11 && tmin==59 && tsec==59)
		begin
			thour <= 0;
			tmin <= 0;
			tsec <= 0;
		end
	else if (tmin==59 && tsec==59)
		begin
			thour <= thour+1;
			tmin <= 0;
			tsec <= 0;
		end
	else if (tsec == 59)
		begin
			tmin <= tmin+1;
			tsec <= 0;
		end
	else
		tsec <= tsec + 1;
*/

end

endmodule