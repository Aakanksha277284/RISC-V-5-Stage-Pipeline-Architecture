`ifndef Mux_3_X_1_V
`define Mux_3_X_1_V

module Mux_3_X_1(a,b,c,s,y);
input [31:0] a,b,c;
input [1:0] s;
output [31:0] y;

assign y = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 32'h00000000;
endmodule
`endif