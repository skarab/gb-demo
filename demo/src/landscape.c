#pragma bank 28
const void __at(28) __bank_landscape;

#include "gameboy.h"
#include <gb/drawing.h>
#include "rand.h"

#include "../data/landscape.h"

const unsigned int landscape_palettes[] = { PALETTE(CWHITE, CBLACK, CWHITE, CWHITE), PALETTE(CWHITE, CWHITE, CBLACK, CWHITE), PALETTE(CWHITE, CWHITE, CWHITE, CBLACK) };
const unsigned int landscape_palettes2[] = { PALETTE(CBLACK, CWHITE, CBLACK, CBLACK), PALETTE(CBLACK, CBLACK, CWHITE, CBLACK), PALETTE(CBLACK, CBLACK, CBLACK, CWHITE) };

UINT8 landscape_draw_color = 1;

void Scene_Landscape() BANKED
{
	unsigned int frameId = 0;
	unsigned int sync = 0;
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_landscape); }
	
	LCDC_REG = 0xD1;
	SCY_REG = SCX_REG = 0;
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	while (++sync<300)
	{
		vmemset((void*)(0x8000+(landscape_draw_color-1)*1920), 0, 1920);
		BGP_REG = landscape_palettes2[landscape_draw_color-1];
		color(landscape_draw_color, 0, SOLID);
		
		const UINT8* input = resources_landscape_data + frameId*200;
		for (UINT8 i=0 ; i<100 ; ++i)
		{
			plot_point(input[i*2], input[i*2+1]);
		}
		
		if (sync>200)
		{
			for (UINT8 i=0 ; i<8 ; ++i)
			{
				UINT8 idx = ((UINT8)rand()) % 9;
				UINT8 idy = ((UINT8)rand()) % 9;
				UINT8 id = (idy*10+idx) * 2;
				
				UINT8 p0x = input[id];
				UINT8 p0y = input[id+1];
				UINT8 p1x;
				UINT8 p1y;
				
				if (i%2==0)
				{
					p1x = input[id+2];
					p1y = input[id+3];
				}
				else
				{
					p1x = input[id+20];
					p1y = input[id+21];
				}
				
				line(p0x, p0y, p1x, p1y);
			}
		}
		
		++frameId;
		if (frameId == resources_landscape_frames)
			frameId = 0;
		
		++landscape_draw_color;
		if (landscape_draw_color & 4)
		{
			landscape_draw_color = 1;
		}
		
		++sync;
	}
	
	//mode(M_TEXT_OUT); // ugly hacky way to stop gfx mode interrupts!!!
	disable_interrupts();
	mode(0);
	enable_interrupts();
	
	mode(M_TEXT_OUT); // ugly hacky way to stop gfx mode interrupts!!!
	LCDC_REG = 0xD1;
	
	CRITICAL {
		STAT_REG = 0x44;
	}
	set_interrupts(VBL_IFLAG);
}
