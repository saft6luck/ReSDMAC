`ifdef __ICARUS__ 
  `include "fifo_write_strobes.v"
  `include "fifo_full_empty_ctr.v"
  `include "fifo_3bit_cntr.v"
  `include "fifo_byte_ptr.v"
`endif

module fifo(
    
    input CLK, CLK90, CLK135, //Clocks

    input LLWORD,       //Load Lower Word strobe from CPU sm
    input LHWORD,       //Load Higher Word strobe from CPU sm
    
    input LBYTE_,       //Load Byte strobe from SCSI SM = !(DACK.o & RE.o)

    input H_0C,         //Address Decode for $0C ACR register
    input ACR_WR,       //indicate write to ACR?
    input RST_FIFO_,    //Reset FIFO
    input MID25,        //think this may be checking A1 in the ACR to make sure BYTE PTR is initialised to the correct value.

    input [31:0] FIFO_ID,    //FIFO Data Input

    output FIFOFULL,    //Signal FIFO is FULL
    output FIFOEMPTY,   //Signal FIFO is Empty

    input INCFIFO,      //Inc FIFO from CPU sm
    input DECFIFO,      //Dec FIFO from CPU sm

    input INCBO,        //Inc Byte Pointer from SCSI SM.

    output BOEQ0,       //True when BytePtr indicates 1st Byte
    output BOEQ3,       //True when BytePtr indicates 4th Byte

    output BO0,         //BytePtr Bit 0
    output BO1,         //BytePtr Bit 1

    input INCNO,        //Inc Next Out (Write Pointer)
    input INCNI,        //Inc Next In (Read Pointer)

    output reg [31:0] FIFO_OD    //FIFO Data Output
);

wire [2:0] WRITE_PTR;
wire [2:0] READ_PTR;
wire [1:0] BYTE_PTR;
wire UUWS;
wire UMWS;
wire LMWS;
wire LLWS;

fifo_write_strobes u_write_strobes(
    .PTR    (BYTE_PTR ),
    .LHWORD (LHWORD   ),
    .LLWORD (LLWORD   ),
    .LBYTE_ (LBYTE_   ),
    .UUWS   (UUWS     ),
    .UMWS   (UMWS     ),
    .LMWS   (LMWS     ),
    .LLWS   (LLWS     )
);

fifo__full_empty_ctr u_full_empty_ctr(
    .CLK       (CLK       ),
    .CLK135    (CLK135    ),
    .INCFIFO   (INCFIFO   ),
    .DECFIFO   (DECFIFO   ),
    .RST_FIFO_ (RST_FIFO_ ),
    .FIFOEMPTY (FIFOEMPTY ),
    .FIFOFULL  (FIFOFULL  )
);

//Next In Write Counter
fifo_3bit_cntr u_next_in_cntr(
    .CLK       (CLK135    ),
    .ClKEN     (INCNI     ),
    .RST_      (RST_FIFO_ ),
    .COUNT     (WRITE_PTR )
);

//Next Out Read Counter
fifo_3bit_cntr u_next_out_cntr(
    .CLK       (CLK135    ),
    .ClKEN     (INCNO     ),
    .RST_      (RST_FIFO_ ),
    .COUNT     (READ_PTR  )
);

//BYTE POINTER
fifo_byte_ptr u_byte_ptr(
  .CLK       (CLK135    ),
  .INCBO     (INCBO     ),
  .MID25     (MID25     ),
  .ACR_WR    (ACR_WR    ),
  .H_0C      (H_0C      ),
  .RST_FIFO_ (RST_FIFO_ ),
  .PTR       (BYTE_PTR  )
);

assign BO0 = BYTE_PTR[0];
assign BO1 = BYTE_PTR[1];

assign BOEQ0 = (BYTE_PTR == 2'b00);
assign BOEQ3 = (BYTE_PTR == 2'b11);

//32 byte FIFO buffer (8 x 32 bit long words)
reg [31:0] BUFFER [7:0];
integer i;

//WRITE DATA TO FIFO BUFFER
always @(negedge CLK90 or negedge RST_FIFO_) begin
  if (~RST_FIFO_) begin
    for (i = 0; i < 8; i = i+1) begin
      BUFFER[i] <= 32'h00000000;
    end
  end
  else begin
    if (UUWS)
      BUFFER[WRITE_PTR][31:24] <= FIFO_ID[31:24];
    if (UMWS)
      BUFFER[WRITE_PTR][23:16] <= FIFO_ID[23:16];
    if (LMWS)
      BUFFER[WRITE_PTR][15:8] <= FIFO_ID[15:8];
    if (LLWS)
      BUFFER[WRITE_PTR][7:0] <= FIFO_ID[7:0];
  end
end

always @(posedge CLK) begin
  FIFO_OD <= BUFFER[READ_PTR];
end

// the "macro" to dump signals
`ifdef COCOTB_SIM1
initial begin
  $dumpfile ("fifo.vcd");
  $dumpvars (0, fifo);
  #1;
end
`endif

endmodule