.title 6-to-64 Row Decoder Verification Testbench
* Address i is applied for 1.000 ns starting at t = T_BOOT + i*T_PER.
* Expected: only WL_i goes HIGH (~0.700V); all other WLs remain LOW (~0V).
*
.protect
.include '7nm_TT.pm'
.unprotect
.include '6to64_row_decoder.sp'

* ---- DUT: 6-to-64 Row Decoder ----
xdecoder A6 A5 A4 A3 A2 A1
+ WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15 
+ WL16 WL17 WL18 WL19 WL20 WL21 WL22 WL23 WL24 WL25 WL26 WL27 WL28 WL29 WL30 WL31 
+ WL32 WL33 WL34 WL35 WL36 WL37 WL38 WL39 WL40 WL41 WL42 WL43 WL44 WL45 WL46 WL47 
+ WL48 WL49 WL50 WL51 WL52 WL53 WL54 WL55 WL56 WL57 WL58 WL59 WL60 WL61 WL62 WL63 
+ ROW_DEC_6to64

.global VDD GND
VVDD VDD GND 0.700v

* Address inputs (A1=LSB, A6=MSB)
VA1 A1 GND PWL(0ns 0V  1.950ns 0.000V  2.000ns 0.700V  2.950ns 0.700V  3.000ns 0.000V  3.950ns 0.000V  4.000ns 0.700V  4.950ns 0.700V  5.000ns 0.000V  5.950ns 0.000V  6.000ns 0.700V  6.950ns 0.700V  7.000ns 0.000V  7.950ns 0.000V  8.000ns 0.700V  8.950ns 0.700V  9.000ns 0.000V  9.950ns 0.000V  10.000ns 0.700V  10.950ns 0.700V  11.000ns 0.000V  11.950ns 0.000V  12.000ns 0.700V  12.950ns 0.700V  13.000ns 0.000V  13.950ns 0.000V  14.000ns 0.700V  14.950ns 0.700V  15.000ns 0.000V  15.950ns 0.000V  16.000ns 0.700V  16.950ns 0.700V  17.000ns 0.000V  17.950ns 0.000V  18.000ns 0.700V  18.950ns 0.700V  19.000ns 0.000V  19.950ns 0.000V  20.000ns 0.700V  20.950ns 0.700V  21.000ns 0.000V  21.950ns 0.000V  22.000ns 0.700V  22.950ns 0.700V  23.000ns 0.000V  23.950ns 0.000V  24.000ns 0.700V  24.950ns 0.700V  25.000ns 0.000V  25.950ns 0.000V  26.000ns 0.700V  26.950ns 0.700V  27.000ns 0.000V  27.950ns 0.000V  28.000ns 0.700V  28.950ns 0.700V  29.000ns 0.000V  29.950ns 0.000V  30.000ns 0.700V  30.950ns 0.700V  31.000ns 0.000V  31.950ns 0.000V  32.000ns 0.700V  32.950ns 0.700V  33.000ns 0.000V  33.950ns 0.000V  34.000ns 0.700V  34.950ns 0.700V  35.000ns 0.000V  35.950ns 0.000V  36.000ns 0.700V  36.950ns 0.700V  37.000ns 0.000V  37.950ns 0.000V  38.000ns 0.700V  38.950ns 0.700V  39.000ns 0.000V  39.950ns 0.000V  40.000ns 0.700V  40.950ns 0.700V  41.000ns 0.000V  41.950ns 0.000V  42.000ns 0.700V  42.950ns 0.700V  43.000ns 0.000V  43.950ns 0.000V  44.000ns 0.700V  44.950ns 0.700V  45.000ns 0.000V  45.950ns 0.000V  46.000ns 0.700V  46.950ns 0.700V  47.000ns 0.000V  47.950ns 0.000V  48.000ns 0.700V  48.950ns 0.700V  49.000ns 0.000V  49.950ns 0.000V  50.000ns 0.700V  50.950ns 0.700V  51.000ns 0.000V  51.950ns 0.000V  52.000ns 0.700V  52.950ns 0.700V  53.000ns 0.000V  53.950ns 0.000V  54.000ns 0.700V  54.950ns 0.700V  55.000ns 0.000V  55.950ns 0.000V  56.000ns 0.700V  56.950ns 0.700V  57.000ns 0.000V  57.950ns 0.000V  58.000ns 0.700V  58.950ns 0.700V  59.000ns 0.000V  59.950ns 0.000V  60.000ns 0.700V  60.950ns 0.700V  61.000ns 0.000V  61.950ns 0.000V  62.000ns 0.700V  62.950ns 0.700V  63.000ns 0.000V  63.950ns 0.000V  64.000ns 0.700V)
VA2 A2 GND PWL(0ns 0V  2.950ns 0.000V  3.000ns 0.700V  4.950ns 0.700V  5.000ns 0.000V  6.950ns 0.000V  7.000ns 0.700V  8.950ns 0.700V  9.000ns 0.000V  10.950ns 0.000V  11.000ns 0.700V  12.950ns 0.700V  13.000ns 0.000V  14.950ns 0.000V  15.000ns 0.700V  16.950ns 0.700V  17.000ns 0.000V  18.950ns 0.000V  19.000ns 0.700V  20.950ns 0.700V  21.000ns 0.000V  22.950ns 0.000V  23.000ns 0.700V  24.950ns 0.700V  25.000ns 0.000V  26.950ns 0.000V  27.000ns 0.700V  28.950ns 0.700V  29.000ns 0.000V  30.950ns 0.000V  31.000ns 0.700V  32.950ns 0.700V  33.000ns 0.000V  34.950ns 0.000V  35.000ns 0.700V  36.950ns 0.700V  37.000ns 0.000V  38.950ns 0.000V  39.000ns 0.700V  40.950ns 0.700V  41.000ns 0.000V  42.950ns 0.000V  43.000ns 0.700V  44.950ns 0.700V  45.000ns 0.000V  46.950ns 0.000V  47.000ns 0.700V  48.950ns 0.700V  49.000ns 0.000V  50.950ns 0.000V  51.000ns 0.700V  52.950ns 0.700V  53.000ns 0.000V  54.950ns 0.000V  55.000ns 0.700V  56.950ns 0.700V  57.000ns 0.000V  58.950ns 0.000V  59.000ns 0.700V  60.950ns 0.700V  61.000ns 0.000V  62.950ns 0.000V  63.000ns 0.700V)
VA3 A3 GND PWL(0ns 0V  4.950ns 0.000V  5.000ns 0.700V  8.950ns 0.700V  9.000ns 0.000V  12.950ns 0.000V  13.000ns 0.700V  16.950ns 0.700V  17.000ns 0.000V  20.950ns 0.000V  21.000ns 0.700V  24.950ns 0.700V  25.000ns 0.000V  28.950ns 0.000V  29.000ns 0.700V  32.950ns 0.700V  33.000ns 0.000V  36.950ns 0.000V  37.000ns 0.700V  40.950ns 0.700V  41.000ns 0.000V  44.950ns 0.000V  45.000ns 0.700V  48.950ns 0.700V  49.000ns 0.000V  52.950ns 0.000V  53.000ns 0.700V  56.950ns 0.700V  57.000ns 0.000V  60.950ns 0.000V  61.000ns 0.700V)
VA4 A4 GND PWL(0ns 0V  8.950ns 0.000V  9.000ns 0.700V  16.950ns 0.700V  17.000ns 0.000V  24.950ns 0.000V  25.000ns 0.700V  32.950ns 0.700V  33.000ns 0.000V  40.950ns 0.000V  41.000ns 0.700V  48.950ns 0.700V  49.000ns 0.000V  56.950ns 0.000V  57.000ns 0.700V)
VA5 A5 GND PWL(0ns 0V  16.950ns 0.000V  17.000ns 0.700V  32.950ns 0.700V  33.000ns 0.000V  48.950ns 0.000V  49.000ns 0.700V)
VA6 A6 GND PWL(0ns 0V  32.950ns 0.000V  33.000ns 0.700V)

.op
.option post
.options probe
.tran 0.01ns 65.500ns

.probe tran v(A1) v(A2) v(A3) v(A4) v(A5) v(A6)
.probe tran v(WL0) v(WL1) v(WL2) v(WL3) v(WL4) v(WL5) v(WL6) v(WL7) v(WL8) v(WL9) v(WL10) v(WL11) v(WL12) v(WL13) v(WL14) v(WL15) v(WL16) v(WL17) v(WL18) v(WL19) v(WL20) v(WL21) v(WL22) v(WL23) v(WL24) v(WL25) v(WL26) v(WL27) v(WL28) v(WL29) v(WL30) v(WL31) v(WL32) v(WL33) v(WL34) v(WL35) v(WL36) v(WL37) v(WL38) v(WL39) v(WL40) v(WL41) v(WL42) v(WL43) v(WL44) v(WL45) v(WL46) v(WL47) v(WL48) v(WL49) v(WL50) v(WL51) v(WL52) v(WL53) v(WL54) v(WL55) v(WL56) v(WL57) v(WL58) v(WL59) v(WL60) v(WL61) v(WL62) v(WL63)

* ============================================================
* POSITIVE checks: WL_i must be HIGH (~0.700V) at address i
* ============================================================
.measure TRAN WL0_sel        FIND v(WL0) AT=1.800ns
.measure TRAN WL1_sel        FIND v(WL1) AT=2.800ns
.measure TRAN WL2_sel        FIND v(WL2) AT=3.800ns
.measure TRAN WL3_sel        FIND v(WL3) AT=4.800ns
.measure TRAN WL4_sel        FIND v(WL4) AT=5.800ns
.measure TRAN WL5_sel        FIND v(WL5) AT=6.800ns
.measure TRAN WL6_sel        FIND v(WL6) AT=7.800ns
.measure TRAN WL7_sel        FIND v(WL7) AT=8.800ns
.measure TRAN WL8_sel        FIND v(WL8) AT=9.800ns
.measure TRAN WL9_sel        FIND v(WL9) AT=10.800ns
.measure TRAN WL10_sel        FIND v(WL10) AT=11.800ns
.measure TRAN WL11_sel        FIND v(WL11) AT=12.800ns
.measure TRAN WL12_sel        FIND v(WL12) AT=13.800ns
.measure TRAN WL13_sel        FIND v(WL13) AT=14.800ns
.measure TRAN WL14_sel        FIND v(WL14) AT=15.800ns
.measure TRAN WL15_sel        FIND v(WL15) AT=16.800ns
.measure TRAN WL16_sel        FIND v(WL16) AT=17.800ns
.measure TRAN WL17_sel        FIND v(WL17) AT=18.800ns
.measure TRAN WL18_sel        FIND v(WL18) AT=19.800ns
.measure TRAN WL19_sel        FIND v(WL19) AT=20.800ns
.measure TRAN WL20_sel        FIND v(WL20) AT=21.800ns
.measure TRAN WL21_sel        FIND v(WL21) AT=22.800ns
.measure TRAN WL22_sel        FIND v(WL22) AT=23.800ns
.measure TRAN WL23_sel        FIND v(WL23) AT=24.800ns
.measure TRAN WL24_sel        FIND v(WL24) AT=25.800ns
.measure TRAN WL25_sel        FIND v(WL25) AT=26.800ns
.measure TRAN WL26_sel        FIND v(WL26) AT=27.800ns
.measure TRAN WL27_sel        FIND v(WL27) AT=28.800ns
.measure TRAN WL28_sel        FIND v(WL28) AT=29.800ns
.measure TRAN WL29_sel        FIND v(WL29) AT=30.800ns
.measure TRAN WL30_sel        FIND v(WL30) AT=31.800ns
.measure TRAN WL31_sel        FIND v(WL31) AT=32.800ns
.measure TRAN WL32_sel        FIND v(WL32) AT=33.800ns
.measure TRAN WL33_sel        FIND v(WL33) AT=34.800ns
.measure TRAN WL34_sel        FIND v(WL34) AT=35.800ns
.measure TRAN WL35_sel        FIND v(WL35) AT=36.800ns
.measure TRAN WL36_sel        FIND v(WL36) AT=37.800ns
.measure TRAN WL37_sel        FIND v(WL37) AT=38.800ns
.measure TRAN WL38_sel        FIND v(WL38) AT=39.800ns
.measure TRAN WL39_sel        FIND v(WL39) AT=40.800ns
.measure TRAN WL40_sel        FIND v(WL40) AT=41.800ns
.measure TRAN WL41_sel        FIND v(WL41) AT=42.800ns
.measure TRAN WL42_sel        FIND v(WL42) AT=43.800ns
.measure TRAN WL43_sel        FIND v(WL43) AT=44.800ns
.measure TRAN WL44_sel        FIND v(WL44) AT=45.800ns
.measure TRAN WL45_sel        FIND v(WL45) AT=46.800ns
.measure TRAN WL46_sel        FIND v(WL46) AT=47.800ns
.measure TRAN WL47_sel        FIND v(WL47) AT=48.800ns
.measure TRAN WL48_sel        FIND v(WL48) AT=49.800ns
.measure TRAN WL49_sel        FIND v(WL49) AT=50.800ns
.measure TRAN WL50_sel        FIND v(WL50) AT=51.800ns
.measure TRAN WL51_sel        FIND v(WL51) AT=52.800ns
.measure TRAN WL52_sel        FIND v(WL52) AT=53.800ns
.measure TRAN WL53_sel        FIND v(WL53) AT=54.800ns
.measure TRAN WL54_sel        FIND v(WL54) AT=55.800ns
.measure TRAN WL55_sel        FIND v(WL55) AT=56.800ns
.measure TRAN WL56_sel        FIND v(WL56) AT=57.800ns
.measure TRAN WL57_sel        FIND v(WL57) AT=58.800ns
.measure TRAN WL58_sel        FIND v(WL58) AT=59.800ns
.measure TRAN WL59_sel        FIND v(WL59) AT=60.800ns
.measure TRAN WL60_sel        FIND v(WL60) AT=61.800ns
.measure TRAN WL61_sel        FIND v(WL61) AT=62.800ns
.measure TRAN WL62_sel        FIND v(WL62) AT=63.800ns
.measure TRAN WL63_sel        FIND v(WL63) AT=64.800ns

* ============================================================
* NEGATIVE checks: WL_{(i+1)%64} must be LOW (~0V) at address i
* (rotating → every WL exercised as unselected exactly once)
* ============================================================
.measure TRAN WL1_unsel_at_addr0  FIND v(WL1) AT=1.800ns
.measure TRAN WL2_unsel_at_addr1  FIND v(WL2) AT=2.800ns
.measure TRAN WL3_unsel_at_addr2  FIND v(WL3) AT=3.800ns
.measure TRAN WL4_unsel_at_addr3  FIND v(WL4) AT=4.800ns
.measure TRAN WL5_unsel_at_addr4  FIND v(WL5) AT=5.800ns
.measure TRAN WL6_unsel_at_addr5  FIND v(WL6) AT=6.800ns
.measure TRAN WL7_unsel_at_addr6  FIND v(WL7) AT=7.800ns
.measure TRAN WL8_unsel_at_addr7  FIND v(WL8) AT=8.800ns
.measure TRAN WL9_unsel_at_addr8  FIND v(WL9) AT=9.800ns
.measure TRAN WL10_unsel_at_addr9  FIND v(WL10) AT=10.800ns
.measure TRAN WL11_unsel_at_addr10  FIND v(WL11) AT=11.800ns
.measure TRAN WL12_unsel_at_addr11  FIND v(WL12) AT=12.800ns
.measure TRAN WL13_unsel_at_addr12  FIND v(WL13) AT=13.800ns
.measure TRAN WL14_unsel_at_addr13  FIND v(WL14) AT=14.800ns
.measure TRAN WL15_unsel_at_addr14  FIND v(WL15) AT=15.800ns
.measure TRAN WL16_unsel_at_addr15  FIND v(WL16) AT=16.800ns
.measure TRAN WL17_unsel_at_addr16  FIND v(WL17) AT=17.800ns
.measure TRAN WL18_unsel_at_addr17  FIND v(WL18) AT=18.800ns
.measure TRAN WL19_unsel_at_addr18  FIND v(WL19) AT=19.800ns
.measure TRAN WL20_unsel_at_addr19  FIND v(WL20) AT=20.800ns
.measure TRAN WL21_unsel_at_addr20  FIND v(WL21) AT=21.800ns
.measure TRAN WL22_unsel_at_addr21  FIND v(WL22) AT=22.800ns
.measure TRAN WL23_unsel_at_addr22  FIND v(WL23) AT=23.800ns
.measure TRAN WL24_unsel_at_addr23  FIND v(WL24) AT=24.800ns
.measure TRAN WL25_unsel_at_addr24  FIND v(WL25) AT=25.800ns
.measure TRAN WL26_unsel_at_addr25  FIND v(WL26) AT=26.800ns
.measure TRAN WL27_unsel_at_addr26  FIND v(WL27) AT=27.800ns
.measure TRAN WL28_unsel_at_addr27  FIND v(WL28) AT=28.800ns
.measure TRAN WL29_unsel_at_addr28  FIND v(WL29) AT=29.800ns
.measure TRAN WL30_unsel_at_addr29  FIND v(WL30) AT=30.800ns
.measure TRAN WL31_unsel_at_addr30  FIND v(WL31) AT=31.800ns
.measure TRAN WL32_unsel_at_addr31  FIND v(WL32) AT=32.800ns
.measure TRAN WL33_unsel_at_addr32  FIND v(WL33) AT=33.800ns
.measure TRAN WL34_unsel_at_addr33  FIND v(WL34) AT=34.800ns
.measure TRAN WL35_unsel_at_addr34  FIND v(WL35) AT=35.800ns
.measure TRAN WL36_unsel_at_addr35  FIND v(WL36) AT=36.800ns
.measure TRAN WL37_unsel_at_addr36  FIND v(WL37) AT=37.800ns
.measure TRAN WL38_unsel_at_addr37  FIND v(WL38) AT=38.800ns
.measure TRAN WL39_unsel_at_addr38  FIND v(WL39) AT=39.800ns
.measure TRAN WL40_unsel_at_addr39  FIND v(WL40) AT=40.800ns
.measure TRAN WL41_unsel_at_addr40  FIND v(WL41) AT=41.800ns
.measure TRAN WL42_unsel_at_addr41  FIND v(WL42) AT=42.800ns
.measure TRAN WL43_unsel_at_addr42  FIND v(WL43) AT=43.800ns
.measure TRAN WL44_unsel_at_addr43  FIND v(WL44) AT=44.800ns
.measure TRAN WL45_unsel_at_addr44  FIND v(WL45) AT=45.800ns
.measure TRAN WL46_unsel_at_addr45  FIND v(WL46) AT=46.800ns
.measure TRAN WL47_unsel_at_addr46  FIND v(WL47) AT=47.800ns
.measure TRAN WL48_unsel_at_addr47  FIND v(WL48) AT=48.800ns
.measure TRAN WL49_unsel_at_addr48  FIND v(WL49) AT=49.800ns
.measure TRAN WL50_unsel_at_addr49  FIND v(WL50) AT=50.800ns
.measure TRAN WL51_unsel_at_addr50  FIND v(WL51) AT=51.800ns
.measure TRAN WL52_unsel_at_addr51  FIND v(WL52) AT=52.800ns
.measure TRAN WL53_unsel_at_addr52  FIND v(WL53) AT=53.800ns
.measure TRAN WL54_unsel_at_addr53  FIND v(WL54) AT=54.800ns
.measure TRAN WL55_unsel_at_addr54  FIND v(WL55) AT=55.800ns
.measure TRAN WL56_unsel_at_addr55  FIND v(WL56) AT=56.800ns
.measure TRAN WL57_unsel_at_addr56  FIND v(WL57) AT=57.800ns
.measure TRAN WL58_unsel_at_addr57  FIND v(WL58) AT=58.800ns
.measure TRAN WL59_unsel_at_addr58  FIND v(WL59) AT=59.800ns
.measure TRAN WL60_unsel_at_addr59  FIND v(WL60) AT=60.800ns
.measure TRAN WL61_unsel_at_addr60  FIND v(WL61) AT=61.800ns
.measure TRAN WL62_unsel_at_addr61  FIND v(WL62) AT=62.800ns
.measure TRAN WL63_unsel_at_addr62  FIND v(WL63) AT=63.800ns
.measure TRAN WL0_unsel_at_addr63  FIND v(WL0) AT=64.800ns

.end
