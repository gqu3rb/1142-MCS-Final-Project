#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include <vector>
#include <iomanip> // for setprecision(3)

// Simulation Options
#define SHORT_SIMULATION_VER 1 // short simulation ver only test the first 16 rows
#define PROB_ALL_SIGNAL 1
#define PROB_EACH_CELL_Q_QB 0 // prob q and qb of all the cells in 64x32 array
#define PROB_ALL_FIRST_COLUMN_CELL 0 // prob all signals of the first column

// Specification
#define BITCAP_CAP 10 // 10fF
#define INCLUDE_BIT_CAP 0
#define VDD_VAL 0.7
#define T_BOOT 4.0 // ns boot delay
// Recall: Final Project.pdf, P.3: The rise time and fall time of all inputs are 50ps respectively. 
#define RISE_FALL_TIME 0.05 // rise time and fall time are all 50ps
// Recall: Final Project.pdf, P.3: The minimum frequency of this SRAM is 1GHz.
#define CLK_PERIOD 1.0 // clock period 1ns (operating frequency 1GHz)

// Read/Write Operation Timing Settings {{
// for write operation
//#define WL_PHASE_WRITE CLK_PERIOD
// disable WL in advance to prevent from writing the wrong value due to 
// the precharge stage in the next read/write operation
#define WL_PHASE_WRITE 7*CLK_PERIOD/8 

// for read operation
#define PRE_PHASE 2*CLK_PERIOD/8
#define WL_PHASE_READ 3*CLK_PERIOD/8
#define SENSE_PHASE 3*CLK_PERIOD/8
// }} end of Read/Write Operation Timing Settings

using namespace std;

// print_ports("WL", 64, 16) will print:
// + WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15
// ...
// + WL48 WL49 WL50 WL51 WL52 WL53 WL54 WL55 WL56 WL57 WL58 WL59 WL60 WL61 WL62 WL63
inline void print_ports(ofstream& out, string port_name, int port_num, int num_per_line) {
    for(int i=0; i<port_num/num_per_line; i++) {
        out << "+ ";
        for(int j=0; j<num_per_line; j++) {
            out << port_name << i*num_per_line+j << " ";
        }
        out << endl;
    }
}

// print_probe_tran("A", 4) will print:
// .probe tran v(A0) v(A1) v(A2) v(A3) 
inline void print_probe_tran(ofstream& out, string port_name, int port_num) {
    out << ".probe tran ";
    for(int i=0; i<port_num; i++) out << "v(" << port_name << i << ") ";
    out << endl;
}

inline void print_probe_tran_suffix(ofstream& out, string port_name, string suffix, int port_num) {
    out << ".probe tran ";
    for(int i=0; i<port_num; i++) out << "v(" << port_name << i << suffix << ") ";
    out << endl;
}

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        cout << "Usage: " << argv[0] << " <.sp file name>" << endl;
        return 1;
    }

    ofstream out;
    out.open(argv[1]);
    if (!out.is_open())
    {
        cout << "Failed to open file!" << endl;
        return 1;
    }

    out << ".title Read Write 64x32 SRAM Array Simulation" << endl;
    out << "*****************************" << endl;
    out << "**     Library setting     **" << endl;
    out << "*****************************" << endl;
    out << ".protect" << endl;
    out << ".include '7nm_TT.pm'" << endl;
    out << ".unprotect" << endl;

    vector<string> sub_circuits;
    // add more sub circuit files to the vector as you need
    sub_circuits.push_back("6to64_row_decoder.sp");
    sub_circuits.push_back("SRAM_array_64x32.sp");
    sub_circuits.push_back("column_based_circuit.sp");
    sub_circuits.push_back("DFF.sp");
    for (auto it=sub_circuits.begin(); it!=sub_circuits.end(); it++) {
        out << ".include \'" << *it << "\'" << endl;
    }
    out << endl;

    out << "*****************************" << endl;
    out << "**   Circuit Description   **" << endl;
    out << "*****************************" << endl;

    // Recall Final Project.pdf, P.3:
    // All the input data have to pass one smallest buffer to prevent infinite driving ability
    // BUF sub-circuit is in DFF.sp
    // .SUBCKT BUF IN OUT
    out << "xbuf_clk CLK CLK_in BUF" << endl;
    out << "xbuf_clk4 CLK_in CLK_in4 BUF" << endl;
    out << "xbuf_wen WEN WEN_in BUF" << endl;
    for(int i=0; i<7; i++) {
        out << "xbuf_a" << i << " A" << i << " A" << i << "in BUF" << endl;
    }
    for(int i=0; i<16; i++) {
        out << "xbuf_d" << i << " D" << i << " D" << i << "in BUF" << endl;
    }
    out << endl;

    // buffers for addr in DFF
    out << "xbuf_clk_addr CLK_in4 CLK_in4_a BUF NFIN_SIZE=4" << endl; 
    for(int i=0; i<7; i++) {
        out << "xdff_a" << i << " CLK_in4_a" << " A" << i << "in" << " A" << i << "q DFF" << endl;
    }
    // buffers for data in DFF
    out << "xbuf_clk_data1 CLK_in4 CLK_in4_d1 BUF NFIN_SIZE=4" << endl; 
    for (int i=0; i<4; i++) {
        out << "xbuf_clk_data2" << i << " CLK_in4_d1 CLK_in4_d2" << i << " BUF NFIN_SIZE=4" << endl; 
    }
    for(int i=0; i<16; i++) {
        out << "xdff_d" << i << " CLK_in4_d2" << i/4 << " D" << i << "in" << " D" << i << "q DFF" << endl;
    }
    out << "xdff_wen CLK_in4 WEN_in WENq DFF" << endl;
    // 內部訊號不用擋 DFF
    //out << "xdff_saen SAEN CLK_in4 SAENq DFF" << endl;
    out << endl;

    out << "* 呼叫 Row Decoder (注意：引腳順序必須跟上面定義的完全一模一樣)" << endl;
    out << "xdecoder A6q A5q A4q A3q A2q A1q ROW_DEC_EN" << endl;
    print_ports(out, "WL", 64, 16);
    out << "+ ROW_DEC_6to64" << endl;
    out << endl;

    out << "XARRAY_TOP PRE SAEN VDD VSS VDD_W VSS_SUB " << endl;
    print_ports(out, "WL", 64, 16);
    //out << "+ SENSE_OUT0  SENSE_OUTB0  WEN_BL0  WEN_BLB0" << endl;
    //out << "+ SENSE_OUT1  SENSE_OUTB1  WEN_BL1  WEN_BLB1" << endl;
    //...
    //out << "+ SENSE_OUT31 SENSE_OUTB31 WEN_BL31 WEN_BLB31" << endl;
    for(int i=0; i<32; i++) {
        out << "+ SENSE_OUT" << i << " SENSE_OUTB" << i << " WEN_BL" << i << " WEN_BLB" << i << endl;
    }
    out << "+ SRAM_Array_64x32" << endl;
    out << endl;

    out << "Xcol_driver_array_w A0q WENq" << endl;
    for(int i=0; i<2; i++) {
        out << "+ ";
        for(int j=0; j<8; j++) {
            out << "D" << i*8+j << "q ";
        }
        out << endl;
    }
    print_ports(out, "WEN_BL", 32, 8);
    print_ports(out, "WEN_BLB", 32, 8);
    out << "+ COL_DRIVER_ARRAY" << endl;
    out << endl;

    out << "Xcol_selector_r A0q WENq" << endl;
    print_ports(out, "Q", 16, 8);
    print_ports(out, "QB", 16, 8);
    print_ports(out, "SENSE_OUT", 32, 8);
    print_ports(out, "SENSE_OUTB", 32, 8);
    out << "+ COL_SEL" << endl;
    out << endl;

    out << "*****************************" << endl;
    out << "**     Voltage Source      **" << endl;
    out << "*****************************" << endl;
    out << ".global VDD GND VSS VDD_W VSS_SUB" << endl;
    out << ".param  BITCAP = " << BITCAP_CAP << "f" << endl;
    out << endl;

    out << "VVDD VDD GND " << VDD_VAL << "v" << endl;
    out << "VVSS VSS GND " << 0 << "v" << endl;
    out << "VVDD_W VDD_W VSS " << VDD_VAL << "v" << endl;
    out << "VVSS_SUB VSS_SUB VSS " << 0 << "v" << endl;
    out << endl;

#if INCLUDE_BIT_CAP
    out << "CBLB BLB GND BITCAP" << endl;
    out << "CBL  BL  GND BITCAP" << endl;
#else
    out << "*CBLB BLB GND BITCAP" << endl;
    out << "*CBL  BL  GND BITCAP" << endl;
#endif
    out << endl;
  
    // vvvvv please complete the parts there vvvvv
    // ── Timing constants ───────────────────────────────────────────────────
    const int    N_OPS  = 64;          // 64 addresses (addr0 .. addr63)
    const int    N_CYC  = 2 * N_OPS;   // 128 cycles: each address = write cycle + read cycle
    const double T_SKEW = 0.1;         // inputs switch 0.1ns AFTER each clk edge (~0.9ns setup)

    out << fixed << setprecision(3);

    // Cycle c (0-based) starts (clk rising edge) at  T_BOOT + c*CLK_PERIOD.
    //   - even c -> WRITE of address (c/2)
    //   - odd  c -> READ  of address (c/2)
    // A value that must be sampled at edge c switches in at
    //   t = T_BOOT + (c-1)*CLK_PERIOD + T_SKEW   (just after the previous edge).

    // ── CLK ────────────────────────────────────────────────────────────────
    // 1GHz, 50% duty, first rising edge at T_BOOT.
    out << "Vc CLK GND PULSE(0V " << VDD_VAL << "V "
        << T_BOOT << "ns " << RISE_FALL_TIME << "ns " << RISE_FALL_TIME << "ns "
        << (CLK_PERIOD / 2.0 - RISE_FALL_TIME) << "ns " << CLK_PERIOD << "ns)" << endl;
    out << endl;

    // ── PRE ────────────────────────────────────────────────────────────────
    // ACTIVATE LOW precharge, only activated in read cycles
    out << "Vp PRE GND PULSE(" << VDD_VAL << "V " << 0 << "V "
        << T_BOOT+CLK_PERIOD+RISE_FALL_TIME << "ns " << RISE_FALL_TIME << "ns " << RISE_FALL_TIME << "ns "
        << PRE_PHASE << "ns " << CLK_PERIOD*2 << "ns)" << endl;
    out << endl;

    // ── SAEN ───────────────────────────────────────────────────────────────
    // Ideal internal sense-amp enable. Fires ONLY on read cycles (odd cycles);
    // stays LOW during write cycles. Read of addr k = cycle (2k+1), whose clk
    // edge is at T_BOOT+(2k+1)*CLK_PERIOD. SAEN pulses 0.25ns after that edge
    // (bitline differential developed), width 0.10ns; the latch-type SA holds
    // the result afterwards even when PRE re-precharges the bitlines.
    out << "Vs SAEN GND PWL(0ns 0V";
    for (int k = 0; k < N_OPS; k++) {
        double Tr = T_BOOT + (2.0 * k + 1.0) * CLK_PERIOD; // only activate in read cycles
        double Ts = Tr + PRE_PHASE + RISE_FALL_TIME + WL_PHASE_READ; // start time in a single cycle
        out << " " << Ts << "ns 0V"
            << " " << (Ts + RISE_FALL_TIME) << "ns " << VDD_VAL << "V"
            << " " << (Ts + RISE_FALL_TIME + SENSE_PHASE) << "ns " << VDD_VAL << "V"
            << " " << (Ts + RISE_FALL_TIME + SENSE_PHASE + RISE_FALL_TIME) << "ns 0V";
    }
    out << ")" << endl;
    out << endl;

    // Active LOW ROW_DEC_EN
    out << "Vrow_dec_en ROW_DEC_EN GND PWL(0ns " << VDD_VAL << "V";
    for (int k = 0; k < N_OPS; k++) {
        double Tr = T_BOOT + k * CLK_PERIOD;
        double Ts; // start time in a single cycle
        double activate_len;
        if(k%2) { // read cycles
            Ts = Tr + PRE_PHASE; 
            activate_len = WL_PHASE_READ;
        } else { // write cycles
            Ts = Tr; 
            activate_len = WL_PHASE_WRITE;
        }

        out << " " << Ts << "ns " << VDD_VAL << "V"
            << " " << (Ts + RISE_FALL_TIME) << "ns " << "0V"
            << " " << (Ts + RISE_FALL_TIME + activate_len) << "ns " << "0V"
            << " " << (Ts + RISE_FALL_TIME + activate_len + RISE_FALL_TIME) << "ns " << VDD_VAL << "V";
    }
    out << ")" << endl;
    out << endl;

    // ── WEN ────────────────────────────────────────────────────────────────
    // LOW = write, HIGH = read. Follows the cycle structure exactly:
    // write on even cycles, read on odd cycles.
    out << "Vw WEN GND PWL(0ns ";
    {
        int prev = 0;                          // cycle 0 = write -> LOW
        out << prev * VDD_VAL << "V";
        for (int c = 1; c < N_CYC; c++) {
            int cur = (c % 2);                 // 0 = write(LOW), 1 = read(HIGH)
            if (cur != prev) {
                double Tt = T_BOOT + (c - 1) * CLK_PERIOD + T_SKEW;
                out << " " << Tt << "ns " << prev * VDD_VAL << "V"
                    << " " << (Tt + RISE_FALL_TIME) << "ns " << cur * VDD_VAL << "V";
            }
            prev = cur;
        }
    }
    out << ")" << endl;
    out << endl;

    // ── A0~A6 (address) ────────────────────────────────────────────────────
    // addr(c) = c/2 : the SAME address is held across its write and read cycles.
    // A_n = bit n of addr.  (For addr 0..63, A6 stays 0.)
    for (int n = 0; n <= 6; n++) {
        out << "VA" << n << " A" << n << " GND PWL(0ns ";
        int prev = ((0 / 2) >> n) & 1;
        out << prev * VDD_VAL << "V";
        for (int c = 1; c < N_CYC; c++) {
            int cur = ((c / 2) >> n) & 1;
            if (cur != prev) {
                double Tt = T_BOOT + (c - 1) * CLK_PERIOD + T_SKEW;
                out << " " << Tt << "ns " << prev * VDD_VAL << "V"
                    << " " << (Tt + RISE_FALL_TIME) << "ns " << cur * VDD_VAL << "V";
            }
            prev = cur;
        }
        out << ")" << endl;
    }
    out << endl;

    // ── D0~D15 (data) ──────────────────────────────────────────────────────
    // Write cycle (even c): D = data(addr) = 1 << (addr % 16).
    // Read  cycle (odd  c): D = 0  (reading, not driving data).
    //   addr0->0x0001, addr1->0x0002, ..., addr15->0x8000, addr16->0x0001, ...
    for (int d = 0; d < 16; d++) {
        out << "Vd" << d << " D" << d << " GND PWL(0ns ";
        int prev = (((1 << ((0 / 2) % 16)) >> d) & 1);   // bit d during write of addr0
        out << prev * VDD_VAL << "V";
        for (int c = 1; c < N_CYC; c++) {
            int cur;
            if (c % 2 == 0) {                            // write cycle
                int addr = c / 2;
                cur = (((1 << (addr % 16)) >> d) & 1);
            } else {                                     // read cycle
                cur = 0;
            }
            if (cur != prev) {
                double Tt = T_BOOT + (c - 1) * CLK_PERIOD + T_SKEW;
                out << " " << Tt << "ns " << prev * VDD_VAL << "V"
                    << " " << (Tt + RISE_FALL_TIME) << "ns " << cur * VDD_VAL << "V";
            }
            prev = cur;
        }
        out << ")" << endl;
    }
    // ^^^^^ please complete the parts there ^^^^^

    out << "*****************************" << endl;
    out << "**    Initial Conditions   **" << endl;
    out << "*****************************" << endl;
    out << "* Do not modify the initial conditions for BL and BLB, which are both 0V." << endl;
    out << "* We assume there is no initial voltage on the bitlines before precharge." << endl;
    for(int i=0; i<32; i++) {
        out << ".ic v(XARRAY_TOP.xCOL" << i << ".BL" << i << ")\t= 0v" << endl;
        out << ".ic v(XARRAY_TOP.xCOL" << i << ".BLB" << i << ")\t= 0v" << endl;
    }
    out << endl;

    out << "* You should set the initial conditions for q and qb in the SRAM." << endl;
    out << "* q should be 0V and qb should be 0.7V, which means the SRAM cell is storing \"0\"." << endl;
    for(int i=0; i<64; i++) {
        for(int j=0; j<32; j++) {
            out << ".ic v(XARRAY_TOP.xCOL" << j << ".q" << i << ")\t= 0v" << endl;
            out << ".ic v(XARRAY_TOP.xCOL" << j << ".qb" << i << ")\t= 0.7v" << endl;
        }
    }
    out << endl;

    out << "*****************************" << endl;
    out << "**    Simulator setting    **" << endl;
    out << "*****************************" << endl;
    out << ".op" << endl;
    out << ".option post " << endl;
    out << ".options probe" << endl;
#if PROB_ALL_SIGNAL
    out << ".probe v(*) i(*)" << endl;
#else
    out << "*.probe v(*) i(*)" << endl;
#endif
    out << endl;

    //out << "* Do Not Modify !!!" << endl;
    //out << "*read model" << endl;
    //out << "*.measure tp" << endl;
    //out << "*+ TRIG v(SAEN) VAL='0.35' rise=1" << endl;
    //out << "*+ TARG v(sense) VAL='0.35' fall=1" << endl;

    print_probe_tran_suffix(out, "A", "in", 7);
    print_probe_tran_suffix(out, "D", "in", 16);
    print_probe_tran(out, "Q", 16);
    print_probe_tran(out, "QB", 16);
    print_probe_tran_suffix(out, "A", "q", 7);
    print_probe_tran_suffix(out, "D", "q", 16);
    out << ".probe tran v(CLK_in4) v(PRE) v(SAEN) v(WEN_in) v(WENq)" << endl;
    out << ".probe tran v(ROW_DEC_EN)" << endl; // temporal behavioral ROW_DEC_EN to simulate the global controller output
#if PROB_EACH_CELL_Q_QB
    for(int i=0; i<64; i++) {
        for(int j=0; j<32; j++) {
            // the value stored in SRAM cell
            out << ".probe tran v(XARRAY_TOP.xCOL" << j << ".q" << i << ")" << endl;
            out << ".probe tran v(XARRAY_TOP.xCOL" << j << ".qb" << i << ")" << endl;
        }
    }
#endif

#if PROB_ALL_FIRST_COLUMN_CELL
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".VDD" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".VSS" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".VDD_W" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".VSS_SUB" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".BL" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".BLB" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".sense" << ")" << endl;
    out << ".probe tran v(XARRAY_TOP.xCOL0" << ".senseb" << ")" << endl;
    for(int i=0; i<64; i++) {
        out << ".probe tran v(XARRAY_TOP.xCOL0" << ".WL" << i << ")" << endl;
        out << ".probe tran v(XARRAY_TOP.xCOL0" << ".q" << i << ")" << endl;
        out << ".probe tran v(XARRAY_TOP.xCOL0" << ".qb" << i << ")" << endl;
    }
#endif

#if SHORT_SIMULATION_VER
    out << ".tran 0.05ns 20ns" << endl; // 4 + 16 cycles
#else
    out << ".tran 0.05ns 134ns" << endl; // 4 + 128 cycles
#endif

    //.measure TRAN Avg_read_pwr avg POWER from=4n to=5n

    return 0;
}