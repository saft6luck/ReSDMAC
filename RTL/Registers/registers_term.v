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

module registers_term(
    input CLK,
    input AS_,
    input DMAC_,
    input WDREGREQ,
    input h_0C, 

    output reg REG_DSK_
);

reg [2:0] TERM_COUNTER;

wire CYCLE_ACTIVE;

`ifdef __ICARUS__ 
  //allows sdmac to terminate writes to ACR in Ramsey for testing
  assign CYCLE_ACTIVE = ~(AS_| DMAC_ | WDREGREQ);
`else
  assign CYCLE_ACTIVE = ~(AS_| DMAC_ | WDREGREQ | h_0C);
`endif   

always @(posedge CLK) begin
  if (AS_)
    TERM_COUNTER <= 3'b000;
  else if (CYCLE_ACTIVE) 
      TERM_COUNTER <=  TERM_COUNTER + 1'b1;
end

always @(negedge CLK or posedge AS_) begin
  if (AS_)
    REG_DSK_ <= 1'b1;
  else if (TERM_COUNTER == 3'd3)
      REG_DSK_ <= 1'b0;   
end

endmodule