 /*
// 
// Copyright (C) 2022  Mike Taylor
// This file is part of RE-SDMAC <https://github.com/mbtaylor1982/RE-SDMAC>.
// 
// RE-SDMAC is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// RE-SDMAC is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with dogtag.  If not, see <http://www.gnu.org/licenses/>.
 */
 `ifdef __ICARUS__ 
    `include "SCSI_SM.v"
    `include "fifo.v"
    `include "CPU_SM.v"
    `include "registers.v"
    `include "datapath.v"
    `include "PLL.v"
`endif

module RESDMAC(
    output tri0 INT,                //Connected to INT2 via open collector transistor.
    output tri0 _SIZ1,              //Indicates a 16 bit transfer if False. 

    inout tri1 R_W_IO,              //Read Write from CPU
    inout tri1 _AS_IO,              //Address Strobe
    inout tri1 _DS_IO,              //Data Strobe 
    
    input tri1 [1:0] DSACK_I_,      //Dynamic size and DATA ack input.
    output tri0 [1:0] DSACK_O,      //Dynamic size and DATA ack output.
   
    inout tri1 [31:0] DATA_IO,      // CPU side data bus 32bit wide

    input tri1 _STERM,              //static/synchronous data ack.
    input SCLK,                     //CPUCLKB
    input _CS,                      //_SCSI from Fat Garry
    input _RST,                     //System Reset
    input tri1 _BERR,               //Bus Error 
    input [6:2] ADDR,               //CPU address Bus, bits are actually [6:2]
    
    // Bus Mastering/Arbitration.
    output   BR,                   //Bus Request
    input    _BG,                   //Bus Grant
    inout   tri1 _BGACK_IO,         //Bus Grant Acknoledge

    output _DMAEN,                  //Low =  Enable Address Generator in Ramsey
    
    // Peripheral port signals
    input tri1 _DREQ,               //DMA Request From WD33c93A (SCSI) 
    input INTA,                     //Interupt from WD33c93A (SCSI)

    output _DACK,                   //DMA Acknoledge to WD33c93A (SCSI)
    output _CSS,                    //Port 0 CS    
    output _IOR,                    //Active Low read strobe
    output _IOW,                    //Ative Low Write strobe
    
    inout tri1 [15:0] PD_PORT,      //Peripheral Data port
    
    //Diagnostic LEDS
    output _LED_RD,                 //Indicated read from SDMAC or peripherial port.
    output _LED_WR,                 //Indicate write to SDMAC or peripherial port.
    output _LED_DMA,                //Indicate DMA cycle/busmaster.
	
    //level shifters control signals
    output OWN,                     //Active high signal to show SDMAC is bus master, This can be used to set direction on level shifters for control signals.
    output DATA_OE_,                //Active low ouput enable for DBUS level shifters.
    output PDATA_OE_                //Active low ouput enable for Peripheral BUS level shifters.
);

reg AS_O_;
wire AS_I_;
assign AS_I_ = _AS_IO; 
assign _AS_IO = CPUSM_BGACK ? AS_O_: 1'bz;

reg DS_O_;
wire DS_I_;
assign DS_I_ = _DS_IO;
assign _DS_IO = CPUSM_BGACK ? DS_O_ : 1'bz;

wire R_W;
assign R_W = R_W_IO;
assign  R_W_IO = CPUSM_BGACK ? ~DMADIR : 1'bz;

wire [31:0] DATA_I;
wire [31:0] DATA_O;
assign DATA_I = DATA_IO;
assign DATA_IO = DATA_OE_ ? DATA_O : 32'hzzzzzzzz;

wire [15:0] PDATA_I;
wire [15:0] PDATA_O;
assign PDATA_I = PD_PORT;
assign PD_PORT = _IOW ? 16'hzzzz: PDATA_O;


reg LLW;
reg LHW;

wire [31:0] MID;
wire [31:0] REG_OD;

wire [31:0] FIFO_ID;
wire [31:0] FIFO_OD;

wire CLK45, CLK90, CLK135;
wire PLLLOCKED;

wire LBYTE_;
wire RE_o;
wire DACK_o;
wire BOEQ3;
wire PRESET; // Peripherial Reset Sets IOR_ and IOW_ active to reset SCSI IC
wire WE;
wire RE;
wire SCSI_CS;
wire LS2CPU;
wire DREQ_;
wire INCNO;
wire INCNI;
wire _INT;
wire DSACK_CPU_SM;
wire STOPFLUSH;
wire FIFOEMPTY;
wire FIFOFULL;
wire FLUSHFIFO;
wire ACR_WR;
wire H_0C;
wire A1;
wire DMADIR;
wire DMAENA;
wire REG_DSK_;
wire WDREGREQ;
wire PAS;
wire PDS;
wire CPUSM_BGACK;
wire BREQ;
wire SIZE1_CPUSM;
wire F2CPUL;
wire F2CPUH;
wire BRIDGEIN;
wire BRIDGEOUT;
wire DIEH;
wire DIEL;
wire RDFIFO_o;
wire DECFIFO;
wire RIFIFO_o;
wire INCFIFO;
wire INCNO_CPU;
wire INCNI_CPU;
wire PLLW;
wire PLHW;
wire INCBO;
wire INCNO_SCSI;
wire INCNI_SCSI;
wire S2F;
wire F2S;
wire S2CPU;
wire CPU2S;
wire BOEQ0;
wire BO0;
wire BO1;
wire A3;
wire DSK0_IN_;
wire DSK1_IN_;
tri1 _BGACK_I;

registers u_registers(
    .ADDR      ({1'b0, ADDR, 2'b00}),
    .DMAC_     (_CS       ),
    .AS_       (AS_I_       ),
    .RW        (R_W       ),
    .CLK       (CLK45     ),
    .MID       (MID       ),
    .STOPFLUSH (STOPFLUSH ),
    .RST_      (PLLLOCKED ),
    .FIFOEMPTY (FIFOEMPTY ),
    .FIFOFULL  (FIFOFULL  ),
    .INTA_I    (INTA      ),
    .REG_OD    (REG_OD    ),
    .PRESET    (PRESET    ),
    .FLUSHFIFO (FLUSHFIFO ),
    .ACR_WR    (ACR_WR    ),
    .h_0C      (H_0C      ),
    .A1        (A1        ),
    .INT_O_    (_INT      ),
    .DMADIR    (DMADIR    ),
    .DMAENA    (DMAENA    ),
    .REG_DSK_  (REG_DSK_  ),
    .WDREGREQ  (WDREGREQ  )
);

CPU_SM u_CPU_SM(
    .PAS           (PAS         ),
    .PDS           (PDS         ),
    .BGACK         (CPUSM_BGACK ),
    .BREQ          (BREQ        ),
    .aBGRANT_      (_BG         ),
    .SIZE1         (SIZE1_CPUSM ),
    .aRESET_       (PLLLOCKED   ),
    .iSTERM_       (_STERM      ),
    .DSACK0_       (DSK0_IN_    ),
    .DSACK1_       (DSK1_IN_    ),
    .CLK45         (CLK45       ), 
    .CLK90         (CLK90       ), 
    .CLK135        (CLK135      ), 
    .DMADIR        (DMADIR      ),
    .A1            (A1          ),
    .F2CPUL        (F2CPUL      ),
    .F2CPUH        (F2CPUH      ),
    .BRIDGEIN      (BRIDGEIN    ),
    .BRIDGEOUT     (BRIDGEOUT   ),
    .DIEH          (DIEH        ),
    .DIEL          (DIEL        ),
    .BOEQ0         (BOEQ0       ),
    .BOEQ3         (BOEQ3       ),
    .FIFOFULL      (FIFOFULL    ),
    .FIFOEMPTY     (FIFOEMPTY   ),
    .RDFIFO_       (~RDFIFO_o    ),
    .DECFIFO       (DECFIFO     ),
    .RIFIFO_       (~RIFIFO_o    ),
    .INCFIFO       (INCFIFO     ),
    .INCNO         (INCNO_CPU   ),
    .INCNI         (INCNI_CPU   ),
    .aDREQ_        (DREQ_       ),
    .aFLUSHFIFO    (FLUSHFIFO   ),
    .STOPFLUSH     (STOPFLUSH   ),
    .aDMAENA       (DMAENA      ),
    .PLLW          (PLLW        ),
    .PLHW          (PLHW        ),
    .AS_           (AS_I_         ),
    .BGACK_I_      (_BGACK_I    )

);

SCSI_SM u_SCSI_SM(
    .CPUREQ    (WDREGREQ    ),
    .RW        (R_W         ),
    .DMADIR    (DMADIR      ),
    .INCFIFO   (INCFIFO     ),
    .DECFIFO   (DECFIFO     ),
    .RESET_    (PLLLOCKED   ),
    .BOEQ3     (BOEQ3       ),
    .CLK45     (CLK45       ), 
    .CLK90     (CLK90       ), 
    .CLK135    (CLK135      ), 
    .DREQ_     (DREQ_       ),
    .FIFOFULL  (FIFOFULL    ),
    .FIFOEMPTY (FIFOEMPTY   ),
    .AS_       (AS_I_        ),
    .RDFIFO_o  (RDFIFO_o    ),
    .RIFIFO_o  (RIFIFO_o    ),
    .RE_o      (RE          ),
    .WE_o      (WE          ),
    .SCSI_CS_o (SCSI_CS     ),
    .DACK_o    (DACK_o      ),
    .INCBO_o   (INCBO       ),
    .INCNO_o   (INCNO_SCSI  ),
    .INCNI_o   (INCNI_SCSI  ),
    .S2F_o     (S2F         ),
    .F2S_o     (F2S         ),
    .S2CPU_o   (S2CPU       ),
    .CPU2S_o   (CPU2S       ),
    .LS2CPU    (LS2CPU      ),
    .LBYTE_    (LBYTE_      )
);

fifo int_fifo(
    .CLK         (SCLK      ), 
    .CLK90       (CLK90     ), 
    .CLK135      (CLK135    ), 
    .LLWORD      (LLW       ),
    .LHWORD      (LHW       ),
    .LBYTE_      (LBYTE_    ),
    .H_0C        (H_0C      ),
    .ACR_WR      (ACR_WR    ),
    .RST_FIFO_   (DMAENA    ),
    .MID25       (MID[25]   ),
    .FIFO_ID     (FIFO_ID   ),
    .FIFOFULL    (FIFOFULL  ),
    .FIFOEMPTY   (FIFOEMPTY ),
    .INCFIFO     (INCFIFO   ),
    .DECFIFO     (DECFIFO   ),
    .INCBO       (INCBO     ),
    .BOEQ0       (BOEQ0     ),
    .BOEQ3       (BOEQ3     ),
    .BO0         (BO0       ),
    .BO1         (BO1       ),
    .INCNO       (INCNO     ),
    .INCNI       (INCNI     ),
    .FIFO_OD     (FIFO_OD   )
);

datapath u_datapath(
    .CLK       (SCLK        ), 
    .CLK90     (CLK90       ), 
    .CLK135    (CLK135      ), 
    .DATA_I    (DATA_I      ),
    .DATA_O    (DATA_O      ),
    .PD_IN     (PDATA_I     ),
    .PD_OUT    (PDATA_O     ),
    .FIFO_OD   (FIFO_OD     ),
    .REG_OD    (REG_OD      ),
    .PAS       (PAS         ),
    .DS_I_     (DS_I_       ),
    .nDMAC_    (~_CS        ),
    .RW        (R_W         ),
    .nOWN_     (CPUSM_BGACK ),
    .DMADIR    (DMADIR      ),
    .BRIDGEIN  (BRIDGEIN    ),
    .BRIDGEOUT (BRIDGEOUT   ),
    .DIEH      (DIEH        ),
    .DIEL      (DIEL        ),
    .LS2CPU    (LS2CPU      ),
    .S2CPU     (S2CPU       ),
    .S2F       (S2F         ),
    .F2S       (F2S         ),
    .CPU2S     (CPU2S       ),
    .BO0       (BO0         ),
    .BO1       (BO1         ),
    .A3        (A3          ),
    .MID       (MID         ),
    .FIFO_ID   (FIFO_ID     ),
    .F2CPUL    (F2CPUL      ),
    .F2CPUH    (F2CPUH      ),
    .DS_O_     (DS_O_       ),
    .DATA_OE_  (DATA_OE_    )
);

PLL u_PLL (
    .RST        (~_RST    ),
    .CLK        (SCLK     ),
    .CLK45      (CLK45    ),
    .CLK90      (CLK90    ),
    .CLK135     (CLK135   ),
    .LOCKED     (PLLLOCKED)
);


always @(negedge SCLK) begin
    AS_O_   <= ~PAS;    
    DS_O_   <= ~PDS; 
    LLW     <= PLLW;
    LHW     <= PLHW;
end

assign OWN = CPUSM_BGACK; 
assign _BGACK_I =  _BGACK_IO;

//System Outputs
assign _DMAEN = ~CPUSM_BGACK;
assign  BR = BREQ ?  1'b1 : 1'b0;
assign _BGACK_IO = ~CPUSM_BGACK ? 1'bz : 1'b0;
assign _SIZ1 = ~CPUSM_BGACK ? 1'b1 : ~SIZE1_CPUSM;

assign DSACK_O = (REG_DSK_ & LS2CPU) ? 2'b00 : 2'b11;


//SCSI outputs
assign _IOR = ~(PRESET | RE);
assign _IOW = ~(PRESET | WE);
assign _CSS = ~ SCSI_CS;
assign _DACK = ~ DACK_o;

//Diagnostic LEDs
assign _LED_WR = ~CPUSM_BGACK ? (R_W | AS_I_ | _CS) : DMADIR;
assign _LED_RD = ~CPUSM_BGACK ? (~R_W | AS_I_ | _CS): ~DMADIR;
assign _LED_DMA = ~CPUSM_BGACK; 

//internal connections
assign DREQ_ = (~DMAENA | _DREQ);
assign INCNO = (INCNO_CPU | INCNO_SCSI);
assign INCNI = (INCNI_CPU | INCNI_SCSI);

assign DSK0_IN_ = _BERR & DSACK_I_[0];
assign DSK1_IN_ = _BERR & DSACK_I_[1];

assign A3 = ADDR[3];

assign PDATA_OE_ = (_DACK & _CSS);

assign INT = ~_INT;

// the "macro" to dump signals
`ifdef COCOTB_SIM
initial begin
  $dumpfile ("resdmac.vcd");
  $dumpvars (0, RESDMAC);
  #1;
end
`endif

endmodule


