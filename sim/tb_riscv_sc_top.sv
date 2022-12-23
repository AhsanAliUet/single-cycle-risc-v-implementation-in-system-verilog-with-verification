//test bench for top file of riscv

module tb_riscv_sc_top();
   parameter DW = 32;
   parameter REG_SIZE = 32;
   parameter NO_OF_REGS_REG_FILE = 32;
   parameter REGW = $clog2(REG_SIZE);
   parameter MEM_SIZE_IN_KB = 1;
   parameter NO_OF_REGS = MEM_SIZE_IN_KB * 1024 / 4;
   parameter ADDENT = 4;

   logic clk_i;
   logic rst_i;

riscv_sc_top #(
   .DW(DW),
   .REG_SIZE(REG_SIZE),
   .NO_OF_REGS_REG_FILE(NO_OF_REGS_REG_FILE),
   .REGW(REGW),
   .MEM_SIZE_IN_KB(MEM_SIZE_IN_KB),
   .NO_OF_REGS(NO_OF_REGS),
   .ADDENT(ADDENT)

)i_riscv_sc_top(
   .clk_i(clk_i),
   .rst_i(rst_i)
);

   initial begin
      clk_i = 0;
      forever begin
         #5; clk_i = ~clk_i;
      end
   end

   initial begin
      fork
         reset();
      join
   end

   initial begin
      #5000;
      $display("=========================== Register file is ... ===========================");
      for (int i = 0; i < 32; i++) begin
         $display("x%2d = 0x%8h", i, i_riscv_sc_top.i_reg_file.reg_file[i]);
      end

      $display("=========================== Data memory is ... ===========================");
      for (int i = 0; i < 21; i++) begin
         $display("x%2d = 0x%8h", i, i_riscv_sc_top.i_data_mem.data_mem[i]);
      end

      $finish;
   end

   initial begin
      $dumpfile("docs/dump.vcd");
      $dumpvars;
   end

   task reset();
                        rst_i <= 0;
      @(posedge clk_i); rst_i <= #1 1;
      @(posedge clk_i); rst_i <= #1 0;
   endtask


endmodule