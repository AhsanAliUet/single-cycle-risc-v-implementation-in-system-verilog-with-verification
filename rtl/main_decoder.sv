//a part of the controller of processor

module main_decoder (
   input  logic [6:0] opcode,
   input  logic       zero,
   
   output logic       reg_write,
   output logic       mem_write,
   output logic [1:0] imm_src,
   output logic       alu_src,
   output logic [1:0] result_src,
   output logic       pc_src,

   output logic [1:0] alu_op       //used to alu_decoder module
);
   logic       jump;
   logic       branch;

always_comb begin
   case(opcode)
      7'b0000011: begin             //lw
         reg_write = 1'b1;
         mem_write = 1'b0;
         imm_src = 2'b00;
         alu_src = 1'b1;
         result_src = 2'b01;
         branch = 1'b0;
         jump = 1'b0;

         alu_op = 2'b00;

      end
      7'b0100011: begin            //sw
         reg_write = 1'b0;
         mem_write = 1'b1;
         imm_src = 2'b01;
         alu_src = 1'b1;
         result_src = 2'bxx;
         branch = 1'b0;
         jump = 1'b0;

         alu_op = 2'b00;

      end
      7'b0110011: begin            //R
         reg_write = 1'b1;
         mem_write = 1'b0;
         imm_src = 2'bxx;
         alu_src = 1'b0;
         result_src = 2'b00;
         branch = 1'b0;
         jump = 1'b0;

         alu_op = 2'b10;

      end
      7'b1100011: begin            //B
         reg_write = 1'b0;
         mem_write = 1'b0;
         imm_src = 2'b10;
         alu_src = 1'b0;
         result_src = 2'bxx;
         branch = 1'b1;
         jump = 1'b0;

         alu_op = 2'b01;

      end
      7'b1100011: begin            //I
         reg_write = 1'b1;
         mem_write = 1'b0;
         imm_src = 2'b00;
         alu_src = 1'b1;
         result_src = 2'b00;
         branch = 1'b0;
         jump = 1'b0;

         alu_op = 2'b10;

      end
      7'b1100011: begin            //Jal
         reg_write = 1'b1;
         mem_write = 1'b0;
         imm_src = 2'b11;
         alu_src = 1'bx;
         result_src = 2'b10;
         branch = 1'b0;
         jump = 1'b1;

         alu_op = 2'bxx;

      end
   endcase
   assign pc_src = (zero & branch) | jump;
end


endmodule