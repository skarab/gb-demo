#pragma bank 19
const void __at(19) __bank_funky_girl;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_funky_girl.h"
#include "../resources/bitmap_funky_girl_window.h"

UINT8 funky_girl_glitch = 0;

void funky_girl_vbl() BANKED
{
	SCY_REG = 0;
}

void funky_girl_lcd() BANKED
{
	UINT8 y = LY_REG;
	
	if (y%2 == 1)
	{
		SCY_REG = funky_girl_glitch;
	}
	else
	{
		SCY_REG = 0;
	}
}

void Scene_FunkyGirl() BANKED
{
	funky_girl_glitch = 0;
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_funky_girl); }
	
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	set_mode1();
	init_bkg(255);
	draw_fullscreen_bitmap(bitmap_funky_girl_tiledata_count, bitmap_funky_girl_tiledata, bitmap_funky_girl_tilemap0, bitmap_funky_girl_tilemap1);
	
	int availableTiles = 255 - bitmap_funky_girl_window_tiledata_count; // 255 - bitmap_funky_girl_tiledata_count
	set_win_data(availableTiles, bitmap_funky_girl_window_tiledata_count, bitmap_funky_girl_window_tiledata);
	for (int y=0 ; y<bitmap_funky_girl_window_tilemap0_count ; ++y)
	{
		UINT8 tile_id = bitmap_funky_girl_window_tilemap0[y]+availableTiles;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	}
	
	move_win(7, 144);
	SHOW_BKG;
	SHOW_WIN;
	
	funky_girl_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(funky_girl_vbl);
		add_LCD(funky_girl_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	
	int i = 0;
	int time = 0;
	int wh = 144;
	while (++time<108)
	{
		funky_girl_glitch = (funky_girl_glitch + 1) % 3;
		
		if (time>40 && wh>120)
		{
			--wh;
			move_win(7, wh);
		}
		
		wait_vbl_done();
	}
	
	CRITICAL {
		remove_LCD(funky_girl_lcd);
		remove_VBL(funky_girl_vbl);
		SCX_REG = SCY_REG = 0;
	}
	
	HIDE_WIN;
	set_interrupts(VBL_IFLAG);
}
