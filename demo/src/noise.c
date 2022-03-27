#pragma bank 21
const void __at(21) __bank_noise;

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

void noise_vbl() BANKED
{
	noise_pos = noise_output+(20*2+2);
	noise_y = 0;
	noise_scanline = 0;
}

void noise_lcd() BANKED
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
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_noise); }
	
	set_palette(PALETTE(CWHITE, CWHITE, CWHITE, CWHITE));
	
	set_bkg_data(0, 32, bitmap_fire_tiledata);
	init_bkg(0);
	
	// It seems we cant access safely adresses & things when display is ON, this may troubleshoot the music...
	DISPLAY_OFF;
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
	
	noise_scanline_offsets = &noise_scanline_offsets_tbl[0];
	DISPLAY_ON;
	
	noise_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(noise_vbl);
		add_LCD(noise_lcd);
    }
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	
	int sync = 0;
	
	while (sync++<30)
	{
		noise = (noise+1)%16;
		noise_scanline_offsets = &noise_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
		wait_vbl_done(); 		
    }
	
	CRITICAL {
		remove_LCD(noise_lcd);
		remove_VBL(noise_vbl);
		SCX_REG = 0;
		STAT_REG = 0x44;
	}
	set_interrupts(LCD_IFLAG | VBL_IFLAG);
}
