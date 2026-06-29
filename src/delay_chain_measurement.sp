.TITLE Delay Chain Measurement
.protect
.include '7nm_TT.pm'
.unprotect

* for INV and BUF subckt
.include 'DFF.sp' 

* to sweep the latency of different NFIN_SIZE
.param N_FIN_TEST=1
.param VDD_VAL=0.7

.global VDD GND

VVDD VDD GND VDD_VAL
VVSS VSS GND 0V
VIN  IN  GND PULSE(0 VDD_VAL 1ns 50ps 50ps 2ns 4ns)

* 5 stage Delay Chain
xbuf1 IN  N1 BUF NFIN_SIZE=N_FIN_TEST
xbuf2 N1  N2 BUF NFIN_SIZE=N_FIN_TEST
xbuf3 N2  N3 BUF NFIN_SIZE=N_FIN_TEST
xbuf4 N3  N4 BUF NFIN_SIZE=N_FIN_TEST
xbuf5 N4  OUT BUF NFIN_SIZE=N_FIN_TEST

* add loading Fan-out 4
xload1 OUT L1 BUF NFIN_SIZE='N_FIN_TEST*4'

* measure the propagation delay from xbuf3 to xbuf5
.measure tran delay_rise TRIG v(N2) VAL=0.35 RISE=1 TARG v(OUT) VAL=0.35 RISE=1
.measure tran delay_fall TRIG v(N2) VAL=0.35 FALL=1 TARG v(OUT) VAL=0.35 FALL=1


*.op
*.option post
*.options probe
*.probe v(*)

.tran 1ps 4ns

.alter
.param N_FIN_TEST=2

.alter
.param N_FIN_TEST=128

.end