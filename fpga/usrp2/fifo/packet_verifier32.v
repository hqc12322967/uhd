

module packet_verifier32
  (input clk, input reset, input clear,
   input [35:0] data_i, input src_rdy_i, output dst_rdy_o,
   output [31:0] total, output [31:0] crc_err, output [31:0] seq_err, output [31:0] len_err);

   wire [7:0] 	 ll_data;
   wire 	 ll_sof, ll_eof, ll_src_rdy, ll_dst_rdy;
 	 
   fifo36_to_ll8 f36_to_ll8
     (.clk(clk), .reset(reset), .clear(clear),
      .f36_data(data_i), .f36_src_rdy_i(src_rdy_i), .f36_dst_rdy_o(dst_rdy_o),
      .ll_data(ll_data), .ll_sof(ll_sof), .ll_eof(ll_eof),
      .ll_src_rdy(ll_src_rdy), .ll_dst_rdy(ll_dst_rdy));
   
   packet_verifier pkt_ver
     (.clk(clk), .reset(reset), .clear(clear),
      .data_i(ll_data), .sof_i(ll_sof), .eof_i(ll_eof),
      .src_rdy_i(ll_src_rdy), .dst_rdy_o(ll_dst_rdy),
      .total(total), .crc_err(crc_err), .seq_err(seq_err), .len_err(len_err));

endmodule // packet_verifier32
