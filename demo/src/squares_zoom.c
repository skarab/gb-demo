#pragma bank 16
const void __at(16) __bank_squares_zoom;

#include "gameboy.h"

#include "../resources/squares_zoom.h"
#include "../resources/squares_zoom_precalc.h"
#include "../resources/bitmap_credits.h"
#include "../resources/bitmap_credits_font.h"
#include "../resources/bitmap_torus.h"

UINT8 squares_scroll = 0;
UINT8 squares_zoom_scroll = 0;
UINT8 squares_size = 0;
UINT8 squares_t = 0;
UINT8 squares_s = 0;

void squares_zoom_vbl1() BANKED
{
	squares_t += 3;
	//if (squares_t&2) ++squares_s;
	++squares_s;
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
	
	squares_scroll += (squares_size>>4)+2;
	if (squares_scroll>16+squares_size)
		squares_scroll = 0;
}

void credits_vbl() BANKED
{
	squares_t+=2;
	if (squares_t&6) ++squares_s;
	
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
		{
			squares_size = 0;
			squares_s += 3;
		}
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

void credits_lcd() BANKED
{
	UINT8 y = LY_REG;
	SCY_REG = (squares_size<<2)-y;
	SCX_REG = squares_zoom_precalc[y+squares_scroll][squares_size]+squares_scroll+squares_zoom_scroll;
}

void Scene_Zoom() BANKED
{
	squares_scroll = 0;
	squares_zoom_scroll = 0;
	squares_size = 0;
	squares_t = 0;
	squares_s = 0;

	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_squares_zoom); }

	set_mode1();
	set_palette(PALETTE(CWHITE, CWHITE, CWHITE, CWHITE));
	set_bkg_data(0, squares_zoom_tiledata_count, squares_zoom_tiledata);
	set_bkg_tiles(0, 0, 32, 8, squares_zoom_tilemap0);
	set_bkg_tiles(0, 8, 32, 8, squares_zoom_tilemap1);
	set_bkg_tiles(0, 16, 32, 6, squares_zoom_tilemap2);
	
	SPRITES_8x16;
	for (UINT8 i=0 ; i<bitmap_torus_tiledata_count/2 ; ++i)
	{
		set_sprite_data(180+i*2, 1, bitmap_torus_tiledata+i*16);
		set_sprite_data(180+i*2+1, 1, bitmap_torus_tiledata+i*16+(bitmap_torus_tiledata_count/2)*16);
	}
	SHOW_SPRITES;
	
	squares_zoom_vbl1();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(squares_zoom_vbl1);
		add_LCD(squares_zoom_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	FADE_OUT_WHITE();
	
	set_sprite_tile(0, 180);
	set_sprite_tile(1, 182);
	move_sprite(0, 16, 24);
	move_sprite(1, 24, 24);
	
	int x = 16;
	int y = 24;
	int dx = 2;
	int dy = 2;
	
	int time = 0;
	int anim = 0;
	while (++time<180)
	{	
		set_sprite_tile(0, 180+4*anim);
		set_sprite_tile(1, 180+4*anim+2);
		move_sprite(0, x, y);
		move_sprite(1, x+8, y);
	
		x += dx;
		y += dy;
		
		if (x<=10 || x>=136)
			dx = -dx;
		if (y<=16 || y>=116)
			dy = -dy;
	
		++anim;
		if (anim>=bitmap_torus_tiledata_count/4)
		{
			anim = 0;
		}
		
		wait_vbl_done();
	}
	
	FADE_IN_WHITE();
	HIDE_SPRITES;
	
	CRITICAL {
        remove_LCD(squares_zoom_lcd);
		remove_VBL(squares_zoom_vbl1);
		SCY_REG = SCX_REG = 0;
	}
}
			  
void Scene_Credits() BANKED
{
	squares_scroll = 0;
	squares_zoom_scroll = 0;
	squares_size = 0;
	squares_t = 0;
	squares_s = 0;

	const char* credits[] = { "critikill", "aceman", "skarab" };
	const int creditsLength[] = { 9, 6, 6 };
	UINT8 creditId = 0;
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_squares_zoom); }
	
	set_mode2();
	set_palette(PALETTE(CBLACK, CBLACK, CBLACK, CBLACK));
	
	set_tile_data(0, 128, squares_zoom_tiledata, 0x90);
	set_tile_data(128, squares_zoom_tiledata_count-128, squares_zoom_tiledata+128*16, 0x80);
	set_bkg_tiles(0, 0, 32, 8, squares_zoom_tilemap0);
	set_bkg_tiles(0, 8, 32, 8, squares_zoom_tilemap1);
	set_bkg_tiles(0, 16, 32, 6, squares_zoom_tilemap2);
	
	set_tile_data(squares_zoom_tiledata_count, bitmap_credits_tiledata_count, bitmap_credits_tiledata, 0x80);
	for (UINT8 y=0 ; y<bitmap_credits_tilemap0_count ; ++y)
	{
		UINT8 tile_id = bitmap_credits_tilemap0[y]+squares_zoom_tiledata_count;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	}
	
	SPRITES_8x8;
	set_sprite_data(0, bitmap_credits_font_tiledata_count, bitmap_credits_font_tiledata);
	SHOW_SPRITES;
	
	move_win(255, 82);
	SHOW_BKG;
	SHOW_WIN;
	
	squares_s = 80;
	
	credits_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(credits_vbl);
		add_LCD(credits_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	//FADE_OUT_BLACK();	
	fade_counter=0;
	
	UINT8 win_x = 255;
	UINT8 win_y = 82;
	int time = 0;
	UINT8 c = 0;
	UINT8 stopper = 1;
	int wait = 0;
	while (++time<136 || creditId<3)
	{
		if (fade_counter<(PalScrollCount-1)*4+1)
		{
			BGP_REG = PalFadeBlack[PalScrollCount-fade_counter/4-1];
			++fade_counter;
		}
		
		++wait;
		if (wait>0 && creditId<3)
		{
			UINT8 sin = sintable[squares_s];
			/*if (sin<128)
			{
			}
			else*/
			{
				//stopper = 0;
				if (sin>128)
				{
					if (win_x>=60+20) win_x -= 20;
					else win_x = 60;
					if (win_x==60) win_y += 3;
				}
				else if (win_x!=255)
				{
					win_x = 255;
					win_y = 82;
					
					for (UINT8 i=0 ; i<10 ; ++i)
						move_sprite(i, 0, 0);
					
					++creditId;
					c = 0;
					stopper = 1;
				}
			}
			move_win(win_x, win_y);
			
			if (win_x<80)
			{
				for (UINT8 j=0 ; j<(creditId==0?3:2) ; ++j)
				{
					set_sprite_tile(c, credits[creditId][c]-'a');
					move_sprite(c, 82 + c * 9, 132);
					c = (c+1)%creditsLength[creditId];
				}
			}
		}
		
		wait_vbl_done();
	}
	
	FADE_IN_WHITE();
	HIDE_WIN;

	CRITICAL {
        remove_VBL(credits_vbl);
		remove_LCD(credits_lcd);
		SCY_REG = SCX_REG = 0;
	}
}
