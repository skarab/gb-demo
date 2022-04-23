#include "gameboy.h"

const unsigned int PalScroll[] = { PALETTE(CWHITE, CSILVER, CGRAY, CBLACK), PALETTE(CSILVER, CGRAY, CWHITE, CBLACK), PALETTE(CGRAY, CWHITE, CSILVER, CBLACK) };
const unsigned int PalScrollCount = 3;
const unsigned int PalFadeWhite[] = { PALETTE(CWHITE, CSILVER, CGRAY, CBLACK), PALETTE(CWHITE, CWHITE, CSILVER, CGRAY), PALETTE(CWHITE, CWHITE, CWHITE, CSILVER), PALETTE(CWHITE, CWHITE, CWHITE, CWHITE) };
const unsigned int PalFadeBlack[] = { PALETTE(CWHITE, CSILVER, CGRAY, CBLACK), PALETTE(CSILVER, CGRAY, CBLACK, CBLACK), PALETTE(CGRAY, CBLACK, CBLACK, CBLACK), PALETTE(CBLACK, CBLACK, CBLACK, CBLACK) };
const unsigned int PalFadeCount = 4;

const UINT8 sintable[256] = {
	128,133,139,144,150,155,160,166,
	171,176,181,186,191,196,201,205,
	209,214,218,222,225,229,232,235,
	238,241,243,245,247,249,251,252,
	253,254,255,255,255,255,255,254,
	253,252,251,249,247,245,243,241,
	238,235,232,229,225,222,218,214,
	209,205,201,196,191,186,181,176,
	171,166,160,155,150,144,139,133,
	128,122,116,111,105,100,95,89,
	84,79,74,69,64,59,54,50,
	46,41,37,33,30,26,23,20,
	17,14,12,10,8,6,4,3,
	2,1,0,0,0,0,0,1,
	2,3,4,6,8,10,12,14,
	17,20,23,26,30,33,37,41,
	46,50,54,59,64,69,74,79,
	84,89,95,100,105,111,116,122 };

inline void set_palette(unsigned int palette)
{
	BGP_REG = palette;
}

inline void set_default_palette()
{
	BGP_REG = 0xE4U;
}

unsigned int pause_counter;
unsigned int fade_counter;

void VGMPlayerInit();
void VGMPlayerUpdate();

void vbl_music()
{
	static UINT8 __save;
	__save = _current_bank;
	VGMPlayerUpdate();
	SWITCH_ROM_MBC5(__save);
}

void play_music()
{
	disable_interrupts();
	__critical {
		VGMPlayerInit();
		STAT_REG = 0x18;
		remove_VBL(vbl_music);
		add_VBL(vbl_music);
	}
	set_interrupts(VBL_IFLAG);
	enable_interrupts();
}

INT8 abs(INT8 a)
{
	return a<0?-a:a;
}

INT8 mod(INT8 a, INT8 b)
{
    INT8 r = a % b;
    return r < 0 ? r + b : r;
}

void set_mode1()
{
	LCDC_REG = 0xD1;
	HIDE_SPRITES;
	HIDE_WIN;
	set_interrupts(VBL_IFLAG);
	
	for (UINT8 i=0 ; i<40 ; ++i)
	{
		move_sprite(i, 0, 0);
		set_sprite_prop(i, get_sprite_prop(i) & ~S_PALETTE);
	}
}

void set_mode2()
{
	LCDC_REG = 0xC1;
	HIDE_SPRITES;
	HIDE_WIN;
	set_interrupts(VBL_IFLAG);
	
	for (UINT8 i=0 ; i<40 ; ++i)
	{
		move_sprite(i, 0, 0);
		set_sprite_prop(i, get_sprite_prop(i) & ~S_PALETTE);
	}
}

void exit_draw_mode()
{
	// ugly hacky way to stop gfx mode.
	disable_interrupts();
	mode(0);
	enable_interrupts();
	mode(M_TEXT_OUT); 
	set_mode1();
}

void draw_fullscreen_bitmap(UINT8 tiledata_count, UINT8* tiledata, UINT8* tilemap0, UINT8* tilemap1)
{
	set_bkg_data(0, tiledata_count, tiledata);
	set_bkg_tiles(0, 0, 20, 12, tilemap0);
	set_bkg_tiles(0, 12, 16, 1, tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, tilemap1);
	set_bkg_tiles(0, 13, 20, 5, tilemap1+4);
}

void draw_fullscreen_bitmap_mode2(UINT8 tiledata_count, UINT8* tiledata, UINT8* tilemap0, UINT8* tilemap1)
{
	set_tile_data(0, 128, tiledata, 0x90);
	set_tile_data(128, tiledata_count-128, tiledata+128*16, 0x80);
	
	set_bkg_tiles(0, 0, 20, 12, tilemap0);
	set_bkg_tiles(0, 12, 16, 1, tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, tilemap1);
	set_bkg_tiles(0, 13, 20, 5, tilemap1+4);
}

