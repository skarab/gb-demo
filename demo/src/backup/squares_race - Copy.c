#pragma bank 6
const void __at(6) __bank_squares_race;

#include "gameboy.h"

extern const unsigned int squares_zoom_tiledata_count;
extern const unsigned char squares_zoom_tiledata[];
extern const unsigned int squares_zoom_tilemap0_count;
extern const unsigned char squares_zoom_tilemap0[];
extern const unsigned int squares_zoom_tilemap1_count;
extern const unsigned char squares_zoom_tilemap1[];
extern const unsigned int squares_zoom_tilemap2_count;
extern const unsigned char squares_zoom_tilemap2[];

UINT8 squares_precalc[72][32];
UINT8 squares_precalc2[72][32];

void squares_race_precalc()
{
	UINT8 offset = 0;
	UINT8 old_size = 16;
	UINT8 s = 255;
	
	//for (UINT8 i = 0 ; i<32 ; ++i)
	UINT8 i = 0;
	for (UINT8 j = 0 ; j<72 ; ++j)
	{
		UINT8 y = j; //+i;
		UINT8 ss = 8; //+y/8;
		UINT8 square_size = y*2 + 16;
		
		if (square_size!=old_size)
		{
			old_size = square_size;
			offset = y;
			s = ~s;
		}
		
		UINT8 add;
		if (s==0) add = (((y-offset)/square_size)&1)*square_size;
		else add = (1-(((y-offset)/square_size)&1))*square_size;
			
		squares_precalc[j][i] = j; // + add;
		squares_precalc2[j][i] = square_size - 16 - (j+72);
	}
}

UINT8 race_anim = 0;

void squares_race_vbl()
{
	//++race_anim;
}

void squares_race_lcd()
{
	UINT8 y = LY_REG;
	
	if (y<72)
	{
		SCY_REG = -y-10;
		SCX_REG = 0;
	}
	else
	{
		UINT8 cy = y-72;
		SCY_REG = squares_precalc2[cy][race_anim/8];
		SCX_REG = squares_precalc[cy][race_anim/8];
	}
}

void Scene_SquaresRace() BANKED
{
	squares_race_precalc();
	
	disable_interrupts();
	DISPLAY_OFF;
	//mode(0);
	HIDE_WIN;
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	set_bkg_data(0, squares_zoom_tiledata_count, squares_zoom_tiledata);
	set_bkg_tiles(0, 0, 32, 8, squares_zoom_tilemap0);
	set_bkg_tiles(0, 8, 32, 8, squares_zoom_tilemap1);
	set_bkg_tiles(0, 16, 32, 6, squares_zoom_tilemap2);
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(squares_race_vbl);
		add_LCD(squares_race_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	DISPLAY_ON;
	enable_interrupts();
	
	while (1)
	{	
		wait_vbl_done();		
    }
	/*
	CRITICAL {
        remove_VBL(squares_race_vbl);
		remove_LCD(squares_race_lcd);
	}*/
}
