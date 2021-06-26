#pragma bank 5
const void __at(5) __bank_axelay;

#include "gameboy.h"

#include "../resources/axelay_sky.h"
#include "../resources/axelay_overlay.h"
#include "../resources/axelay_fog.h"

UINT8 axelay_scroll_x = 0;
UINT8 axelay_scroll_y = 0;
UINT8 axelay_lines[144];
UINT8 axelay_offset = 0;

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
	++axelay_scroll_x;
	--axelay_scroll_y;
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
}

UINT8 axelay_mod = 0;
void axelay_lcd()
{
	UINT8 y = LY_REG;
	
	if (y<144-axelay_offset)
	{
		SCX_REG = axelay_scroll_x+sintable[y+axelay_scroll_x&127];
		SCY_REG = axelay_scroll_y+axelay_lines[y+axelay_offset];
	}
	else
	{
		SCX_REG = 0;
		SCY_REG = 0;
	}
	
	if (y<=4) BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CSILVER);
	else if (y<=8) BGP_REG = PALETTE(CWHITE, CWHITE, CSILVER, CGRAY);
	else if (y<=12) BGP_REG = PALETTE(CWHITE, CSILVER, CGRAY, CBLACK);
}

void Scene_Axelay() BANKED
{
	UINT8 x, y;
	
	disable_interrupts();
	DISPLAY_OFF;
	//mode(0);
	HIDE_WIN;
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	set_bkg_data(0, 128, axelay_sky_tiledata);
	set_bkg_tiles(0, 0, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(0, 8, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(16, 0, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(16, 8, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(0, 16, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(0, 24, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(16, 16, 16, 8, axelay_sky_tilemap);
	set_bkg_tiles(16, 24, 16, 8, axelay_sky_tilemap);
	
	set_win_data(128, 40, axelay_overlay_tiledata);
	for (y=0 ; y<40 ; ++y)
	{
		UINT8 tile_id = y+128;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	}
	
	move_win(7, 144);
	SHOW_BKG;
	SHOW_WIN;
	
	/*
	SPRITES_8x16;
	set_sprite_data(0, 2, axelay_fog_tiledata);
	for (x=0 ; x<10 ; ++x)
	{
		set_sprite_tile(x, 0);
		move_sprite(x, x*16, 16);
	}
	SHOW_SPRITES;*/
	
	const UINT8 sin_limit = 88;
	for (y=0 ; y<144 ; ++y)
	{
		if (y<sin_limit)
		{
			UINT16 decay = sin_limit-y;
			axelay_lines[y] = sintable[144-sin_limit]/10 - decay*decay / 20;
		}
		else
		{
			axelay_lines[y] = sintable[144-y]/10;
		}	
	}
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(axelay_vbl);
		add_LCD(axelay_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	DISPLAY_ON;
	enable_interrupts();
	
	int time = 0;
	
	while (1)
	{
		++time;
		
		if (time>150 && axelay_offset<16)
		{
			++axelay_offset;
			move_win(7, 144-axelay_offset);
		}
		
		wait_vbl_done();		
    }
	
	//CRITICAL {
    //    remove_VBL(blittest_vbl);
    //}	
}
