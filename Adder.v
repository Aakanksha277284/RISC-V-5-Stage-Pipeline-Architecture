`ifndef Adder_V
`define Adder_V

module Adder (a,b,c);

input [31:0] a,b;
output [31:0] c;

assign c = a + b;
    
endmodule
`endif