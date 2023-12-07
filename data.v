
	module data(

		input wire [7:0] cnt_128btye,
		output wire [7:0] iic_wrdata

	);

	wire [7:0] cfg_data[1:128];
							
	assign cfg_data[ 1]   = 8'h11	;
	assign cfg_data[ 2]   = 8'h76	;
	assign cfg_data[ 3]   = 8'hb4	;
	assign cfg_data[ 4]   = 8'h53	;
	assign cfg_data[ 5]   = 8'h42	;  
	assign cfg_data[ 6]   = 8'h18	;
	assign cfg_data[ 7]   = 8'h43	;
	assign cfg_data[ 8]   = 8'h05	;
	assign cfg_data[ 9]   = 8'h06	;
	assign cfg_data[10]   = 8'h07	;
	assign cfg_data[11]   = 8'h09	;
	assign cfg_data[12]   = 8'h0a	;
	assign cfg_data[13]   = 8'h0b	; 
	assign cfg_data[14]   = 8'h0c	;
	assign cfg_data[15]   = 8'h0d	;  
	assign cfg_data[16]   = 8'h0e	;
	assign cfg_data[17]   = 8'h0f	;
	assign cfg_data[18]   = 8'h11	;
	assign cfg_data[19]   = 8'h12 ;
	assign cfg_data[20]   = 8'h13 ;
	assign cfg_data[21]   = 8'h14 ;
	assign cfg_data[22]   = 8'h15 ;
	assign cfg_data[23]   = 8'h16 ;
	assign cfg_data[24]   = 8'h17 ;
	assign cfg_data[25]   = 8'h01	;
	assign cfg_data[26]   = 8'hff	;
	assign cfg_data[27]   = 8'h0a	;
	assign cfg_data[28]   = 8'h7d	; 
	assign cfg_data[29]   = 8'h85	; 
	assign cfg_data[30]   = 8'h24	;
	assign cfg_data[31]   = 8'h53	; 
	assign cfg_data[32]   = 8'h00	; 
	assign cfg_data[33]   = 8'h53	; 
	assign cfg_data[34]   = 8'h53	; 
	assign cfg_data[35]   = 8'h53	; 
	assign cfg_data[36]   = 8'h53	; 
	assign cfg_data[37]   = 8'h53	; 
	assign cfg_data[38]   = 8'h53	; 
	assign cfg_data[39]   = 8'h53	; 
	assign cfg_data[40]   = 8'h53	;
	
	assign cfg_data[41]   = 8'h53	; 
	assign cfg_data[42]   = 8'h00	; 
	assign cfg_data[43]   = 8'h53	; 
	assign cfg_data[44]   = 8'h53	; 
	assign cfg_data[45]   = 8'h53	; 
	assign cfg_data[46]   = 8'h53	; 
	assign cfg_data[47]   = 8'h53	; 
	assign cfg_data[48]   = 8'h53	; 
	assign cfg_data[49]   = 8'h53	; 
	assign cfg_data[50]   = 8'h53	; 

	assign cfg_data[51]   = 8'h53	; 
	assign cfg_data[52]   = 8'h00	; 
	assign cfg_data[53]   = 8'h53	; 
	assign cfg_data[54]   = 8'h53	; 
	assign cfg_data[55]   = 8'h53	; 
	assign cfg_data[56]   = 8'h53	; 
	assign cfg_data[57]   = 8'h53	; 
	assign cfg_data[58]   = 8'h53	; 
	assign cfg_data[59]   = 8'h53	; 
	assign cfg_data[60]   = 8'h53	; 
	
	assign cfg_data[61]   = 8'h53	; 
	assign cfg_data[62]   = 8'h00	; 
	assign cfg_data[63]   = 8'h53	; 
	assign cfg_data[64]   = 8'h53	; 
	assign cfg_data[65]   = 8'h53	; 
	assign cfg_data[66]   = 8'h53	; 
	assign cfg_data[67]   = 8'h53	; 
	assign cfg_data[68]   = 8'h53	; 
	assign cfg_data[69]   = 8'h53	; 
	assign cfg_data[70]   = 8'h53	; 
	
	assign cfg_data[71]   = 8'h53	; 
	assign cfg_data[72]   = 8'h00	; 
	assign cfg_data[73]   = 8'h53	; 
	assign cfg_data[74]   = 8'h53	; 
	assign cfg_data[75]   = 8'h53	; 
	assign cfg_data[76]   = 8'h53	; 
	assign cfg_data[77]   = 8'h53	; 
	assign cfg_data[78]   = 8'h53	; 
	assign cfg_data[79]   = 8'h53	; 
	assign cfg_data[80]   = 8'h53	; 
	
	assign cfg_data[81]   = 8'h53	; 
	assign cfg_data[82]   = 8'h00	; 
	assign cfg_data[83]   = 8'h53	; 
	assign cfg_data[84]   = 8'h53	; 
	assign cfg_data[85]   = 8'h53	; 
	assign cfg_data[86]   = 8'h53	; 
	assign cfg_data[87]   = 8'h53	; 
	assign cfg_data[88]   = 8'h53	; 
	assign cfg_data[89]   = 8'h53	; 
	assign cfg_data[90]   = 8'h53	;
	
	assign cfg_data[91]   = 8'h53	; 
	assign cfg_data[92]   = 8'h00	; 
	assign cfg_data[93]   = 8'h53	; 
	assign cfg_data[94]   = 8'h53	; 
	assign cfg_data[95]   = 8'h53	; 
	assign cfg_data[96]   = 8'h53	; 
	assign cfg_data[97]   = 8'h53	; 
	assign cfg_data[98]   = 8'h53	; 
	assign cfg_data[99]   = 8'h53	; 
	assign cfg_data[100]   = 8'h53	; 
	
	assign cfg_data[101]   = 8'h53	; 
	assign cfg_data[102]   = 8'h00	; 
	assign cfg_data[103]   = 8'h53	; 
	assign cfg_data[104]   = 8'h53	; 
	assign cfg_data[105]   = 8'h53	; 
	assign cfg_data[106]   = 8'h53	; 
	assign cfg_data[107]   = 8'h53	; 
	assign cfg_data[108]   = 8'h53	; 
	assign cfg_data[109]   = 8'h53	; 
	assign cfg_data[110]   = 8'h53	; 
	
	assign cfg_data[111]   = 8'h53	; 
	assign cfg_data[112]   = 8'h00	; 
	assign cfg_data[113]   = 8'h53	; 
	assign cfg_data[114]   = 8'h53	; 
	assign cfg_data[115]   = 8'h53	; 
	assign cfg_data[116]   = 8'h53	; 
	assign cfg_data[117]   = 8'h53	; 
	assign cfg_data[118]   = 8'h53	; 
	assign cfg_data[119]   = 8'h53	; 
	assign cfg_data[120]   = 8'h53	; 
	
	assign cfg_data[121]   = 8'h53	; 
	assign cfg_data[122]   = 8'h00	; 
	assign cfg_data[123]   = 8'h53	; 
	assign cfg_data[124]   = 8'h53	; 
	assign cfg_data[125]   = 8'h53	; 
	assign cfg_data[126]   = 8'h53	; 
	assign cfg_data[127]   = 8'h53	; 
	assign cfg_data[128]   = 8'h53	; 


assign iic_wrdata = cfg_data[cnt_128btye];




	endmodule 
	