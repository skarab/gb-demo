#pragma bank 4
const void __at(4) __bank_fire;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_fire.h"

const INT8 fire_scanline_offsets_tbl[] = {0, 1, 2, 3, 3, 2, 1, 0, 0, -1, -2, -3, -3, -2, -1, 0};
const INT8 * fire_scanline_offsets = fire_scanline_offsets_tbl;
UINT8 fire_wind = 0;

void fire_lcd()
{
	UINT8 y = LY_REG;
	INT8 offset = (fire_scanline_offsets[y & (UBYTE)7]+1)*2;
	
	if (y<=40)
	{
		SCX_REG = 0;
	}
	else
	{
		SCX_REG = offset * (123-y)/(12+fire_wind);
	}
}

void Scene_Fire() BANKED
{
	UINT8* fire_output[20*18];
	UINT8 fire_buffer[20*18];
	UINT8 x, y;

	disable_interrupts();
	DISPLAY_OFF;
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	set_bkg_data(0, bitmap_fire_tiledata_count, bitmap_fire_tiledata);
	set_bkg_data(255, 1, bitmap_fire_tiledata);
	
	UINT16 oy = 0;
	for (y=0 ; y<18 ; ++y)
	{
		for (x=0 ; x<20 ; ++x)
		{
			*(fire_output+oy+x) = get_bkg_xy_addr(x, y);
			*(fire_buffer+oy+x) = 0;
			
			if (y==2 && x>=2 && x<18)
			{
				**(fire_output+oy+x) = bitmap_fire_tilemap0[32+x-2];
			}
			else
			{
				**(fire_output+oy+x) = 0;
			}
		}
		oy += 20;
	}	
	DISPLAY_ON;
	enable_interrupts();
	
	int sync = 0;
	
	while (1)
	{
		fire_scanline_offsets = &fire_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
		
		for (x=6 ; x<14 ; ++x)
		{
			*(fire_buffer+17*20+x) = ((UINT8)rand())%21+40;
			**(fire_output+17*20+x) = (*(fire_buffer+17*20+x))>>2;
			fire_lcd();
		}

		oy = 6*20;
		for (y=6 ; y<17 ; ++y)
		{
			for (x=3 ; x<17 ; ++x)
			{
				UINT8 left = *(fire_buffer+oy+20+(UINT16)(x-1));
				UINT8 middle = *(fire_buffer+oy+20+x);
				UINT8 right = *(fire_buffer+oy+20+x+1);
				UINT8 value = (left+middle+right)/3;
				
				if (value>=6)
					value -= 6;
				
				*(fire_buffer+oy+x) = value;
				**(fire_output+oy+x) = value>>2;
				fire_lcd();
			}
			oy += 20;
		}
		
		++sync;
		fire_wind = fire_scanline_offsets_tbl[(sync%32)*3/5]*60;
		
		if (sync>60)
			break;
	}
}
