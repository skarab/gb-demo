#pragma bank 21
const void __at(21) __bank_fire;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_fire.h"
#include "../resources/bitmap_fire_sprites.h"

const INT8 fire_scanline_offsets_tbl[] = {0, 1, 2, 3, 3, 2, 1, 0, 0, -1, -2, -3, -3, -2, -1, 0};
const INT8 * fire_scanline_offsets = fire_scanline_offsets_tbl;
UINT8 fire_wind = 0;

#define fire_sprite_count 12
UINT8 fire_sprite_x[fire_sprite_count];
UINT8 fire_sprite_y[fire_sprite_count];
UINT8 fire_sprite_a[fire_sprite_count];
int fire_sync = 0;
	
void fire_lcd() BANKED
{
	UINT8 y = LY_REG;
	INT8 offset = (fire_scanline_offsets[y & (UBYTE)7]+1)*2;
	
	if (y<=40)
	{
		SCX_REG = 0;
	}
	else
	{
		SCX_REG = offset * (123-y)/(12+fire_wind);
	}
}

void fire_update_sprites() BANKED
{
	for (UINT8 i=0 ; i<fire_sprite_count ; ++i)
	{
		fire_sprite_y[i] -= 2;
		fire_sprite_x[i] += rand()%2;
		
		if (fire_wind<10 && fire_sync>4)
			fire_sprite_x[i] -= 2;
		
		UINT8 c = (144-fire_sprite_y[i])/32;
		
		if (c>=3 || fire_sprite_x[i]>=160)
		{
			fire_sprite_x[i] = 60+((UINT8)rand())%40;
			fire_sprite_y[i] = 134+rand()%10;
			fire_sprite_a[i] = 0;
			set_sprite_tile(i, 80);
			move_sprite(i, fire_sprite_x[i], fire_sprite_y[i]);	
		}
		else
		{
			if (c!=fire_sprite_a[i])
			{
				fire_sprite_a[i] = c;
				set_sprite_tile(i, 80+fire_sprite_a[i]);
			}
			
			move_sprite(i, fire_sprite_x[i], fire_sprite_y[i]);	
		}
	}
}

void Scene_Fire() BANKED
{
	UINT8* fire_output[20*18];
	UINT8 fire_buffer[20*18];
	UINT8 x, y;
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_fire); }
	
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	init_bkg(0);
	set_bkg_data(0, bitmap_fire_tiledata_count, bitmap_fire_tiledata);
	set_bkg_data(255, 1, bitmap_fire_tiledata);
	
	// It seems we cant access safely adresses & things when display is ON, this may troubleshoot the music...
	DISPLAY_OFF;
	UINT16 oy = 0;
	for (y=0 ; y<18 ; ++y)
	{
		for (x=0 ; x<20 ; ++x)
		{
			*(fire_output+oy+x) = get_bkg_xy_addr(x, y);
			*(fire_buffer+oy+x) = 0;
			
			if (y==2 && x>=2 && x<18)
			{
				**(fire_output+oy+x) = bitmap_fire_tilemap0[32+x-2];
			}
			else
			{
				**(fire_output+oy+x) = 0;
			}
		}
		oy += 20;
	}
	DISPLAY_ON;
	
	SPRITES_8x8;
	set_sprite_data(80, 3, bitmap_fire_sprites_tiledata);
	
	for (UINT8 i=0 ; i<fire_sprite_count ; ++i)
	{
		fire_sprite_x[i] = 60+rand()%40;
		fire_sprite_y[i] = 134+rand()%10;
		fire_sprite_a[i] = 0;
		set_sprite_tile(i, 80);
		move_sprite(i, fire_sprite_x[i], fire_sprite_y[i]);
	}
	SHOW_SPRITES;
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	
	while (1)
	{
		fire_scanline_offsets = &fire_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
		
		for (x=6 ; x<14 ; ++x)
		{
			*(fire_buffer+17*20+x) = ((UINT8)rand())%21+40;
			**(fire_output+17*20+x) = (*(fire_buffer+17*20+x))>>2;
			fire_lcd();
		}

		fire_update_sprites();
		
		oy = 6*20;
		for (y=6 ; y<17 ; ++y)
		{
			for (x=3 ; x<17 ; ++x)
			{
				UINT8 left = *(fire_buffer+oy+20+(UINT16)(x-1));
				UINT8 middle = *(fire_buffer+oy+20+x);
				UINT8 right = *(fire_buffer+oy+20+x+1);
				UINT8 value = (left+middle+right)/3;
				
				if (value>=6)
					value -= 6;
				
				*(fire_buffer+oy+x) = value;
				**(fire_output+oy+x) = value>>2;
				fire_lcd();
			}
			oy += 20;
			fire_update_sprites();
		}
		
		++fire_sync;
		fire_wind = fire_scanline_offsets_tbl[(fire_sync%32)*3/5]*60;
		
		if (fire_sync>25)
			break;
	}
	
	HIDE_SPRITES;
}
