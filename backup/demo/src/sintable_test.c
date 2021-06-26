#pragma bank 5
const void __at(5) __bank_axelay;

#include "gameboy.h"

#include "../resources/axelay_sky.h"

UINT8 scroll_x = 0;
UINT8 scroll_y = 0;
UINT8 axelay_lines[144];

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

void axelay_vbl()
{
	++scroll_x;
	++scroll_y;
}

void axelay_lcd()
{
	UINT8 y = LY_REG;
	SCX_REG = scroll_x;
	SCY_REG = scroll_y+axelay_lines[y];
}

void Scene_Axelay() BANKED
{
	disable_interrupts();
	DISPLAY_OFF;
	//mode(0);
	HIDE_WIN;
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	set_bkg_data(0, 256, axelay_sky_tiledata);
	set_bkg_tiles(0, 0, 16, 16, axelay_sky_tilemap);
	set_bkg_tiles(16, 0, 16, 16, axelay_sky_tilemap);
	set_bkg_tiles(0, 16, 16, 16, axelay_sky_tilemap);
	set_bkg_tiles(16, 16, 16, 16, axelay_sky_tilemap);
	
	for (UINT8 y=0 ; y<144 ; ++y)
	{
		axelay_lines[y] = sintable[y];
	}	
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(axelay_vbl);
		add_LCD(axelay_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	DISPLAY_ON;
	enable_interrupts();
	
	while (1)
	{
		wait_vbl_done();		
    }
	
	//CRITICAL {
    //    remove_VBL(blittest_vbl);
    //}	
}
