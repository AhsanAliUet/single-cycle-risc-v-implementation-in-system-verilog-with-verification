
module pc #(
   parameter DW = 32
)(
   input  logic clk_i,
   input  logic rst_i,
   input  logic [DW-1:0] pc_next,
   output logic [DW-1:0] pc
);

   always_ff @ (posedge clk_i, posedge rst_i) begin
      if (rst_i) begin
         pc <= 0;
      end else begin
         pc <= pc_next;
      end
   end
endmodule