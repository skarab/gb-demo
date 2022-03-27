#pragma bank 27
const void __at(27) __bank_alien_girl;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_alien_girl.h"

void alien_girl_vbl() BANKED
{
}

void alien_girl_lcd() BANKED
{
}

void Scene_AlienGirl() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_alien_girl); }
	
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	draw_fullscreen_bitmap(bitmap_alien_girl_tiledata_count, bitmap_alien_girl_tiledata, bitmap_alien_girl_tilemap0, bitmap_alien_girl_tilemap1);
	
	alien_girl_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(alien_girl_vbl);
		add_LCD(alien_girl_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	
	int time = 0;
	while (++time<100)
	{
		wait_vbl_done();
	}
	
	CRITICAL {
		remove_LCD(alien_girl_lcd);
		remove_VBL(alien_girl_vbl);
		SCX_REG = SCY_REG = 0;
	}
	
	HIDE_WIN;
	set_interrupts(VBL_IFLAG);
}
