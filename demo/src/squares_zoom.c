#pragma bank 6
const void __at(6) __bank_squares_zoom;

#include "gameboy.h"

#include "../resources/squares_zoom.h"
#include "../resources/squares_zoom_precalc.h"

UINT8 squares_scroll = 0;
UINT8 squares_zoom_scroll = 0;
UINT8 squares_size = 0;
UINT8 squares_t = 0;
UINT8 squares_s = 0;

void squares_zoom_vbl1()
{
	++squares_t;
	if (squares_t&4) ++squares_s;
	
	UINT8 sin = sintable[squares_s];
	if (sin>=128)
	{
		squares_size += 1+(sin-128)/128;
		if (squares_size>27)
			squares_size = 27;
	}
	else
	{
		if (squares_size>1+(128-sin)/128)
			squares_size -= 1+(128-sin)/128;
		else
			squares_size = 0;
	}
	
	squares_zoom_scroll = (16+squares_size)/2; //%(16+square_size);
	
	squares_scroll += (squares_size>>4)+1;
	if (squares_scroll>16+squares_size)
		squares_scroll = 0;
}

void squares_zoom_vbl2()
{
	++squares_t;
	if (squares_t&4) ++squares_s;
	
	UINT8 sin = sintable[squares_s];
	if (sin>=128)
	{
		squares_size += 1+(sin-128)/128;
		if (squares_size>27)
			squares_size = 27;
	}
	else
	{
		if (squares_size>1+(128-sin)/128)
			squares_size -= 1+(128-sin)/128;
		else
			squares_size = 0;
	}
	
	squares_zoom_scroll = (16+squares_size)*4; //%(16+square_size);
	
	squares_scroll += (squares_size>>4)+1;
	if (squares_scroll>16+squares_size)
		squares_scroll = 0;
}

/*
UINT8 table[200][41]; //144+16+40
void precalc_table()
{
	for (UINT8 y=0 ; y<200 ; ++y)
	for (UINT8 x=0 ; x<41 ; ++x)
	{
		UINT8 h = y;
		if (h>=200) // 144+16+40
			h = 200;
		table[y][x] = ((h/(16+x))&1)*(16+x);
	}
}*/

void squares_zoom_lcd()
{
	UINT8 y = LY_REG;
	SCY_REG = (squares_size<<2)-y;
	SCX_REG = squares_zoom_precalc[y+squares_scroll][squares_size]+squares_scroll+squares_zoom_scroll;
}

void Scene_SquaresZoom() BANKED
{
	//precalc_table();
	
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
		add_VBL(squares_zoom_vbl1);
		add_LCD(squares_zoom_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	DISPLAY_ON;
	enable_interrupts();
	
	int t = 0;
	
	while (t<400)
	{	
		++t;
		wait_vbl_done();		
    }
	
	CRITICAL {
        remove_VBL(squares_zoom_vbl2);
		set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
		add_VBL(squares_zoom_vbl2);
    }	
	
	t = 0;
	
	while (1)
	{
		++t;
		BGP_REG = PalScroll[++t%PalScrollCount];
		wait_vbl_done();		
    }
}
