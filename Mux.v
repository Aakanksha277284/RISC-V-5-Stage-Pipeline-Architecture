`ifndef Mux_V
`define Mux_V

module Mux(a,b,s,y);
input [31:0] a, b;
input s;
output [31:0] y;

assign y = s ? b : a;
endmodule
`endif