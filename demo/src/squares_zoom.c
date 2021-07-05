#pragma bank 23
const void __at(23) __bank_squares_zoom;

#include "gameboy.h"

#include "../resources/squares_zoom.h"
#include "../resources/squares_zoom_precalc.h"
#include "../resources/bitmap_squares_bkg.h"

UINT8 squares_scroll = 0;
UINT8 squares_zoom_scroll = 0;
UINT8 squares_size = 0;
UINT8 squares_t = 0;
UINT8 squares_s = 0;

void squares_zoom_vbl1() BANKED
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

void squares_zoom_vbl2() BANKED
{
	squares_t+=2;
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

void squares_zoom_lcd() BANKED
{
	UINT8 y = LY_REG;
	SCY_REG = (squares_size<<2)-y;
	SCX_REG = squares_zoom_precalc[y+squares_scroll][squares_size]+squares_scroll+squares_zoom_scroll;
}

void Scene_SquaresZoom() BANKED
{
	disable_interrupts();
	DISPLAY_OFF;
	LCDC_REG = 0xD1;
	HIDE_WIN;
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	set_bkg_data(0, squares_zoom_tiledata_count, squares_zoom_tiledata);
	vbl_music();
	set_bkg_tiles(0, 0, 32, 8, squares_zoom_tilemap0);
	vbl_music();
	set_bkg_tiles(0, 8, 32, 8, squares_zoom_tilemap1);
	vbl_music();
	set_bkg_tiles(0, 16, 32, 6, squares_zoom_tilemap2);
	vbl_music();
	
	DISPLAY_ON;
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(squares_zoom_vbl1);
		add_LCD(squares_zoom_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	enable_interrupts();
	
	int time = 0;
	while (1) //++time<400)
	{	
		wait_vbl_done();
	}
	
	disable_interrupts();
	CRITICAL {
        remove_VBL(squares_zoom_vbl1);
		remove_LCD(squares_zoom_lcd);
		SCY_REG = SCX_REG = 0;
	}
	enable_interrupts();
}

void Scene_SquaresZoom2() BANKED
{
	mode(M_TEXT_OUT); // ugly hacky way to stop gfx mode interrupts!!!
	
	disable_interrupts();
	DISPLAY_OFF;
	//mode(0);
	//LCDC_REG = 0xD1;
	//HIDE_WIN;
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	set_bkg_data(0, squares_zoom_tiledata_count, squares_zoom_tiledata);
	vbl_music();
	set_bkg_tiles(0, 0, 32, 8, squares_zoom_tilemap0);
	vbl_music();
	set_bkg_tiles(0, 8, 32, 8, squares_zoom_tilemap1);
	vbl_music();
	set_bkg_tiles(0, 16, 32, 6, squares_zoom_tilemap2);
	vbl_music();
	
	set_win_data(squares_zoom_tiledata_count, bitmap_squares_bkg_tiledata_count, bitmap_squares_bkg_tiledata);
	for (UINT8 y=0 ; y<bitmap_squares_bkg_tilemap0_count ; ++y)
	{
		UINT8 tile_id = bitmap_squares_bkg_tilemap0[y]+squares_zoom_tiledata_count;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
		vbl_music();
	}
	vbl_music();
	
	move_win(7, 98);
	SHOW_BKG;
	SHOW_WIN;
	
	DISPLAY_ON;
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(squares_zoom_vbl2);
		add_LCD(squares_zoom_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	enable_interrupts();
	
	UINT8 win_x = 255;
	UINT8 win_y = 82;
	int time = 0;
	while (++time<400)
	{
		wait_vbl_done();
		
		UINT8 sin = sintable[squares_s];
		win_x -= 2;
		if (win_x<60) win_y += 2;
		if (win_x==1 || sin<128)
		{
			win_x = 255;
			win_y = 82;
		}
		move_win(win_x, win_y);
	}
	
	disable_interrupts();
	CRITICAL {
        remove_VBL(squares_zoom_vbl2);
		remove_LCD(squares_zoom_lcd);
		SCY_REG = SCX_REG = 0;
	}
	enable_interrupts();
}
