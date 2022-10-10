//top file of single cycle riscv

module riscv_sc_top #(
   parameter DW = 32,
   parameter REG_SIZE = 32,
   parameter NO_OF_REGS_REG_FILE = 32,
   parameter REGW = $clog2(REG_SIZE),
   parameter MEM_SIZE_IN_KB = 1,
   parameter NO_OF_REGS = MEM_SIZE_IN_KB * 1024 / 4,
   parameter ADDENT = 4

)(
   input  logic clk_i,
   input  logic rst_i
);

   logic [DW-1:0] pc_next;
   logic [DW-1:0] pc;
   logic [DW-1:0] inst_o;

   logic [6:0] opcode;
   assign opcode = inst_o[6:0];   //declaration and assignment on the same line is prohibited
   
   logic [REGW-1:0] rs1;
   assign rs1 = inst_o[19:15];
   
   logic [REGW-1:0] rs2;
   assign rs2 = inst_o[24:20];
   
   logic [REGW-1:0] rd;
   assign rd = inst_o[11:7];
   
   logic [2:0] func3;
   assign func3 = inst_o[14:12];
   
   logic [6:0] func7;
   assign func7 = inst_o[31:25];

   logic [DW-1:0] rdata1;
   logic [DW-1:0] rdata2;
   logic [DW-1:0] alu_result;
   logic          zero;               //output from ALU
   logic [DW-1:0] scr_b;              //signal to support I-type

   //control signals
   logic          reg_write;
   logic          mem_write;
   logic [2:0]    imm_src;
   logic          alu_src;
   logic [1:0]    result_src;
   logic          pc_src;
   logic [1:0]    alu_op;

   //extend unit signls
   logic [DW-1:0] imm_ext;

pc #(
   .DW(DW)
)i_pc(
   .clk_i(clk_i),
   .rst_i(rst_i),
   .pc_next(pc_next),
   .pc(pc)
);

adder #(
   .DW(DW),
   .ADDENT(ADDENT)
)i_adder(
   .in(pc),
   .out(pc_next)
);

inst_mem #(
   .REG_SIZE(REG_SIZE),
   .MEM_SIZE_IN_KB(MEM_SIZE_IN_KB),
   .NO_OF_REGS(NO_OF_REGS)
)i_inst_mem(
   .addr_i(pc),
   .inst_o(inst_o)
);

reg_file #(
   .REG_SIZE(REG_SIZE),
   .NO_OF_REGS(NO_OF_REGS_REG_FILE),
   .REGW(REGW)
)i_reg_file(
   .clk_i(clk_i),
   .rst_i(rst_i),

   .we(reg_write),
   .raddr1_i(rs1),
   .rdata1_o(rdata1),

   .raddr2_i(rs2),
   .rdata2_o(rdata2),

   .waddr_i(rd),
   .wdata_i(alu_result)
);

imm_generator #(
   .DW(DW)
)i_imm_generator(
   .inst(inst_o),
   .s(imm_src),
   .imm_ext(imm_ext)
);

mux_2x1 #(
   .DW(DW)
)i_mux_i_type(
   .in0(rdata2),
   .in1(imm_ext),
   .s(alu_src),
   .out(scr_b)
);

alu #(
   .DW(DW)
)i_alu(
   .opcode(opcode),
   .func3(func3),
   .func7_5(func7[5]),
   .alu_operand_1_i(rdata1),
   .alu_operand_2_i(scr_b),
   .alu_result_o(alu_result),
   .zero(zero)
);

main_decoder i_main_decoder(
   .opcode(opcode),
   .zero(zero),
   
   .reg_write(reg_write),
   .mem_write(mem_write),
   .imm_src(imm_src),
   .alu_src(alu_src),
   .result_src(result_src),
   .pc_src(pc_src),

   .alu_op(alu_op)
);

endmodule