`timescale 1ns/1ps

module FSM_moore import ascon_pack::*;
	(
	 	input logic start_i,
		input logic clock_i,
	 	input logic resetb_i,
		input logic data_valid_i,
		input logic[3:0] round_i,
	
		output logic data_select_o,
		output logic en_xor_key_beg_o,
		output logic en_xor_d_beg_o,
		output logic en_xor_key_end_o,
		output logic en_xor_lsb_end_o,

		output logic en_reg_state_o,
		output logic cipher_valid_o,
		output logic end_o,

		output logic en_cpt_round_o,
		output logic init_a_o,
		output logic init_b_o

	);


//definition du type énumeré

typedef enum{idle_init, conf_init, end_conf_init, init, end_init, idle_da, conf_da, da, end_da, idle_tc, conf_tc, tc_1, end_tc_1, tc_2, end_tc_2, idle_finalisation, conf_finalisation, finalisation, end_finalisation} state_t;

//2 variables intermédiaires

state_t current_state;
state_t next_state;

//processus sequentiel qui modélise le registre des états
always_ff@(posedge clock_i or negedge resetb_i)
begin : seq_0
	if(resetb_i==1'b0)
		current_state<=idle_init;
	else current_state<=next_state;

end : seq_0

//modélisation des transitions
always_comb begin : comb_0
	case(current_state)
		idle_init:
			if(start_i == 1'b0)
				next_state = idle_init;
			else next_state = conf_init;
		conf_init:
			next_state = end_conf_init;
		end_conf_init:
			next_state = init;
		init:
			if(round_i == 4'hA)
				next_state = end_init; 
			else next_state = init;
		
		end_init : 
			if(data_valid_i==1'b1)
				next_state = conf_da;
			else next_state = idle_da;

		idle_da : 
			if(data_valid_i==1'b0)
				next_state = idle_da;
			else next_state=conf_da;

		conf_da :
			next_state = da;


		da :
			if (round_i == 4'hA)
				next_state=end_da;
			else next_state=da;

		end_da : 
                      if(data_valid_i==1'b0)
				next_state = idle_tc;
			else next_state=conf_tc;
          
                idle_tc :
                      if(data_valid_i==1'b0)
				next_state = idle_tc;
			else next_state=conf_tc;

                conf_tc :

                      next_state=tc_1;

                tc_1 :
                      if (round_i == 4'hA)
				next_state=end_tc_1;
			else next_state=tc_1;


                end_tc_1 :
                      next_state=tc_2;

                tc_2 :
                      if (round_i == 4'hA) 
				next_state=end_tc_2;
			else next_state=tc_2;

                end_tc_2 :
                      next_state=idle_finalisation;
                
                idle_finalisation :
                      if(data_valid_i==1'b0)
				next_state = idle_finalisation;
			else next_state=conf_finalisation;

                conf_finalisation :

                      next_state=finalisation;

                finalisation :
                      if (round_i == 4'hA)
				next_state=end_finalisation;
			else next_state=finalisation;

                end_finalisation :
                      next_state=idle_init;

		default: next_state = idle_init;
	endcase
end : comb_0	


always_comb begin : OUTPUT_LOGIC

		//set default values
        	data_select_o = 1'b1;
		en_xor_key_beg_o = 1'b0;
		en_xor_d_beg_o = 1'b0;
		en_xor_key_end_o = 1'b0;
		en_xor_lsb_end_o = 1'b0;
		en_reg_state_o = 1'b1; //l'enregistrement est desactive par defaut
		cipher_valid_o  = 1'b0;
        	end_o        = 1'b0;
		en_cpt_round_o  = 1'b0;
        	init_a_o        = 1'b0;
     	   	init_b_o        = 1'b0;


		case (current_state)
			idle_init: begin 
			en_reg_state_o = 1'b0;
			end
			
			conf_init: begin 
			init_a_o = 1'b1; // Initialise le compteur a 0
			en_cpt_round_o = 1'b1;
			en_reg_state_o = 1'b0;
			end

			end_conf_init: begin 
			data_select_o = 1'b0; 
			en_cpt_round_o = 1'b1;
			end

			init: begin 
			en_cpt_round_o = 1'b1;
			end

			end_init: begin
			en_xor_key_end_o = 1'b1;
			init_b_o = 1'b1; //Initialise le compteur a 6
			en_cpt_round_o = 1'b1;
			end 

			idle_da: begin 
			en_reg_state_o = 1'b0;
			end 

			conf_da: begin 
			en_cpt_round_o = 1'b1;
			en_xor_d_beg_o = 1'b1;
			end

			da : begin 
			en_cpt_round_o = 1'b1;
			end 

			end_da: begin 
			en_xor_lsb_end_o = 1'b1;
			init_b_o = 1'b1;
			end 

			idle_tc: begin 
			en_reg_state_o = 1'b0;
			end

			conf_tc: begin 
			en_reg_state_o = 1'b0;
			en_cpt_round_o = 1'b1;
			en_xor_d_beg_o = 1'b1;
			end 

			tc_1 : begin
			en_cpt_round_o = 1'b1;
			end

			end_tc_1: begin 
			init_b_o = 1'b1;
			en_cpt_round_o = 1'b1;
			en_reg_state_o = 1'b0;
			end

			tc_2 : begin
			en_cpt_round_o = 1'b1;
			end

			end_tc_2: begin 
			init_b_o = 1'b1;
			en_reg_state_o = 1'b0;
			end

			idle_finalisation: begin 
			en_cpt_round_o = 1'b1;
	   		cipher_valid_o = 1'b1; 
			end

			conf_finalisation : begin 
			en_cpt_round_o = 1'b1;
			init_a_o = 1'b1; 
			end 

			finalisation: begin 
			en_cpt_round_o = 1'b1;
			end

			end_finalisation: begin 
			en_cpt_round_o = 1'b1;  
			end_o = 1'b1;
			en_xor_key_beg_o = 1'b1;
			end



		endcase
	end : OUTPUT_LOGIC
endmodule : FSM_moore



