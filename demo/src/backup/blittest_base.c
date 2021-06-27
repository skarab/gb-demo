#pragma bank 4
const void __at(4) __bank_fire;

#include "gameboy.h"
#include "rand.h"

//#include "../resources/fire_tiles.h"
extern unsigned char fire_tiles_tiledata[];
extern unsigned char fire_tiles_tilemap[];

UINT8* blittest_output[20*18];
UINT8 blittest_buffer[20*18];
UINT8 blittest_y = 0;
UINT16 blittest_offset = 0;
UINT8** blittest_pos = blittest_output+20;
//UINT8* blittest_buf_pos = blittest_buffer+20;
UINT8 toto = 0;
UINT8 scanline = 0;

void blittest_vbl()
{
	blittest_pos = blittest_output+(20*2+2);
	//blittest_buf_pos = blittest_buffer+20;
	blittest_y = 0;
	//**blittest_pos = toto;
	//++blittest_pos;
	scanline = 0;
}

void blittest_lcd()
{
	for (UINT8 i=scanline ; i<=LY_REG ; ++i)
	{
	UINT8 old = blittest_y;
	blittest_y = scanline>>3; //LY_REG>>3;
	++scanline;
	
	if (blittest_y!=old)
	{
		if (blittest_y==14)
		{
			blittest_pos = blittest_output+2;
			//blittest_buf_pos = blittest_buffer;
		}
		else
		{
			blittest_pos += 4;
			//blittest_buf_pos += 12;
		}
	}
	
	if (blittest_y<13)
	{
		**blittest_pos = toto; //(*blittest_buf_pos)>>2;
		++blittest_pos;
		//++blittest_buf_pos;
		**blittest_pos = toto; //(*blittest_buf_pos)>>2;
		++blittest_pos;
		//++blittest_buf_pos;
	}
	}
//}
	
	//SCX_REG = SCY_REG = 0;
}

void Scene_BlitTest() BANKED
{
	UINT8 x, y;
	
	disable_interrupts();
	DISPLAY_OFF;
	//mode(0);
	HIDE_WIN;
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	set_bkg_data(0, 16, fire_tiles_tiledata);
	
	UINT16 oy = 0;
	for (y=0 ; y!=18 ; ++y)
	{
		for (x=0 ; x!=20 ; ++x)
		{
			*(blittest_output+oy+x) = get_bkg_xy_addr(x, y);
			*(blittest_buffer+oy+x) = 0;
			**(blittest_output+oy+x) = 4;
		}
		oy += 20;
	}
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(blittest_vbl);
		add_LCD(blittest_lcd);
    }
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	DISPLAY_ON;
	enable_interrupts();
	
	while (1)
	{
		CRITICAL {
		toto = (toto+1)%16;
		}
		/*for (x=0 ; x<20 ; ++x)
		{
			*(blittest_buffer+x) = ((UINT8)rand())%21+40;
		}*/
		
		wait_vbl_done(); 
		wait_vbl_done();		
    }
	
	//CRITICAL {
    //    remove_VBL(blittest_vbl);
    //}	
}
