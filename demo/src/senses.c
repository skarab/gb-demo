#pragma bank 27
const void __at(27) __bank_senses;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_senses.h"

int sense_anim = 0;
	
void senses_vbl() BANKED
{
	SCX_REG = 0;
	SCY_REG = 0;
	++sense_anim;
}

void senses_lcd() BANKED
{
	UBYTE y = LY_REG + sense_anim;
	
	if ((y>50 && y<80) || y<sense_anim*2)
		SCY_REG = sintable[y];
	if ((y>70 && y<90) || y<sense_anim*4)
		SCX_REG = sintable[y];
}

void Scene_Senses() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_senses); }
	
	set_mode1();
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	draw_fullscreen_bitmap(bitmap_senses_tiledata_count, bitmap_senses_tiledata, bitmap_senses_tilemap0, bitmap_senses_tilemap1);
	
	senses_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(senses_vbl);
		add_LCD(senses_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	
	int time = 0;
	while (++time<400)
	{
		wait_vbl_done();
	}
	
	CRITICAL {
		remove_LCD(senses_lcd);
		remove_VBL(senses_vbl);
		SCX_REG = SCY_REG = 0;
	}
	
	HIDE_WIN;
	set_interrupts(VBL_IFLAG);
}
