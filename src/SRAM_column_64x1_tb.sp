.title SRAM and Sense Amplifier Simulation
*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm'
.include '6to64_row_decoder.sp'
.include 'SRAM_column_64x1.sp'
.unprotect 


*****************************
**   Circuit Description   **
*****************************
* 呼叫 Row Decoder (注意：引腳順序必須跟上面定義的完全一模一樣)
xdecoder A6 A5 A4 A3 A2 A1
+ WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15
+ WL16 WL17 WL18 WL19 WL20 WL21 WL22 WL23 WL24 WL25 WL26 WL27 WL28 WL29 WL30 WL31
+ WL32 WL33 WL34 WL35 WL36 WL37 WL38 WL39 WL40 WL41 WL42 WL43 WL44 WL45 WL46 WL47
+ WL48 WL49 WL50 WL51 WL52 WL53 WL54 WL55 WL56 WL57 WL58 WL59 WL60 WL61 WL62 WL63
+ ROW_DEC_6to64

xCOL0 
+ PRE SAEN SENSE_OUT SENSE_OUTB WEN_BL WEN_BLB VDD GND
+ WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15
+ WL16 WL17 WL18 WL19 WL20 WL21 WL22 WL23 WL24 WL25 WL26 WL27 WL28 WL29 WL30 WL31
+ WL32 WL33 WL34 WL35 WL36 WL37 WL38 WL39 WL40 WL41 WL42 WL43 WL44 WL45 WL46 WL47
+ WL48 WL49 WL50 WL51 WL52 WL53 WL54 WL55 WL56 WL57 WL58 WL59 WL60 WL61 WL62 WL63
+ SRAM_Column_64x1




*****************************
**     Voltage Source      **
*****************************
* Do not modify below *
.global VDD GND
.param  BITCAP = 10f

VVDD VDD GND 0.7v

CBLB BLB GND BITCAP
CBL  BL  GND BITCAP


*Read model voltage supply
*Vw WL   GND PULSE  ( 0V  0.7V     4ns  0.05ns  0.05ns  0.2ns   1ns )
*Vp PRE  GND PULSE  ( 0V  0.7V     4ns  0.05ns  0.05ns  0.35ns  1ns )
*Vs SAEN GND PULSE  ( 0V  0.7V  4.25ns  0.05ns  0.05ns  0.1ns   1ns )

*write model voltage supply
VA1 A1 GND 0V
VA2 A2 GND 0V
VA3 A3 GND 0V
VA4 A4 GND 0V
VA5 A5 GND 0V
VA6 A6 GND 0V

Vp PRE  GND PULSE  ( 0V  0.7V     4ns  0.05ns  0.05ns  0.35ns  1ns )
Vs SAEN GND 0V

Vwen_blb WEN_BLB GND PULSE  ( 0V  0.7V  4ns  0.05ns  0.05ns  0.3ns   1ns )
Vwen_bl  WEN_BL  GND 0V

* Do not modify above *

*****************************
**    Initial Conditions   **
*****************************
* Do not modify the initial conditions for BL and BLB, which are both 0V.
* We assume there is no initial voltage on the bitlines before precharge.
.ic v(xCOL0.BL)  = 0v
.ic v(xCOL0.BLB) = 0v

* You should set the initial conditions for q and qb in the SRAM.
* q should be 0V and qb should be 0.7V, which means the SRAM cell is storing "0".
.ic v(xCOL0.q0) = 0v
.ic v(xCOL0.qb0) = 0.7v

*****************************
**    Simulator setting    **
*****************************
.op
.option post 
.options probe
.probe v(*) i(*)

* Do Not Modify !!!
.tran 0.05ns 5ns 

*read model
*.measure tp
*+ TRIG v(SAEN) VAL='0.35' rise=1
*+ TARG v(sense) VAL='0.35' fall=1

*write model
.measure tp_write
+ TRIG v(WL0) VAL='0.35' rise=1
+ TARG v(xCOL0.q0) VAL='0.35' rise=1

.probe tran v(xCOL0.q0) v(xCOL0.qb0) v(xCOL0.BL) v(xCOL0.BLB)

.measure TRAN Avg_read_pwr avg POWER from=4n to=5n

.end

