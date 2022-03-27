#pragma bank 24
const void __at(24) __bank_squares_race;

#include "gameboy.h"
#include "../resources/squares_race.h"
#include "../resources/squares_race_precalc.h"
#include "../resources/bitmap_race_bkg.h"

/*
THIS MOVED TO THE GENERATOR

#define race_loop 40
#define race_divide 12
#define race_i_mul 12/8
UINT8 squares_precalc_x[72][race_loop];
UINT8 squares_precalc_y[72][race_loop];

void squares_race_precalc()
{
	for (UINT8 i = 0 ; i<race_loop ; ++i)
	{
		UINT8 old_size = ((i*race_i_mul)*(i*race_i_mul))/race_divide;
		UINT8 s = ((i*race_i_mul)/race_divide)&1;
	
		for (UINT8 j = 0 ; j<72 ; ++j)
		{
			UINT8 square_size = j*2/3 + 16;
			UINT8 p = (j+(i*race_i_mul))/race_divide;
			UINT8 psquare_size = p*p;
			
			if (psquare_size!=old_size)
			{
				old_size = psquare_size;
				s = !s;
			}
			
			UINT8 add = 0;
			if (s!=0) add = square_size;
			
			UINT8 sin = j*sintable[i*3]/64;
		
			squares_precalc_x[j][i] = (add + j + sin) % (square_size*2);
			squares_precalc_y[j][i] = (square_size - 16)*4;
		}
	}
}
*/

UINT8 race_anim = 0;
UINT8 race_scroll_bkg_x = 0;

void squares_race_vbl() BANKED
{
	++race_anim;
	if (race_anim>=race_loop)
		race_anim = 0;
	if (race_anim<race_loop/2) --race_scroll_bkg_x;
	else ++race_scroll_bkg_x;
	
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CSILVER);
}

void squares_race_lcd() BANKED
{
	UINT8 y = LY_REG;
	
	if (y>=30 && y<58)
	{
		SCY_REG = -y-10;
		SCX_REG = 0;
		BGP_REG = PALETTE(CWHITE, CSILVER, CGRAY, CBLACK);
	}
	else if (y>=80)
	{
		UINT8 cy = y-80;
		UINT8 ra = race_anim;
		SCX_REG = squares_precalc_x[cy][ra];
		SCY_REG = squares_precalc_y[cy][ra]-y;
	}
	else if (y<30)
	{
		UINT8 cy = 72-y*2-6;
		UINT8 ra = race_anim;
		SCX_REG = squares_precalc_x[cy][ra];
		SCY_REG = squares_precalc_y[cy][ra]-y;
	}
	else
	{
		SCX_REG = race_scroll_bkg_x;
		SCY_REG = (176-58);
	}
}

void Scene_SquaresRace() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_squares_race); }
	
	set_palette(PALETTE(CWHITE, CWHITE, CWHITE, CWHITE));
	init_bkg(255);
	set_bkg_data(0, squares_race_tiledata_count, squares_race_tiledata);
	set_bkg_tiles(0, 0, 32, 8, squares_race_tilemap0);
	set_bkg_tiles(0, 8, 32, 8, squares_race_tilemap1);
	set_bkg_tiles(0, 16, 32, 6, squares_race_tilemap2);
	set_bkg_data(squares_race_tiledata_count, bitmap_race_bkg_tiledata_count, bitmap_race_bkg_tiledata);
	for (UINT8 x=0 ; x<bitmap_race_bkg_tilemap0_count ; ++x)
	{
		UINT8 tile_id = bitmap_race_bkg_tilemap0[x]+squares_race_tiledata_count;
		set_bkg_tiles(x%32, x/32+22, 1, 1, &tile_id);
	}
	
	squares_race_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(squares_race_vbl);
		add_LCD(squares_race_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	int t = 0;
	while (t<10000)
	{	
		++t;
		//wait_vbl_done();		
    }
	
	CRITICAL {
        remove_LCD(squares_race_lcd);
		remove_VBL(squares_race_vbl);
		SCX_REG = SCY_REG = 0;
	}
	set_palette(PALETTE(CWHITE, CWHITE, CWHITE, CWHITE));
	init_bkg(0);
}
