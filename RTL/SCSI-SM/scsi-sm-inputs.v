/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */

module \scsi-sm-inputs  (
  input scsidff1_q,
  input scsidff2_q,
  input scsidff3_q,
  input scsidff4_q,
  input scsidff5_q,
  input BOEQ3,
  input CCPUREQ,
  input CDREQ_,
  input CDSACK_,
  input DMADIR,
  input FIFOEMPTY,
  input FIFOFULL,
  input RDFIFO_o,
  input RIFIFO_o,
  input RW,
  output E0_,
  output E1_,
  output E2_,
  output E3_,
  output E4_,
  output E5_,
  output E6_,
  output E7_,
  output E8_,
  output E9_,
  output E10_,
  output E11_,
  output E12_,
  output E13_,
  output E14_,
  output E15_,
  output E16_,
  output E17_,
  output E18_,
  output E19_,
  output E20_,
  output E21_,
  output E22_,
  output E23_,
  output E24_,
  output E25_,
  output E26_,
  output E27_
);
  wire s0;
  wire s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  wire s6;
  assign E0_ = ~ (~ (CCPUREQ | CDREQ_ | DMADIR | FIFOEMPTY | RDFIFO_o | scsidff1_q | scsidff2_q | scsidff4_q) & scsidff5_q);
  assign E17_ = ~ (scsidff2_q & scsidff3_q & scsidff4_q & scsidff5_q);
  assign E25_ = ~ (scsidff1_q & scsidff2_q & scsidff5_q);
  assign s6 = ~ CDSACK_;
  assign s0 = ~ DMADIR;
  assign s1 = ~ scsidff1_q;
  assign s2 = ~ scsidff2_q;
  assign s3 = ~ scsidff3_q;
  assign s4 = ~ scsidff4_q;
  assign s5 = ~ scsidff5_q;
  assign E2_ = ~ (FIFOFULL & s1 & s2 & s3 & scsidff4_q & scsidff5_q);
  assign E3_ = ~ (BOEQ3 & scsidff1_q & s2 & s4 & s5);
  assign E4_ = ~ (BOEQ3 & s2 & scsidff3_q & scsidff4_q & s5);
  assign E5_ = ~ (~ CCPUREQ & s0 & s2 & s3 & s4);
  assign E6_ = ~ (CCPUREQ & s1 & s2 & s3 & s4);
  assign E7_ = ~ (~ FIFOFULL & s1 & s2 & s3 & scsidff4_q & scsidff5_q);
  assign E8_ = ~ (~ RW & s1 & s2 & s3 & scsidff4_q & s5);
  assign E9_ = ~ (s1 & scsidff2_q & s3 & s4 & scsidff5_q);
  assign E10_ = ~ (s2 & scsidff3_q & scsidff4_q & s5);
  assign E11_ = ~ (scsidff1_q & s2 & s4 & s5);
  assign E12_ = ~ (RW & s1 & s3 & scsidff4_q & s5);
  assign E13_ = ~ (s1 & scsidff2_q & s3 & s4 & s5);
  assign E14_ = ~ (s6 & scsidff2_q & scsidff4_q & s5);
  assign E15_ = ~ (scsidff2_q & scsidff3_q & s4 & scsidff5_q);
  assign E16_ = ~ (s2 & scsidff3_q & scsidff4_q & scsidff5_q);
  assign E18_ = ~ (scsidff2_q & s3 & scsidff4_q & scsidff5_q);
  assign E19_ = ~ (s6 & scsidff1_q & scsidff4_q);
  assign E20_ = ~ (s2 & scsidff3_q & s4 & scsidff5_q);
  assign E21_ = ~ (s2 & scsidff3_q & s4 & s5);
  assign E22_ = ~ (scsidff2_q & scsidff3_q & s4 & s5);
  assign E23_ = ~ (scsidff1_q & scsidff4_q & s5);
  assign E24_ = ~ (scsidff1_q & s2 & s4 & scsidff5_q);
  assign E26_ = ~ (scsidff1_q & scsidff2_q & s5);
  assign E27_ = ~ (scsidff2_q & s3 & scsidff4_q & s5);
  assign E1_ = ~ (~ (CCPUREQ | CDREQ_ | s0 | FIFOFULL | RIFIFO_o | scsidff1_q | scsidff2_q | scsidff4_q) & s3 & s5);
endmodule
