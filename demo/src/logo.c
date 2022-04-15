#pragma bank 27
const void __at(27) __bank_logo;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_logo.h"

int logo_anim = 0;
const int logo_anim_slowdown = 4;
int logo_time = 0;
const int logo_scene_time = 250; // This is used to return outside of "main thread", else it hangs and I really can't figure out why.

void logo_vbl() BANKED
{
	if (logo_time==logo_scene_time) return;
	
	++logo_time;
	++logo_anim;
	if (logo_anim/logo_anim_slowdown>=PalScrollCount)
	{
		logo_anim = 0;
	}
	BGP_REG = PalScroll[logo_anim/logo_anim_slowdown];
	SCY_REG = 0;
}

void logo_lcd() BANKED
{
	UBYTE y = LY_REG;
	
	if (y<80)
	{
		y += logo_time * 4;
		SCY_REG = sintable[y] / 10;
		
		BGP_REG = PalScroll[logo_anim/logo_anim_slowdown];
	}
	else if (y<120)
	{
		BGP_REG = PALETTE(CWHITE, CSILVER, CGRAY, CBLACK);
		
		y += logo_time;
		SCY_REG = sintable[y];
	}
}

void Scene_Logo() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_logo); }
	
	set_mode1();
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	draw_fullscreen_bitmap(bitmap_logo_tiledata_count, bitmap_logo_tiledata, bitmap_logo_tilemap0, bitmap_logo_tilemap1);
	
	logo_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(logo_vbl);
		add_LCD(logo_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	while (logo_time<logo_scene_time)
	{
		wait_vbl_done();
	}
	
	CRITICAL {
		remove_LCD(logo_lcd);
		remove_VBL(logo_vbl);
		SCX_REG = SCY_REG = 0;
	}
	set_interrupts(VBL_IFLAG);
	FADE_IN_WHITE();
}
