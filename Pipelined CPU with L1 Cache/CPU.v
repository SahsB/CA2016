module CPU
(
	clk_i,
	rst_i,
	start_i,
   
	mem_data_i, 
	mem_ack_i, 	
	mem_data_o, 
	mem_addr_o, 	
	mem_enable_o, 
	mem_write_o
);

//input
input clk_i;
input rst_i;
input start_i;

//
// to Data Memory interface		
//
input	[256-1:0]	mem_data_i; 
input				mem_ack_i; 	
output	[256-1:0]	mem_data_o; 
output	[32-1:0]	mem_addr_o; 	
output				mem_enable_o; 
output				mem_write_o; 

//
// add your project1 here!


// Ports
wire[31:0]	inst_addr, inst;
wire[31:0]  pcPlus4;
wire[4:0]   writeReg;
wire    WB_RegWrite, MEM_RegWrite;
wire[31:0]  RSout, RTout;
wire[31:0]  signExtended, EXsignextended;
wire[31:0]  MUX1Res, JumpAddr, MUX7out;
wire ANDresult;
wire MUX2_sel;
wire[4:0] EXRT, MEMRD;
wire[3:0] EXEX;
wire[1:0] EXM, MEMWBcontrol;
wire[31:0] MEMALURes, MUX5Res;
wire[7:0] MUX8_o;
wire [1:0] MEMM;
wire [1:0] WBWB;
wire cache_stall;
assign JumpAddr = {MUX1Res[31:28], Shift_Left_26to28.data_o};
assign WB_RegWrite = WBWB[1];


Control Control(
    .Op_i(inst[31:26]),
    .Jump_o(MUX2_sel),
    .Branch_o(AND.branch_i),
    .Control_o(MUX8_8.signal_i)
);//DONE


Adder Add_PC(
    .data1_in   (inst_addr),
    .data2_in   (32'd4),
    .data_o     (pcPlus4)
);//DONE

Adder Add_Branch(
    .data1_in   (Shift_Left_32.data_o),
    .data2_in   (IFID.pc_o),
    .data_o     (MUX32_1.data2_i)
);//DONE



IFID IFID(
    .clk_i      (clk_i),
    .flush_i(OR.flush_o),
    .hazard_i(HazardDetection.IFIDhazard_o),
    .pc_i(pcPlus4),
    .inst_i(Instruction_Memory.instr_o),
    .pc_o(Add_Branch.data2_in),
    .inst_o(inst),
    .halt_i(cache_stall)
);//DONE

IDEX IDEX(
    .clk_i(clk_i),
    .WB_i(MUX8_o[7:6]),
    .M_i(MUX8_o[5:4]),
    .EX_i(MUX8_o[3:0]),
    .pc_i(),    //leave it empty
    .data1_i(RSout),
    .data2_i(RTout),
    .signextend_i(signExtended),
    .rs_i(inst[25:21]),
    .rt_i(inst[20:16]),
    .rd_i(inst[15:11]),
    .WB_o(EXMEM.WB_i),
    .M_o(EXM),
    .EX_o(EXEX),
    .data1_o(MUXforward_6.data_i),
    .data2_o(MUXforward_7.data_i),
    .signextend_o(EXsignextended),
    .rs_o(Forward_Unit.IDEX_RegisterRs_i),
    .rt_o(EXRT),
    .rd_o(MUX5_3.data2_i),
    .halt_i(cache_stall)
);//DONE
EXMEM EXMEM(
    .clk_i(clk_i),
    .WB_i(IDEX.WB_o),
    .M_i(EXM),
    .addr_i(ALU.data_o),
    .data_i(MUX7out),
    .rd_i(MUX5_3.data_o),
    .WB_o(MEMWBcontrol),
    .M_o(MEMM),
    .addr_o(MEMALURes),
    .data_o(dcache.p1_data_i),
    .rd_o(MEMRD),
    .halt_i(cache_stall)
);//DONE
MEMWB MEMWB(
    .clk_i(clk_i),
    .WB_i(MEMWBcontrol),
    .addr_i(MEMALURes),
    .data_i(dcache.p1_data_o),
    .rd_i(MEMRD),
    .WB_o(WBWB),
    .addr_o(MUX32_5.data1_i),
    .data_o(MUX32_5.data2_i),
    .rd_o(writeReg),
    .halt_i(cache_stall)
);//DONE
Forward_Unit Forward_Unit(
    .EXMEM_RegWrite_i(MEMWBcontrol[1]),
    .EXMEM_RegisterRd_i(MEMRD),
    .MEMWB_RegWrite_i(WB_RegWrite),
    .MEMWB_RegisterRd_i(writeReg),
    .IDEX_RegisterRs_i(IDEX.rs_o),
    .IDEX_RegisterRt_i(EXRT),
    .ForwardA_o(MUXforward_6.select_i),
    .ForwardB_o(MUXforward_7.select_i)  
);//DONE
HazardDetection HazardDetection(
    .inst_i(inst), 
    .EXregRTaddr_i(EXRT), 
    .EXmemRead_i(EXM[1]), 
    .pchazard_o(PC.pchazard_i), 
    .IFIDhazard_o(IFID.hazard_i), 
    .mux8select_o(MUX8_8.harzard_i)
);//DONE

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr),
    .instr_o    (IFID.inst_i)
);//DONE

MUX32 MUX32_1(
    .data1_i(pcPlus4),
    .data2_i(Add_Branch.data_o),
    .select_i(ANDresult),
    .data_o(MUX1Res)
);//DONE
MUX32 MUX32_2(
    .data1_i(MUX1Res),
    .data2_i(JumpAddr),
    .select_i(MUX2_sel),
    .data_o(PC.pc_i)
);//DONE
MUX5 MUX5_3(
    .data1_i    (EXRT),
    .data2_i    (IDEX.rd_o),
    .select_i   (EXEX[0]),
    .data_o     (EXMEM.rd_i)
);//DONE
MUX32 MUX32_4(
    .data1_i    (MUX7out),
    .data2_i    (EXsignextended),
    .select_i   (EXEX[3]),
    .data_o     (ALU.data2_i)
);//DONE
MUX32 MUX32_5(
    .data1_i(MEMWB.addr_o),
    .data2_i(MEMWB.data_o),
    .select_i(WBWB[0]),
    .data_o(MUX5Res)
);//DONE
MUX_forward MUXforward_6(
    .select_i(Forward_Unit.ForwardA_o),
    .data_i(IDEX.data1_o),
    .forward_EM_i(MEMALURes),
    .forward_MW_i(MUX5Res),
    .data_o(ALU.data1_i)
);//DONE
MUX_forward MUXforward_7(
    .select_i(Forward_Unit.ForwardB_o),
    .data_i(IDEX.data2_o),
    .forward_EM_i(MEMALURes),
    .forward_MW_i(MUX5Res),
    .data_o(MUX7out)
);//DONE
MUX8 MUX8_8(
    .harzard_i(HazardDetection.mux8select_o),
    .signal_i(Control.Control_o),
    .signal_o(MUX8_o)
);//DONE
Equal Equal(
    .data1_i(RSout),
    .data2_i(RTout),
    .eq_o(AND.eq_i)
);//DONE
Shift_Left_32 Shift_Left_32(
    .data_i(signExtended),
    .data_o(Add_Branch.data1_in)  
);//DONE

Shift_Left_26to28 Shift_Left_26to28(
    .data_i(inst[25:0]),
    .data_o()  
);//DONE

AND AND(
    .eq_i(Equal.eq_o),
    .branch_i(Control.Branch_o),
    .select_o(ANDresult)
);//DONE

OR OR(
    .jump_i(MUX2_sel),
    .branch_i(ANDresult),
    .flush_o(IFID.flush_i)
);//DONE


Sign_Extend Sign_Extend(
    .data_i     (inst[15:0]),
    .data_o     (signExtended)
);//DONE
  
ALU ALU(
    .data1_i    (MUXforward_6.data_o),
    .data2_i    (MUX32_4.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     (EXMEM.addr_i),
    .Zero_o     ()
);//DONE

ALU_Control ALU_Control(
    .funct_i    (EXsignextended[5:0]),
    .ALUOp_i    (EXEX[2:1]),
    .ALUCtrl_o  (ALU.ALUCtrl_i)
);//DONE



// project 1 end


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pchazard_i (HazardDetection.pchazard_o),
    .halt_i		(cache_stall),
    .pc_i       (MUX32_2.data_o),
    .pc_o       (inst_addr)
);//DONE

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst[25:21]),
    .RTaddr_i   (inst[20:16]),
    .RDaddr_i   (writeReg),
    .RDdata_i   (MUX5Res),
    .RegWrite_i (WB_RegWrite),
    .RSdata_o   (RSout),
    .RTdata_o   (RTout)
);//DONE
//data cache
dcache_top dcache
(
    // System clock, reset and stall
	.clk_i(clk_i), 
	.rst_i(rst_i),
	
	// to Data Memory interface		
	.mem_data_i(mem_data_i), 
	.mem_ack_i(mem_ack_i), 	
	.mem_data_o(mem_data_o), 
	.mem_addr_o(mem_addr_o), 	
	.mem_enable_o(mem_enable_o), 
	.mem_write_o(mem_write_o), 
	
	// to CPU interface	
	.p1_data_i(EXMEM.data_o), 
	.p1_addr_i(MEMALURes), 	
	.p1_MemRead_i(MEMM[1]), 
	.p1_MemWrite_i(MEMM[0]), 
	.p1_data_o(MEMWB.data_i), 
	.p1_stall_o(cache_stall)
);

// Data_Memory Data_Memory(
//     .addr_i(MEMALURes),
//     .writedata_i(EXMEM.data_o),
//     .memread_i(MEMM[1]),
//     .memwrite_i(MEMM[0]), 
//     .readdata_o(MEMWB.data_i)
// ); //DONE
endmodule