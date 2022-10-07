module adder #(
   parameter DW = 32,
   parameter ADDENT = 4      //value to be added
)(
   input  logic [DW-1:0] in,
   output logic [DW-1:0] out
);

   assign out = in + ADDENT;
endmodule