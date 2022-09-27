module reg_file #(
   parameter REG_SIZE = 32,
   parameter NO_OF_REGS = 32,
   parameter REGW = $clog2(REG_SIZE)
)(
   input  logic                clk_i,
   input  logic                rst_i,

   input  logic [REGW-1:0]     raddr1_i,
   output logic [REG_SIZE-1:0] rdata1_o,

   input  logic [REGW-1:0]     raddr2_i,
   output logic [REG_SIZE-1:0] rdata2_o,

   input  logic [REGW-1:0]     waddr_i,
   input  logic [REG_SIZE-1:0] wdata_i
);

   //unpacked array can be veiwed in memory list of simulator, 
   //packed array can be seen in waveforms
   logic [REG_SIZE-1:0] reg_file [0:NO_OF_REGS-1];
   
   assign rdata1_o = (|raddr1_i) ? reg_file[raddr1_i] : '0;    //asynchronous read
   assign rdata2_o = (|raddr2_i) ? reg_file[raddr2_i] : '0;    //asynchronous read

   always_ff @(posedge clk_i, posedge rst_i) begin
      if (rst_i) begin
         for (int i = 0; i < NO_OF_REGS; i = i + 1) begin
            reg_file[i] <= '0;
         end
      end else if (|waddr_i) begin
         reg_file[waddr_i] <= wdata_i;
      end
   end
endmodule