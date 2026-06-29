#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include <vector>
#include <iomanip> // for setprecision(3)

using namespace std;

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

    out << ".TITLE Global Controller" << endl;
    out << endl;

    out << ".SUBCKT MUX21 D0 D1 SEL OUT" << endl;
    out << "xinv SEL SELb INV" << endl;
    out << "xnand1 SELb D0 OUT0 NAND2" << endl;
    out << "xnand2 SEL D1 OUT1 NAND2" << endl;
    out << "xnand3 OUT0 OUT1 OUT NAND2" << endl;
    out << ".ends" << endl;
    out << endl;

    out << ".SUBCKT GLOBAL_CTRL CLK WEN PRE ROW_DEC_EN SAEN" << endl;
    out << endl;

    out << "xbuf_pre1 CLK buf_pre1 BUF" << endl;
    for(int i=2; i<=56; i++) {
        out << "xbuf_pre" << i << " buf_pre" << i-1 << " buf_pre" << i << " BUF" << endl;
    }
    out << "xinv_pre buf_pre56 buf_pre56b INV" << endl;
    out << "xnand_pre CLK buf_pre56b PRE_small NAND2 NFIN_SIZE=4" << endl;
    out << "xbuf_pre_out PRE_small PRE BUF NFIN_SIZE=16" << endl;
    out << endl;

    out << "xbuf_clk230p_1 CLK buf_clk230p_1 BUF" << endl;
    for(int i=2; i<=41; i++) {
        out << "xbuf_clk230p_" << i << " buf_clk230p_" << i-1 << " buf_clk230p_" << i << " BUF" << endl;
    }
    out << "xbuf_clk500p_1 CLK buf_clk500p_1 BUF" << endl;
    for(int i=2; i<=89; i++) {
        out << "xbuf_clk500p_" << i << " buf_clk500p_" << i-1 << " buf_clk500p_" << i << " BUF" << endl;
    }
    out << "xmux21 buf_clk500p_89 buf_clk230p_41 WEN xmux21_row_dec_en MUX21" << endl;
    out << "xor_row_dec_en CLK xmux21_row_dec_en or_row_dec_en OR2" << endl;
    out << "xnand_row_dec_en or_row_dec_en PRE ROW_DEC_EN_small NAND2 NFIN_SIZE=4" << endl;
    out << "xbuf_row_dec_en ROW_DEC_EN_small ROW_DEC_EN BUF NFIN_SIZE=16" << endl;
    out << endl;

    out << "xinv_clkb CLK clkb INV" << endl;
    out << "xbuf_clkb150p_1 clkb buf_clkb150p_1 BUF" << endl;
    for(int i=2; i<=26; i++) {
        out << "xbuf_clkb150p_" << i << " buf_clkb150p_" << i-1 << " buf_clkb150p_" << i << " BUF" << endl;
    }

    out << "xand_saen_small buf_clkb150p_26 buf_clk500p_89 and_saen_small AND2 NFIN_SIZE=4" << endl;
    out << "xand_saen and_saen_small WEN SAEN AND2 NFIN_SIZE=16" << endl;

    out << ".ends" << endl;

    return 0;
}
