#pragma bank 27
const void __at(27) __bank_scroller;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_alien_girl.h"
#include "../resources/bitmap_scroller.h"
#include "../resources/bitmap_scroller_font.h"

void scroller_vbl() BANKED
{
}

void scroller_lcd() BANKED
{
}

void Scene_Scroller() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_scroller); }
	
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	draw_fullscreen_bitmap(bitmap_alien_girl_tiledata_count, bitmap_alien_girl_tiledata, bitmap_alien_girl_tilemap0, bitmap_alien_girl_tilemap1);
	
	UINT8 spritesBase = 162;
	
	SPRITES_8x8;
	set_sprite_data(spritesBase, 25*3, bitmap_scroller_font_tiledata);
	
	SHOW_SPRITES;
	
	scroller_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		//add_VBL(scroller_vbl);
		//add_LCD(scroller_lcd);
	}
    //set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	BGP_REG = PALETTE(CWHITE, CSILVER, CGRAY, CBLACK);
	
	int time = 0;
	int angle = 0;
	int txtId = 0;
	const UINT8* txtData = scroller_data;
	UINT8 yOffset = 0;
	UINT8 spritesCount = 0;
	UINT8 slowDown = 4;
	
	while (1)  //++time<100)
	{
		wait_vbl_done();
		
		const UINT8* data = txtData;
		int id = txtId;
		UINT8 spriteId = 0;
		for (UINT8 y=0 ; y<6 ; ++y)
		{
			if (y>1 && y<5) angle = (y+yOffset/slowDown)%3;
			else angle = y==0?0:(y+1)%3;
				
			UINT8 count = *data++;
			for (UINT8 i=0 ; i<count ; ++i)
			{
				set_sprite_tile(spriteId, spritesBase + 25 * angle + *data);
				move_sprite(spriteId, 160+4-count*9 + i * 9, 16+4+y*9-yOffset/slowDown+64);
				++spriteId;
				++data;
			}
			++id;
			if (id==scroller_data_count)
			{
				id = 0;
				data = scroller_data;
			}
		}
		
		if (spriteId<spritesCount)
		{
			for (UINT8 i=spriteId ; i<spritesCount ; ++i)
			{
				move_sprite(i, 0, 0);
			}
		}
		spritesCount = spriteId;
		
		++yOffset;
		if (yOffset==9*slowDown)
		{
			yOffset = 0;
			++txtId;
			if (txtId==scroller_data_count)
			{
				txtId = 0;
				txtData = scroller_data;
			}
			else
			{
				txtData += *txtData + 1;
			}
		}
	}
	
	CRITICAL {
		remove_LCD(scroller_lcd);
		remove_VBL(scroller_vbl);
		SCX_REG = SCY_REG = 0;
	}
	
	HIDE_SPRITES;
	set_interrupts(VBL_IFLAG);
}
