#pragma bank 20
const void __at(20) __bank_scroller;

#include "gameboy.h"
#include "rand.h"
#include "../resources/bitmap_alien_girl.h"
#include "../resources/bitmap_alien_girl_full.h"
#include "../resources/bitmap_scroller.h"
#include "../resources/bitmap_scroller_font.h"
#include "../resources/bitmap_scroller_cube.h"

void Scene_Scroller() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_scroller); }
	
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	set_mode2();
	draw_fullscreen_bitmap_mode2(bitmap_alien_girl_full_tiledata_count, bitmap_alien_girl_full_tiledata, bitmap_alien_girl_full_tilemap0, bitmap_alien_girl_full_tilemap1);
	
	FADE_OUT_WHITE();
	PAUSE(100);
	FADE_IN_WHITE();
	
	draw_fullscreen_bitmap_mode2(bitmap_alien_girl_tiledata_count, bitmap_alien_girl_tiledata, bitmap_alien_girl_tilemap0, bitmap_alien_girl_tilemap1);
	set_tile_data(162, bitmap_scroller_cube_tiledata_count, bitmap_scroller_cube_tiledata, 0x80); //128+34
	
	SPRITES_8x8;
	set_sprite_data(0, bitmap_scroller_font_tiledata_count, bitmap_scroller_font_tiledata);
	SHOW_SPRITES;
	
	int txtId = 0;
	const UINT8* txtData = scroller_data;
	UINT8 yOffset = 100;
	UINT8 slowDown = 0;
	UINT8 spritesCount = 0;
	UINT8 palId = PalFadeCount;
	int cubeFramesCount = (360 - 22) / 22;
	int cubeFrameId0 = 0;
	UINT8 animCube0 = 0;
	int cubeFrameId1 = 0;
	UINT8 animCube1 = 0;
	int cubeFrameId2 = 12;
	UINT8 animCube2 = 0;
	UINT8 cubeId = 0;
	UINT8 cubePosX = 12;
	UINT8 cubePosY = 6;
	int cubeTime = 0;
	
	while (1)
	{
		if (palId!=0)
		{
			--palId;
			BGP_REG = PalFadeWhite[palId];
		}
		
		const UINT8* data = txtData;
		int id = txtId;
		UINT8 spriteId = 0;
		for (UINT8 y=0 ; y<6 ; ++y)
		{
			UINT8 scrollY = yOffset+y*10;
			
			UINT8 step = 0;
			if (scrollY<110)
			{
				step = 4-(scrollY-90)/4;
			}
			else if (scrollY>130)
			{
				step = (scrollY-130)/10;
			}
			
			UINT8 count = *data++;
			for (UINT8 i=0 ; i<count && spriteId<40 ; ++i)
			{
				set_sprite_tile(spriteId, 25 * step + *data++);
				move_sprite(spriteId++, 80 + i * 9, scrollY + 4);
				//move_sprite(spriteId++, 164-count*9 + i * 9, scrollY);
			}
			++id;
			if (id==scroller_data_count)
			{
				id = 0;
				data = scroller_data;
			}
		}
		
		if (spriteId<spritesCount)
		{
			for (UINT8 i=spriteId ; i<spritesCount ; ++i)
			{
				move_sprite(i, 0, 0);
			}
		}
		spritesCount = spriteId;
		
		UINT8 slow = spritesCount<10?7:(spritesCount<20?5:(spritesCount<30?4:3));
		if (++slowDown==slow)
		{
			slowDown = 0;
			--yOffset;
			if (yOffset==90)
			{
				yOffset = 100;
				++txtId;
				if (txtId==scroller_data_count)
				{
					txtId = 0;
					txtData = scroller_data;
				}
				else
				{
					txtData += *txtData + 1;
				}
			}
		}
		
		if (cubeTime<1200)
		{
			++cubeTime;
			continue;
		}
	
		if (slowDown%(slow/3)!=0)
		{
			continue;
		}
		
		if (cubeId==0)
		{
			if (animCube0==0)
			{
				int base = cubeFrameId0*4*4;
				set_bkg_based_tiles(cubePosX, cubePosY, 4, 4, bitmap_scroller_cube_tilemap0+base, 162); //128+34);
				if (cubeFrameId0==0) { ++cubeId; cubePosX = 10+((UINT8)rand())%7; cubePosY = 1+((UINT8)rand())%6; }
				cubeFrameId0 = (cubeFrameId0+1)%cubeFramesCount;
			}
			animCube0 = (animCube0+1)%8;
		}
		else if (cubeId==1)
		{
			if (animCube1==0)
			{
				int base = cubeFrameId1*4*4;
				set_bkg_based_tiles(cubePosX, cubePosY, 4, 4, bitmap_scroller_cube_tilemap0+((cubeFramesCount-1)*4*4-base), 162); //128+34);
				if (cubeFrameId1==cubeFramesCount-1) { ++cubeId; cubePosX = 10+((UINT8)rand())%7; cubePosY = 1+((UINT8)rand())%6; }
				cubeFrameId1 = (cubeFrameId1+1)%cubeFramesCount;
			}
			animCube1 = (animCube1+1)%4;
		}
		else if (cubeId==2)
		{
			if (animCube2==0)
			{
				int base = cubeFrameId2*4*4;
				set_bkg_based_tiles(cubePosX, cubePosY, 4, 4, bitmap_scroller_cube_tilemap0+base, 162); //128+34);
				if (cubeFrameId2==0) { cubeId = 0; cubePosX = 10+((UINT8)rand())%7; cubePosY = 1+((UINT8)rand())%6; }
				cubeFrameId2 = (cubeFrameId2+1)%cubeFramesCount;
			}
			animCube2 = (animCube2+1)%6;
		}
		
		if (joypad()==J_START)
			break;
	}

	//set_mode1();
}
