#pragma bank 15
const void __at(15) __bank_axelay;

#include "gameboy.h"
#include "rand.h"

#include "../resources/bitmap_axelay_sky.h"
#include "../resources/bitmap_axelay_overlay.h"
#include "../resources/bitmap_axelay_sprites.h"

UINT8 axelay_scroll_x = 0;
UINT8 axelay_scroll_y = 0;
UINT8 axelay_lines[144];

#define sprite_count  8
UINT8 sprite_x[sprite_count];
UINT8 sprite_y[sprite_count];
UINT8 sprite_size[sprite_count]; // 255 not used, else 0-8

UINT8 sprite_id = 0;
UINT8 create = 0;

void axelay_vbl() BANKED
{
	++axelay_scroll_x;
	axelay_scroll_y -= 2;
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	sprite_id = (sprite_id+1)&7;
	UINT8 y = sprite_id;
	if (sprite_size[y]==255)
	{
		create = (create+1)&7;
	
		if (create==0)
		{
			sprite_x[y] = ((UINT8)rand())/4+32;
			sprite_y[y] = 0;
			sprite_size[y] = 0;
			set_sprite_tile(y, 168);
			
			if (rand()>200)
			{
				set_sprite_prop(y, get_sprite_prop(y) | S_PALETTE);
			}
			else
			{
				set_sprite_prop(y, get_sprite_prop(y) & ~S_PALETTE);
			}
		}
	}
	else
	{
		sprite_y[y] += 6;
		UINT8 yeight = sprite_y[y]/9+1;
		int x = 84+(((int)(sprite_x[y]/2))-35)*2*(1+yeight*yeight/20);
		
		if (sprite_y[y]>=100 || x<8 || x>=160)
		{
			sprite_size[y] = 255;
			hide_sprite(y);
		}
		else
		{
			move_sprite(y, x, sprite_y[y]+32);
		
			UINT8 size = (yeight*yeight)/16;
			if (size>7) size = 7;
			if (size != sprite_size[y])
			{
				set_sprite_tile(y, 168+size*2);
				sprite_size[y] = size;
			}
		}
	}
}

UINT8 axelay_mod = 0;
void axelay_lcd() BANKED
{
	UINT8 y = LY_REG;
	
	if (y<144)
	{
		SCX_REG = axelay_scroll_x+sintable[(y+axelay_scroll_x)&127];
		SCY_REG = axelay_scroll_y+axelay_lines[y];
	}
	else
	{
		SCX_REG = 0;
		SCY_REG = 0;
	}
	
	if (y<=4) BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CSILVER);
	else if (y<=8) BGP_REG = PALETTE(CSILVER, CWHITE, CWHITE, CWHITE);
	else if (y<=16) BGP_REG = PALETTE(CGRAY, CSILVER, CWHITE, CWHITE);
	else if (y<=32) BGP_REG = PALETTE(CBLACK, CGRAY, CSILVER, CWHITE);
	else if (y>=143) BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
}

void Scene_Axelay() BANKED
{
	UINT8 y;
	
	axelay_scroll_x = 0;
	axelay_scroll_y = 0;
	sprite_id = 0;
	create = 0;

	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_axelay); }
	
	set_mode1();
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	set_bkg_data(0, bitmap_axelay_sky_tiledata_count, bitmap_axelay_sky_tiledata);
	set_bkg_tiles(0, 0, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(0, 8, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(16, 0, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(16, 8, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(0, 16, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(0, 24, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(16, 16, 16, 8, bitmap_axelay_sky_tilemap0);
	set_bkg_tiles(16, 24, 16, 8, bitmap_axelay_sky_tilemap0);
	
	set_win_data(bitmap_axelay_sky_tiledata_count, bitmap_axelay_overlay_tiledata_count, bitmap_axelay_overlay_tiledata);
	for (y=0 ; y<bitmap_axelay_overlay_tilemap0_count ; ++y)
	{
		UINT8 tile_id = bitmap_axelay_overlay_tilemap0[y]+bitmap_axelay_sky_tiledata_count;
		set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	}
	
	move_win(7, 128);
	SHOW_BKG;
	SHOW_WIN;
		
	SPRITES_8x16;
	for (y=0 ; y<8 ; ++y)
	{
		set_sprite_data(168+y*2, 1, bitmap_axelay_sprites_tiledata+y*16);
		set_sprite_data(168+y*2+1, 1, bitmap_axelay_sprites_tiledata+y*16+16*8);
	}
	
	for (y=0 ; y<sprite_count ; ++y)
	{
		sprite_size[y] = 255;
	}
	SHOW_SPRITES;
			
	const UINT8 sin_limit = 72;
	for (y=0 ; y<144 ; ++y)
	{
		if (y<sin_limit)
		{
			UINT16 decay = (sin_limit-y)/4;
			axelay_lines[y] = sintable[144-(sin_limit+16)]/6 - decay*decay;
		}
		else
		{
			axelay_lines[y] = sintable[144-(y+16)]/6;
		}
	}
	
	axelay_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(axelay_vbl);
	}
    
	BGP_REG = PALETTE(CBLACK, CGRAY, CSILVER, CWHITE);
	int time = 0;
	
	while (++time<7500)
	{
		axelay_lcd();
    	axelay_lcd();
    	axelay_lcd();
    	axelay_lcd();
    	axelay_lcd();
    }
	
	HIDE_SPRITES;
	HIDE_WIN;

	CRITICAL {
		remove_VBL(axelay_vbl);
		SCX_REG = SCY_REG = 0;
	}
}
