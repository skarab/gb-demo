#pragma bank 25
const void __at(25) __bank_rain;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_rain_bkg.h"
#include "../resources/bitmap_rain_sprites.h"

#define rain_sprite_count 30
UINT8 rain_scroll = 0;
UINT8 rain_sprite_x[rain_sprite_count];
UINT8 rain_sprite_y[rain_sprite_count];
UINT8 rain_sprite_a[rain_sprite_count];
UINT8 rain_addx = 0;
UINT8 rain_splash = 0;

void rain_lcd() BANKED
{
	UINT8 y = LY_REG;
	if (y>=104)
	{
		UINT8 z = (UINT8)(144-(int)y);
		z += (y%2)*2;
		UINT8 water = rain_scroll + (y-104) ;
		water = sintable[(water)/2]/(8+z)-(255/(8+z)/2);
		SCX_REG = water;
		++rain_scroll;
	}
	else
	{
		SCX_REG = 0;
	}
}

void update_sprites() BANKED
{
	rain_addx = ~rain_addx;
	rain_splash = (rain_splash+1)%6;
	
	for (UINT8 i=0 ; i<rain_sprite_count ; ++i)
	{
		rain_lcd();
		
		if (rain_sprite_a[i]>0)
		{
			if (rain_splash==0)
			{
				++rain_sprite_a[i];
				if (rain_sprite_a[i]<4)
				{
					set_sprite_tile(i, bitmap_rain_bkg_tiledata_count+8+rain_sprite_a[i]*2);
					move_sprite(i, rain_sprite_x[i], rain_sprite_y[i]);
				}
				else
				{
					rain_lcd();
					rain_sprite_x[i] = rand()%160;
					rain_sprite_y[i] = 0;
					set_sprite_tile(i, bitmap_rain_bkg_tiledata_count+(i%4)*2+1);
					move_sprite(i, rain_sprite_x[i], rain_sprite_y[i]);
					rain_sprite_a[i] = 0;
				}
			}
		}
		else
		{
			UINT8 s = i%2+2;
			
			rain_sprite_y[i] += s;
		
			if (rain_sprite_y[i]>=130)
			{
				if (rand()>220)
				{
					rain_sprite_a[i] = 1;
					set_sprite_tile(i, bitmap_rain_bkg_tiledata_count+8);
					move_sprite(i, rain_sprite_x[i], rain_sprite_y[i]);
				}
			}
		
			if (rain_sprite_a[i]==0)
			{
				if (rain_sprite_y[i]>=144)
				{
					rain_sprite_x[i] = ((UINT8)rand())%160;
					rain_sprite_y[i] = 0;
					set_sprite_tile(i, bitmap_rain_bkg_tiledata_count+(i%4)*2+1);
				}
				//if (rain_addx!=0) // || i%2==0)
				{
					if (s==1 && rain_addx!=0) ++rain_sprite_x[i];
					else if (s==2) ++rain_sprite_x[i];
					else if (s==3)
					{
						if (rain_addx!=0) ++rain_sprite_x[i];
						else rain_sprite_x[i] += 2;
					}
					
					//++rain_sprite_x[i];
					
					if (rain_sprite_x[i]>=160)
					{
						rain_sprite_x[i] = 0;
						rain_sprite_y[i] = ((UINT8)rand())%120;
						set_sprite_tile(i, bitmap_rain_bkg_tiledata_count+(i%4)*2+1);
					}
				}
				
				move_sprite(i, rain_sprite_x[i], rain_sprite_y[i]);
			}
		}
		rain_lcd();
	}
}

void Scene_Rain() BANKED
{
	UINT8 i, j;
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_rain); }
	
	set_mode1();
	set_palette(PALETTE(CWHITE, CWHITE, CWHITE, CWHITE));
	draw_fullscreen_bitmap(bitmap_rain_bkg_tiledata_count, bitmap_rain_bkg_tiledata, bitmap_rain_bkg_tilemap0, bitmap_rain_bkg_tilemap1);
	
	UINT8 clear = 0;
	for (j = 0 ; j<18 ; ++j)
	{
		get_bkg_tiles(19, j, 1, 1, &clear);

		for (i = 20 ; i<32 ; ++i)
			set_bkg_tiles(i, j, 1, 1, &clear);
	}
	
	SPRITES_8x16;
	for (i=0 ; i<8 ; ++i)
	{
		set_sprite_data(bitmap_rain_bkg_tiledata_count+i*2, 1, bitmap_rain_sprites_tiledata+i*16);
		set_sprite_data(bitmap_rain_bkg_tiledata_count+i*2+1, 1, bitmap_rain_sprites_tiledata+i*16+16*8);
	}
	SHOW_SPRITES;
	
	for (i=0 ; i<rain_sprite_count ; ++i)
	{
		rain_sprite_x[i] = rand()%160;
		rain_sprite_y[i] = 164; //rand()%140;
		rain_sprite_a[i] = 0;
		set_sprite_tile(i, bitmap_rain_bkg_tiledata_count+(i%4)*2+1);
		set_sprite_prop(i, get_sprite_prop(i) & ~S_PALETTE);
		move_sprite(i, rain_sprite_x[i], rain_sprite_y[i]);
	}
	
	//set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	
	UINT8 fade = 0;
	UINT8 speed = 1;
	
	int time = 0;
	
	while (++time<1180)
	{
		++time;
		update_sprites();
		
		if (time>110 && fade>0)
		{
			if ((fade-1)/speed==PalFadeCount)
			{
				set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
				fade = 0;
			}
			else
			{
				set_palette(PalFadeWhite[(fade-1)/speed]);
				++fade;
			}
		}
		else
		{
			if (rand()>240)
			{
				fade = 1;
				speed = ((UINT8)rand())%3+1;
			}
		}
	}
	
	FADE_IN_BLACK();
	SCX_REG = 0;
	HIDE_SPRITES;
}