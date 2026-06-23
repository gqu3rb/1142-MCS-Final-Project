.title SRAM and Sense Amplifier Simulation
*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm'
.include '6to64_row_decoder.sp'
.unprotect 

*****************************
**       SubCircuit        **
*****************************
* Do not modify the SRAM cell circuit.
.subckt SRAM WL BL BLB q qb
Mpr  q   qb  VDD  VDD  pmos_sram  m=1
Mnr  q   qb  GND  GND  nmos_sram  m=1

Mpl  qb  q  VDD  VDD  pmos_sram  m=1
Mnl  qb  q  GND  GND  nmos_sram  m=1

Mnpr BL  WL  q    GND  nmos_sram  m=1
Mnpl BLB WL  qb   GND  nmos_sram  m=1
.ends

.subckt precharge BL BLB pre
Mpre_p1 BLB  pre  VDD VDD pmos_lvt  m=1
Mpre_p2 BL   pre  VDD VDD pmos_lvt  m=1
Mpre_p3 BLB  pre  BL  VDD pmos_lvt  m=1

.ends

.subckt current_SA BL BLB sense senseb SAEN
Mn0  net0   SAEN   GND   GND  nmos_lvt  m=4

Mn1  net1   BL     net0  GND  nmos_lvt  m=2
Mn2  net2   BLB    net0  GND  nmos_lvt  m=2

Mn3  senseb   sense    net1  GND  nmos_lvt  m=3 
Mn4  sense    senseb   net2  GND  nmos_lvt  m=3 

Mp5  senseb   SAEN   VDD   VDD  pmos_lvt  m=2
Mp6  senseb   sense  VDD   VDD  pmos_lvt  m=2 
Mp7  sense    senseb VDD   VDD  pmos_lvt  m=2 
Mp8  sense    SAEN   VDD   VDD  pmos_lvt  m=2	

.ends

.subckt voltage_SA BL BLB sense senseB SAEN
Mn0  net0    SAEN    GND   GND  nmos_lvt  m=4 

Mn1  senseB  sense   net0  GND  nmos_lvt  m=2 
Mn2  sense   senseB  net0  GND  nmos_lvt  m=2 

Mp3  senseB  sense   VDD   VDD  pmos_lvt  m=2 
Mp4  sense   senseB  VDD   VDD  pmos_lvt  m=2 
Mp5  sense   SAEN    BL    VDD  pmos_lvt  m=2 
Mp6  senseB  SAEN    BLB   VDD  pmos_lvt  m=2 

.ends


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


xcell0  WL0  BL BLB q0  qb0  SRAM

xcell1  WL1  BL BLB q1  qb1  SRAM
xcell2  WL2  BL BLB q2  qb2  SRAM
xcell3  WL3  BL BLB q3  qb3  SRAM
xcell4  WL4  BL BLB q4  qb4  SRAM
xcell5  WL5  BL BLB q5  qb5  SRAM
xcell6  WL6  BL BLB q6  qb6  SRAM
xcell7  WL7  BL BLB q7  qb7  SRAM
xcell8  WL8  BL BLB q8  qb8  SRAM
xcell9  WL9  BL BLB q9  qb9  SRAM
xcell10 WL10 BL BLB q10 qb10 SRAM
xcell11 WL11 BL BLB q11 qb11 SRAM
xcell12 WL12 BL BLB q12 qb12 SRAM
xcell13 WL13 BL BLB q13 qb13 SRAM
xcell14 WL14 BL BLB q14 qb14 SRAM
xcell15 WL15 BL BLB q15 qb15 SRAM
xcell16 WL16 BL BLB q16 qb16 SRAM
xcell17 WL17 BL BLB q17 qb17 SRAM
xcell18 WL18 BL BLB q18 qb18 SRAM
xcell19 WL19 BL BLB q19 qb19 SRAM
xcell20 WL20 BL BLB q20 qb20 SRAM
xcell21 WL21 BL BLB q21 qb21 SRAM
xcell22 WL22 BL BLB q22 qb22 SRAM
xcell23 WL23 BL BLB q23 qb23 SRAM
xcell24 WL24 BL BLB q24 qb24 SRAM
xcell25 WL25 BL BLB q25 qb25 SRAM
xcell26 WL26 BL BLB q26 qb26 SRAM
xcell27 WL27 BL BLB q27 qb27 SRAM
xcell28 WL28 BL BLB q28 qb28 SRAM
xcell29 WL29 BL BLB q29 qb29 SRAM
xcell30 WL30 BL BLB q30 qb30 SRAM
xcell31 WL31 BL BLB q31 qb31 SRAM
xcell32 WL32 BL BLB q32 qb32 SRAM
xcell33 WL33 BL BLB q33 qb33 SRAM
xcell34 WL34 BL BLB q34 qb34 SRAM
xcell35 WL35 BL BLB q35 qb35 SRAM
xcell36 WL36 BL BLB q36 qb36 SRAM
xcell37 WL37 BL BLB q37 qb37 SRAM
xcell38 WL38 BL BLB q38 qb38 SRAM
xcell39 WL39 BL BLB q39 qb39 SRAM
xcell40 WL40 BL BLB q40 qb40 SRAM
xcell41 WL41 BL BLB q41 qb41 SRAM
xcell42 WL42 BL BLB q42 qb42 SRAM
xcell43 WL43 BL BLB q43 qb43 SRAM
xcell44 WL44 BL BLB q44 qb44 SRAM
xcell45 WL45 BL BLB q45 qb45 SRAM
xcell46 WL46 BL BLB q46 qb46 SRAM
xcell47 WL47 BL BLB q47 qb47 SRAM
xcell48 WL48 BL BLB q48 qb48 SRAM
xcell49 WL49 BL BLB q49 qb49 SRAM
xcell50 WL50 BL BLB q50 qb50 SRAM
xcell51 WL51 BL BLB q51 qb51 SRAM
xcell52 WL52 BL BLB q52 qb52 SRAM
xcell53 WL53 BL BLB q53 qb53 SRAM
xcell54 WL54 BL BLB q54 qb54 SRAM
xcell55 WL55 BL BLB q55 qb55 SRAM
xcell56 WL56 BL BLB q56 qb56 SRAM
xcell57 WL57 BL BLB q57 qb57 SRAM
xcell58 WL58 BL BLB q58 qb58 SRAM
xcell59 WL59 BL BLB q59 qb59 SRAM
xcell60 WL60 BL BLB q60 qb60 SRAM
xcell61 WL61 BL BLB q61 qb61 SRAM
xcell62 WL62 BL BLB q62 qb62 SRAM
xcell63 WL63 BL BLB q63 qb63 SRAM

xpre BL BLB PRE precharge

*xSA BL BLB sense senseb SAEN current_SA

xSA BL BLB sense senseB SAEN voltage_SA 

Mnwd_bl  BL  WEN_BL  GND GND nmos_sram m = 4
Mnwd_blb BLB WEN_BLB GND GND nmos_sram m = 4


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
VA1 A1 GND PULSE   ( 0V  0.7V  0ns  0.05ns  0.05ns  5ns    10ns  )
VA2 A2 GND PULSE   ( 0V  0.7V  0ns  0.05ns  0.05ns  10ns   20ns  )
VA3 A3 GND PULSE   ( 0V  0.7V  0ns  0.05ns  0.05ns  20ns   40ns  )
VA4 A4 GND PULSE   ( 0V  0.7V  0ns  0.05ns  0.05ns  40ns   80ns  )
VA5 A5 GND PULSE   ( 0V  0.7V  0ns  0.05ns  0.05ns  80ns   160ns )
VA6 A6 GND PULSE   ( 0V  0.7V  0ns  0.05ns  0.05ns  160ns  320ns )

Vp PRE  GND PULSE  ( 0V  0.7V 4ns  0.05ns  0.05ns  0.35ns  5ns )
Vs SAEN GND 0V

Vwen_blb WEN_BLB GND PULSE  ( 0V  0.7V  4ns  0.05ns  0.05ns  0.3ns   5ns )
Vwen_bl  WEN_BL  GND 0V

* Do not modify above *

*****************************
**    Initial Conditions   **
*****************************
* Do not modify the initial conditions for BL and BLB, which are both 0V.
* We assume there is no initial voltage on the bitlines before precharge.
.ic v(BL)  = 0v
.ic v(BLB) = 0v

* You should set the initial conditions for q and qb in the SRAM.
* q should be 0V and qb should be 0.7V, which means the SRAM cell is storing "0".
.ic v(q0) = 0v
.ic v(qb0) = 0.7v

*****************************
**    Simulator setting    **
*****************************
.op
.option post 
.options probe
.probe v(*) i(*)

* Do Not Modify !!!
.tran 0.05ns 320ns 

*read model
*.measure tp
*+ TRIG v(SAEN) VAL='0.35' rise=1
*+ TARG v(sense) VAL='0.35' fall=1

*write model
.measure tp_write
+ TRIG v(WL) VAL='0.35' rise=1
+ TARG v(q0) VAL='0.35' rise=1


.measure TRAN Avg_read_pwr avg POWER from=4n to=5n

.end

