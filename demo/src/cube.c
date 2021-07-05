#pragma bank 21
const void __at(4) __bank_cube;

#include "gameboy.h"
#include <gb/drawing.h>
#include "rand.h"

#include "../data/cube.h"
#include "../resources/cube_header.h"

const unsigned int palettes[] = { PALETTE(CWHITE, CBLACK, CWHITE, CWHITE), PALETTE(CWHITE, CWHITE, CBLACK, CWHITE), PALETTE(CWHITE, CWHITE, CWHITE, CBLACK) };
const unsigned int palettes2[] = { PALETTE(CBLACK, CWHITE, CBLACK, CBLACK), PALETTE(CBLACK, CBLACK, CWHITE, CBLACK), PALETTE(CBLACK, CBLACK, CBLACK, CWHITE) };

UINT8 draw_color = 1;

void Scene_Cube() BANKED
{
	const INT8 cube_x = 160 / 2;
	const INT8 cube_y = 144 / 2;
	unsigned int offset = 0;
	unsigned int sync = 0;
	
	LCDC_REG = 0xD1;
	SCY_REG = SCX_REG = 0;
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	SPRITES_8x8;
	SHOW_SPRITES;
	
	while (1)
	{
		vmemset((void*)(0x8000+(draw_color-1)*1920), 0, 1920);
		if (sync>25)
		{
			BGP_REG = palettes2[draw_color-1];
		}
		color(draw_color, 0, SOLID);
		
		++offset;
		UINT8 count = resources_cube_data[offset++];
		for (UINT8 i=0 ; i<count ; ++i)
		{
			INT8 p0x = cube_x + resources_cube_data[offset];
			INT8 p0y = cube_y + resources_cube_data[offset+1];
			INT8 p1x = cube_x + resources_cube_data[offset+2];
			INT8 p1y = cube_y + resources_cube_data[offset+3];
			line(p0x, p0y, p1x, p1y);
			offset += 4;
		}
		
		++draw_color;
		if (draw_color & 4)
		{
			draw_color = 1;
		}

		for (UINT8 i=0 ; i<10 ; ++i)
		{
			set_sprite_tile(i, 0x7C+((UINT8)rand())%4);
			move_sprite(i, ((UINT8)rand())%152, ((UINT8)rand())%136);
		}

		if (offset == resources_cube_data_size) offset = 0;
		
		++sync;
		if (sync==134)
			break;
	}
}
	
UINT8 motion_blur_enabled = 0;
UINT8 vbl_y = 0;

void motion_blur_vbl() BANKED
{
	if (motion_blur_enabled)
	{
		if (vbl_y==0)
			set_default_palette();
		else if (vbl_y==40)
			BGP_REG = palettes[draw_color-1];
	}
	
	++vbl_y;
	if (vbl_y>=144/8)
		vbl_y=0;
}

#define room_up 39 //55
#define room_down 78
#define room_left 70
#define room_right 90
#define room_bottom 113

const UINT8 room_lines[] = {
	0, room_bottom, room_left, room_down,
	//0, 38, room_left, room_up,
	room_left, room_up, room_left, room_down,
	room_left, room_down, room_right, room_down,
	room_right, room_down, 159, room_bottom,
	//room_right, room_up, 159, 38,
	room_right, room_up, room_right, room_down,
	//room_right, room_up, room_left, room_up,
	room_left, room_up, room_right, room_up };
const UINT8 room_lines_count = 5; //8;

void Scene_CubePhysics() BANKED
{
	LCDC_REG = 0xD1;
	
	set_default_palette();
	
	unsigned int offset = 0;
	
	#define TOINT(x) (x*20)
	#define FROMINT(x) (x/20)
	
	const int size_near = 80;
	const int size_far = 16;
	const int near = TOINT(1);
	const int far = TOINT(8);
	int px = TOINT(0);
	int py = TOINT(0);
	int pz = TOINT(5);
	int sx = 4;
	int sy = 4;
	int sz = 2;
	
	INT8 direction = 1;
	
	unsigned int sync = 0;
	UINT8 logo_y = 0;
	UINT8 room_line_id = 0;
	
	disable_interrupts();
	CRITICAL {
		add_VBL(motion_blur_vbl);
	}
	enable_interrupts();
	
	SPRITES_8x8;
	SHOW_SPRITES;
	
	vmemset((void*)0x8000, 0, 1920);
		
	while (1)
	{
		++sync;
		
		if (sync>80 && logo_y<80)
		{
			UINT8 y = logo_y/2;
			
			if (y*2==logo_y)
			for (UINT8 x=0 ; x<40 ; ++x)
			{
				UINT8 p = ___images_cube_header_raw[y*40+x];
				plot(x * 4, y, (p & 3), SOLID);
				plot(x * 4 + 1, y, (p >> 2) & 3, SOLID);
				plot(x * 4 + 2, y, (p >> 4) & 3, SOLID);
				plot(x * 4 + 3, y, (p >> 6) & 3, SOLID);
			}
			++logo_y;
		}		
		
		if (sync>190)
		{
			motion_blur_enabled = 1;
		}
		
		if (sync>260)
		{
			break;
		}
		
		if (px+sx<-20 || px+sx>20)
		{
			sx = -sx;
			
			if (sync%8==0)
			{
				direction = -direction;
			}
		}
		if (py+sy<-18) sy = -sy;
		if (py+sy>15) sy = -5;
		if (pz+sz<near || pz+sz>far) sz = -sz;
		
		px += sx;
		py += sy;
		pz += sz;

		++sy;
		
		int cube_x = 160 / 2 + px * 160 / 3 / ((pz+20)/2);
		int cube_y = 144 / 2 + py * 144 / 3 / ((pz+20)/2);
		int size = size_near - (size_near - size_far) * (pz-near) / (far-near);
	
		if (draw_color>1)
			vmemset((void*)(0x8000+(draw_color-1)*1920), 0, 1920);
		
		if (motion_blur_enabled==0)
			BGP_REG = palettes[draw_color-1];
		
		color(draw_color, 0, SOLID);
		unsigned int previousOffset = offset;
		UINT8 previousCount = resources_cube_data[offset++];
		UINT8 count = resources_cube_data[offset++];
		for (UINT8 i=0 ; i<count ; ++i)
		{
			INT8 p0x = (INT8)(cube_x + (int)resources_cube_data[offset] * size / 160);
			INT8 p0y = (INT8)(cube_y + (int)resources_cube_data[offset+1] * size / 160);
			INT8 p1x = (INT8)(cube_x + (int)resources_cube_data[offset+2] * size / 160);
			INT8 p1y = (INT8)(cube_y + (int)resources_cube_data[offset+3] * size / 160);
			line(p0x, p0y, p1x, p1y);
			offset += 4;
		}

		if (sync>180)
		{
			for (UINT8 r=0 ; r<3 ; ++r)
			{
				const UINT8* room = room_lines + room_line_id * 4;
				line(room[0], room[1], room[2], room[3]);
				++room_line_id;
				if (room_line_id==room_lines_count) room_line_id = 0;
			}
		}
		
		if (direction==-1)
		{
			if (previousOffset==0) previousOffset = resources_cube_data_size;
			offset = previousOffset-previousCount*4-2;
		}
		else if (offset == resources_cube_data_size)
		{
			offset = 0;
		}
		
		++draw_color;
		if (draw_color & 4)
		{
			draw_color = 1;
		}
		
		for (UINT8 i=0 ; i<10 ; ++i)
		{
			set_sprite_tile(i, (UINT8)rand());
			move_sprite(i, ((UINT8)rand())%152, ((UINT8)rand())%136);
		}
	}
	
	disable_interrupts();
	mode(0);
	CRITICAL {
		remove_VBL(motion_blur_vbl);
	}
	enable_interrupts();
	
	HIDE_SPRITES;
}
