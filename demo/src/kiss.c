#pragma bank 26
const void __at(26) __bank_kiss;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_kiss.h"
#include "../resources/bitmap_kiss_window.h"

UINT8 glitch = 0;

void kiss_vbl() BANKED
{
	SCY_REG = 0;
}

void kiss_lcd() BANKED
{
	UINT8 y = LY_REG;
	
	if (y%2 == 1)
	{
		SCY_REG = glitch;
	}
	else
	{
		SCY_REG = 0;
	}
}

void Scene_Kiss() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_kiss); }
	
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	draw_fullscreen_bitmap(bitmap_kiss_tiledata_count, bitmap_kiss_tiledata, bitmap_kiss_tilemap0, bitmap_kiss_tilemap1);
	
	int availableTiles = 255 - bitmap_kiss_window_tiledata_count; // 255 - bitmap_kiss_tiledata_count
	set_win_data(availableTiles, bitmap_kiss_window_tiledata_count, bitmap_kiss_window_tiledata);
	for (int y=0 ; y<bitmap_kiss_window_tilemap0_count ; ++y)
	{
		UINT8 tile_id = bitmap_kiss_window_tilemap0[y]+availableTiles;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	}
	
	move_win(7, 144 - 32);
	SHOW_BKG;
	SHOW_WIN;
	
	kiss_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(kiss_vbl);
		add_LCD(kiss_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	
	int i = 0;
	int time = 0;
	while (++time<100)
	{
		glitch = (glitch + 1) % 3;
		wait_vbl_done();
		move_win(7 + sintable[i] / 30, 144 - 32);
		i = (i+24) % 255;
	}
	
	CRITICAL {
		remove_LCD(kiss_lcd);
		remove_VBL(kiss_vbl);
		SCX_REG = SCY_REG = 0;
	}
	
	HIDE_WIN;
	set_interrupts(VBL_IFLAG);
}
