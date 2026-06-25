.title SRAM for one column
*****************************
**       SubCircuit        **
*****************************
* Do not modify the SRAM cell circuit.
.subckt SRAM WL BL BLB q qb VDD VSS VDD_W VSS_SUB
M0  qb  WL  BLB  VSS_SUB  nmos_sram  L=2e-08 W=2.7e-08 nfin=1
M1  qb  q   VSS  VSS_SUB  nmos_sram  L=2e-08 W=2.7e-08 nfin=1
M2  q   qb  VSS  VSS_SUB  nmos_sram  L=2e-08 W=2.7e-08 nfin=1
M3  q   WL  BL   VSS_SUB  nmos_sram  L=2e-08 W=2.7e-08 nfin=1

*PMOS
M4  q   qb  VDD  VDD_W    pmos_sram  L=2e-08 W=2.7e-08 nfin=1
M5  qb  q   VDD  VDD_W    pmos_sram  L=2e-08 W=2.7e-08 nfin=1
.ends

.subckt precharge BL BLB pre
Mpre_p1 BLB  pre  VDD VDD pmos_lvt  L=2e-08 W=2.7e-08 nfin=1
Mpre_p2 BL   pre  VDD VDD pmos_lvt  L=2e-08 W=2.7e-08 nfin=1
Mpre_p3 BLB  pre  BL  VDD pmos_lvt  L=2e-08 W=2.7e-08 nfin=1

.ends

.subckt current_SA BL BLB sense senseb SAEN
Mn0  net0   SAEN   GND   GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=4

Mn1  net1   BL     net0  GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=2
Mn2  net2   BLB    net0  GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=2

Mn3  senseb   sense    net1  GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=3 
Mn4  sense    senseb   net2  GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=3 

Mp5  senseb   SAEN   VDD   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2
Mp6  senseb   sense  VDD   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2 
Mp7  sense    senseb VDD   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2 
Mp8  sense    SAEN   VDD   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2	

.ends

.subckt voltage_SA BL BLB sense senseB SAEN
Mn0  net0    SAEN    GND   GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=4 

Mn1  senseB  sense   net0  GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=2 
Mn2  sense   senseB  net0  GND  nmos_lvt  L=2e-08 W=2.7e-08 nfin=2 

Mp3  senseB  sense   VDD   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2 
Mp4  sense   senseB  VDD   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2 
Mp5  sense   SAEN    BL    VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2 
Mp6  senseB  SAEN    BLB   VDD  pmos_lvt  L=2e-08 W=2.7e-08 nfin=2 

.ends


*****************************
**   Circuit Description   **
*****************************
.subckt SRAM_Column_64x1
+ PRE SAEN sense senseb WEN_BL WEN_BLB VDD VSS VDD_W VSS_SUB
+ WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15
+ WL16 WL17 WL18 WL19 WL20 WL21 WL22 WL23 WL24 WL25 WL26 WL27 WL28 WL29 WL30 WL31
+ WL32 WL33 WL34 WL35 WL36 WL37 WL38 WL39 WL40 WL41 WL42 WL43 WL44 WL45 WL46 WL47
+ WL48 WL49 WL50 WL51 WL52 WL53 WL54 WL55 WL56 WL57 WL58 WL59 WL60 WL61 WL62 WL63

* Pre charge circuit
xpre BL BLB PRE precharge

*SRAM for one column
xcell0  WL0  BL BLB q0  qb0  VDD VSS VDD_W VSS_SUB SRAM
xcell1  WL1  BL BLB q1  qb1  VDD VSS VDD_W VSS_SUB SRAM
xcell2  WL2  BL BLB q2  qb2  VDD VSS VDD_W VSS_SUB SRAM
xcell3  WL3  BL BLB q3  qb3  VDD VSS VDD_W VSS_SUB SRAM
xcell4  WL4  BL BLB q4  qb4  VDD VSS VDD_W VSS_SUB SRAM
xcell5  WL5  BL BLB q5  qb5  VDD VSS VDD_W VSS_SUB SRAM
xcell6  WL6  BL BLB q6  qb6  VDD VSS VDD_W VSS_SUB SRAM
xcell7  WL7  BL BLB q7  qb7  VDD VSS VDD_W VSS_SUB SRAM
xcell8  WL8  BL BLB q8  qb8  VDD VSS VDD_W VSS_SUB SRAM
xcell9  WL9  BL BLB q9  qb9  VDD VSS VDD_W VSS_SUB SRAM
xcell10 WL10 BL BLB q10 qb10 VDD VSS VDD_W VSS_SUB SRAM
xcell11 WL11 BL BLB q11 qb11 VDD VSS VDD_W VSS_SUB SRAM
xcell12 WL12 BL BLB q12 qb12 VDD VSS VDD_W VSS_SUB SRAM
xcell13 WL13 BL BLB q13 qb13 VDD VSS VDD_W VSS_SUB SRAM
xcell14 WL14 BL BLB q14 qb14 VDD VSS VDD_W VSS_SUB SRAM
xcell15 WL15 BL BLB q15 qb15 VDD VSS VDD_W VSS_SUB SRAM
xcell16 WL16 BL BLB q16 qb16 VDD VSS VDD_W VSS_SUB SRAM
xcell17 WL17 BL BLB q17 qb17 VDD VSS VDD_W VSS_SUB SRAM
xcell18 WL18 BL BLB q18 qb18 VDD VSS VDD_W VSS_SUB SRAM
xcell19 WL19 BL BLB q19 qb19 VDD VSS VDD_W VSS_SUB SRAM
xcell20 WL20 BL BLB q20 qb20 VDD VSS VDD_W VSS_SUB SRAM
xcell21 WL21 BL BLB q21 qb21 VDD VSS VDD_W VSS_SUB SRAM
xcell22 WL22 BL BLB q22 qb22 VDD VSS VDD_W VSS_SUB SRAM
xcell23 WL23 BL BLB q23 qb23 VDD VSS VDD_W VSS_SUB SRAM
xcell24 WL24 BL BLB q24 qb24 VDD VSS VDD_W VSS_SUB SRAM
xcell25 WL25 BL BLB q25 qb25 VDD VSS VDD_W VSS_SUB SRAM
xcell26 WL26 BL BLB q26 qb26 VDD VSS VDD_W VSS_SUB SRAM
xcell27 WL27 BL BLB q27 qb27 VDD VSS VDD_W VSS_SUB SRAM
xcell28 WL28 BL BLB q28 qb28 VDD VSS VDD_W VSS_SUB SRAM
xcell29 WL29 BL BLB q29 qb29 VDD VSS VDD_W VSS_SUB SRAM
xcell30 WL30 BL BLB q30 qb30 VDD VSS VDD_W VSS_SUB SRAM
xcell31 WL31 BL BLB q31 qb31 VDD VSS VDD_W VSS_SUB SRAM
xcell32 WL32 BL BLB q32 qb32 VDD VSS VDD_W VSS_SUB SRAM
xcell33 WL33 BL BLB q33 qb33 VDD VSS VDD_W VSS_SUB SRAM
xcell34 WL34 BL BLB q34 qb34 VDD VSS VDD_W VSS_SUB SRAM
xcell35 WL35 BL BLB q35 qb35 VDD VSS VDD_W VSS_SUB SRAM
xcell36 WL36 BL BLB q36 qb36 VDD VSS VDD_W VSS_SUB SRAM
xcell37 WL37 BL BLB q37 qb37 VDD VSS VDD_W VSS_SUB SRAM
xcell38 WL38 BL BLB q38 qb38 VDD VSS VDD_W VSS_SUB SRAM
xcell39 WL39 BL BLB q39 qb39 VDD VSS VDD_W VSS_SUB SRAM
xcell40 WL40 BL BLB q40 qb40 VDD VSS VDD_W VSS_SUB SRAM
xcell41 WL41 BL BLB q41 qb41 VDD VSS VDD_W VSS_SUB SRAM
xcell42 WL42 BL BLB q42 qb42 VDD VSS VDD_W VSS_SUB SRAM
xcell43 WL43 BL BLB q43 qb43 VDD VSS VDD_W VSS_SUB SRAM
xcell44 WL44 BL BLB q44 qb44 VDD VSS VDD_W VSS_SUB SRAM
xcell45 WL45 BL BLB q45 qb45 VDD VSS VDD_W VSS_SUB SRAM
xcell46 WL46 BL BLB q46 qb46 VDD VSS VDD_W VSS_SUB SRAM
xcell47 WL47 BL BLB q47 qb47 VDD VSS VDD_W VSS_SUB SRAM
xcell48 WL48 BL BLB q48 qb48 VDD VSS VDD_W VSS_SUB SRAM
xcell49 WL49 BL BLB q49 qb49 VDD VSS VDD_W VSS_SUB SRAM
xcell50 WL50 BL BLB q50 qb50 VDD VSS VDD_W VSS_SUB SRAM
xcell51 WL51 BL BLB q51 qb51 VDD VSS VDD_W VSS_SUB SRAM
xcell52 WL52 BL BLB q52 qb52 VDD VSS VDD_W VSS_SUB SRAM
xcell53 WL53 BL BLB q53 qb53 VDD VSS VDD_W VSS_SUB SRAM
xcell54 WL54 BL BLB q54 qb54 VDD VSS VDD_W VSS_SUB SRAM
xcell55 WL55 BL BLB q55 qb55 VDD VSS VDD_W VSS_SUB SRAM
xcell56 WL56 BL BLB q56 qb56 VDD VSS VDD_W VSS_SUB SRAM
xcell57 WL57 BL BLB q57 qb57 VDD VSS VDD_W VSS_SUB SRAM
xcell58 WL58 BL BLB q58 qb58 VDD VSS VDD_W VSS_SUB SRAM
xcell59 WL59 BL BLB q59 qb59 VDD VSS VDD_W VSS_SUB SRAM
xcell60 WL60 BL BLB q60 qb60 VDD VSS VDD_W VSS_SUB SRAM
xcell61 WL61 BL BLB q61 qb61 VDD VSS VDD_W VSS_SUB SRAM
xcell62 WL62 BL BLB q62 qb62 VDD VSS VDD_W VSS_SUB SRAM
xcell63 WL63 BL BLB q63 qb63 VDD VSS VDD_W VSS_SUB SRAM

* Sense Amplifier (voltage)
xSA BL BLB sense senseB SAEN voltage_SA 

* write driver 
Mnwd_blb BLB WEN_BL  VSS VSS nmos_lvt L=2e-08 W=2.7e-08 nfin=4
Mnwd_bl  BL  WEN_BLB VSS VSS nmos_lvt L=2e-08 W=2.7e-08 nfin=4

.ends

