#pragma bank 4
const void __at(4) __bank_noise;

#include "gameboy.h"

extern const unsigned int bitmap_fire_tiledata_count;
extern const unsigned char bitmap_fire_tiledata[];
extern const unsigned int bitmap_fire_tilemap0_count;
extern const unsigned char bitmap_fire_tilemap0[];

UINT8* noise_output[20*18];
UINT8 noise_y = 0;
UINT8** noise_pos = noise_output+20;
UINT8 noise = 0;
UINT8 noise_scanline = 0;
const UBYTE noise_scanline_offsets_tbl[] = {0, 1, 2, 3, 3, 2, 1, 0, 0, 1, 2, 3, 3, 2, 1, 0};
const UBYTE* noise_scanline_offsets = noise_scanline_offsets_tbl;

void noise_vbl()
{
	noise_pos = noise_output+(20*2+2);
	noise_y = 0;
	noise_scanline = 0;
}

void noise_lcd()
{
	SCX_REG = (noise_scanline_offsets[noise_scanline & (UBYTE)7]+1)*2;
	
	for (UINT8 i=noise_scanline ; i<=LY_REG ; ++i)
	{
		UINT8 old = noise_y;
		noise_y = noise_scanline>>3;
		++noise_scanline;
		
		if (noise_y!=old)
		{
			if (noise_y==10)
			{
				noise_pos = noise_output+2;
			}
			else
			{
				noise_pos += 4;
			}
		}
	
		if (noise_y<9)
		{
			**noise_pos = noise;
			++noise_pos;
			**noise_pos = noise;
			++noise_pos;
		}
	}
}

void Scene_Noise() BANKED
{
	UINT8 x, y;
	
	disable_interrupts();
	//mode(M_TEXT_OUT); // ugly hacky way to stop gfx mode interrupts!!!
	//enable_interrupts();
	
	DISPLAY_OFF;
	init_bkg(0);
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	set_bkg_data(0, 32, bitmap_fire_tiledata);
	
	UINT16 oy = 0;
	for (y=0 ; y!=18 ; ++y)
	{
		for (x=0 ; x!=20 ; ++x)
		{
			*(noise_output+oy+x) = get_bkg_xy_addr(x, y);
			
			if (y==12 && x>=2 && x<18)
			{
				**(noise_output+oy+x) = bitmap_fire_tilemap0[16+x-2];
			}
			else			
			{
				**(noise_output+oy+x) = 4;
			}
		}
		oy += 20;
	}
	DISPLAY_ON;
	
	//disable_interrupts();
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(noise_vbl);
		add_LCD(noise_lcd);
    }
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	enable_interrupts();
	
	int sync = 0;
	
	while (sync++<30)
	{
		noise = (noise+1)%16;
		noise_scanline_offsets = &noise_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
		//wait_vbl_done(); 		
    }
	
	disable_interrupts();
	CRITICAL {
		remove_LCD(noise_lcd);
		remove_VBL(noise_vbl);
		SCX_REG = 0;
		STAT_REG = 0x44;
	}
	set_interrupts(LCD_IFLAG | VBL_IFLAG);
	enable_interrupts();
}
