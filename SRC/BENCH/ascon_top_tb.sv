//test bench 2 de la permutation finale (avec compteur double)

`timescale 1 ns/ 1 ps

module ascon_top_tb import ascon_pack::*;
(
);

	 	logic clock_i_s;
	 	logic resetb_i_s;
		logic[63:0] data_i_s;
		logic data_valid_i_s;
		logic[127:0] key_i_s;
		logic[127:0] nonce_i_s;
		logic start_i_s;

		logic[63:0] cipher_o_s;
		logic cipher_valid_o_s;
		logic[127:0] tag_o_s; 	
		logic end_o_s;

	ascon_top DUT (
		.clock_i(clock_i_s),
	 	.resetb_i(resetb_i_s),
		.start_i(start_i_s),
		.data_valid_i(data_valid_i_s),
		.data_i(data_i_s),
		.key_i(key_i_s),
		.nonce_i(nonce_i_s),  

		.cipher_valid_o(cipher_valid_o_s),
		.cipher_o(cipher_o_s),
		.tag_o(tag_o_s),  	
		.end_o(end_o_s)
	);


  initial begin 
	clock_i_s = 1'b0;
	forever #10 clock_i_s = ~clock_i_s;
   end
   
   initial begin

      key_i_s = 128'h8a55114d1cb6a9a2be263d4d7aecaaff;
      nonce_i_s = 128'h4ED0EC0B98C529B7C8CDDF37BCD0284A;

      data_valid_i_s = 1'b0;
      start_i_s = 1'b0;
      resetb_i_s = 1'b0;
      data_i_s = 64'h0;

      #100;
      resetb_i_s = 1'b1;


      #20
      start_i_s = 1'b1;

      #20
      start_i_s = 1'b0;

      #240;


      data_valid_i_s = 1'b1;

      data_i_s =64'h4120746f20428000;
      #20;
      data_valid_i_s = 1'b0;
      #240;


      data_valid_i_s = 1'b1;

      data_i_s =64'h5244562061752054;
      #20;
      data_valid_i_s = 1'b0;
      #240;


      data_valid_i_s = 1'b1;

      data_i_s =64'h6927626172206365;
      #20;
      data_valid_i_s = 1'b0;
      #240;


      data_valid_i_s = 1'b1;

      data_i_s =64'h20736F6972203F80;
      #20;
      data_valid_i_s = 1'b0;
      #240;


      data_valid_i_s = 1'b1;
      #20;
      data_valid_i_s = 1'b0;


end
endmodule : ascon_top_tb

