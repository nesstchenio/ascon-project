`timescale 1 ns/ 1 ps
module bench_sbox import ascon_pack::*;
    (
    );
    logic [4:0] sbox_i_s;
    logic [4:0] sbox_o_s;
    s_box DUT (
        .sbox_i(sbox_i_s),
        .sbox_o(sbox_o_s)
        );
    initial begin
        int i;
        sbox_i_s = 5'h00;
        for ( i=0; i<32; i++) begin
            sbox_i_s = i;
            #20;
        end
        assert (i==32) $display ("End of simulation");
    end
endmodule: bench_sbox
