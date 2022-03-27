#pragma bank 25
const void __at(25) __bank_vbarrels;

#include "gameboy.h"

#include "../resources/vbarrels.h"
#include "../resources/bitmap_vbarrels_wnd.h"

UINT8 vbarrels_time = 0;
int vbarrels_global_time = 0; // This is used to return outside of "main thread", else it hangs and I really can't figure out why.

void vbarrels_vbl() BANKED
{
	vbarrels_time = (vbarrels_time+1);
	++vbarrels_global_time;
}

void vbarrels_lcd() BANKED
{
	if (vbarrels_global_time>800) return;
	
	UINT8 y = LY_REG;
	if (y>=112)
	{
		UINT8 sin = vbarrels_time%128;
		UINT8 tsin = sintable[sin];
		SCY_REG = (tsin >> 1);
		SCX_REG = tsin/10;
	}
	else
	{
		UINT8 sin = (vbarrels_time+y/8)%128;
		UINT8 tsin = sintable[sin];
		SCY_REG = -y+(tsin >> 1);
		SCX_REG = tsin/10;
	}
}

void Scene_VBarrels() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_vbarrels); }
	
	set_palette(PALETTE(CWHITE, CWHITE, CWHITE, CWHITE));
	init_bkg(0);
	set_bkg_data(0, vbarrels_tiledata_count, vbarrels_tiledata);
	set_bkg_tiles(0, 0, 20, 12, vbarrels_tilemap0);
	set_bkg_tiles(0, 12, 16, 1, vbarrels_tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, vbarrels_tilemap1);
	set_bkg_tiles(0, 13, 20, 9, vbarrels_tilemap1+4);
	
	set_win_data(vbarrels_tiledata_count, bitmap_vbarrels_wnd_tiledata_count, bitmap_vbarrels_wnd_tiledata);
	for (UINT8 y=0 ; y<bitmap_vbarrels_wnd_tilemap0_count ; ++y)
	{
		UINT8 tile_id = bitmap_vbarrels_wnd_tilemap0[y]+vbarrels_tiledata_count;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	}
	
	move_win(7, 112);
	SHOW_WIN;
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	
	vbarrels_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(vbarrels_vbl);
		add_LCD(vbarrels_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	while (vbarrels_global_time<800)
	{	
		wait_vbl_done();
	}
	
	CRITICAL {
    	remove_LCD(vbarrels_lcd);
	    remove_VBL(vbarrels_vbl);
		SCY_REG = SCX_REG = 0;
	}
	
	HIDE_WIN;
}
