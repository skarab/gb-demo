#pragma bank 5
const void __at(5) __bank_sprites_physics;

#include "gameboy.h"
#include "rand.h"

//#include "../resources/axelay_sprites.h"
extern const unsigned char axelay_sprites_tiledata[];

void Scene_SpritesPhysics() BANKED
{
	UINT8 i;
	
	disable_interrupts();
	DISPLAY_OFF;
	//mode(0);
	HIDE_WIN;
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	init_bkg(255);
	
	SPRITES_8x16;
	for (i=0 ; i<8 ; ++i)
	{
		set_sprite_data(168+i*2, 1, axelay_sprites_tiledata+i*16);
		set_sprite_data(168+i*2+1, 1, axelay_sprites_tiledata+i*16+16*8);
	}
	SHOW_SPRITES;
	
	#define TOINT(x) (x*20)
	#define FROMINT(x) (x/20)
	
	const int near = TOINT(1);
	const int far = TOINT(8);
	const int right = 25;
	const int top = 15;
	const int bottom = -20;
	#define sprite_count 10
	
	int sprite_x[sprite_count];
	int sprite_y[sprite_count];
	int sprite_z[sprite_count];
	int sprite_dx[sprite_count];
	int sprite_dy[sprite_count];
	int sprite_dz[sprite_count];
	UINT8 sprite_size[sprite_count]; // 255 not used, else 0-8
	
	for (i=0 ; i<40 ; ++i)
	{
		hide_sprite(i);
	}
	
	for (i=0 ; i<sprite_count ; ++i)
	{
		sprite_size[i] = 255;
		sprite_x[i] = rand()/(128/right);
		sprite_y[i] = rand()/(128/-bottom);
		sprite_z[i] = TOINT(5);
		sprite_dx[i] = rand()/32;
		if (sprite_dx[i]==0) sprite_dx[i] = 1;
		sprite_dy[i] = 4;
		sprite_dz[i] = rand()/32;
		if (sprite_dz[i]==0) sprite_dz[i] = 1;
	}
	
	DISPLAY_ON;
	enable_interrupts();
	
	int time = 0;
	
	while (1)
	{
		for (i=0 ; i<sprite_count ; ++i)
		{
			int x = sprite_x[i];
			int y = sprite_y[i];
			int z = sprite_z[i];
			int dx = sprite_dx[i];
			int dy = sprite_dy[i];
			int dz = sprite_dz[i];
			
			if (x+dx<-right || x+dx>right) dx = -dx;
			if (y+dy<bottom) dy = -dy;
			if (y+dy>top) dy = -5;
			if (z+dz<near || z+dz>far) dz = -dz;
			
			x += dx;
			y += dy;
			z += dz;

			++dy;
		
			int px = 160 / 2 + x * 160 / 3 / ((z+20)/2);
			int py = 144 / 2 + y * 144 / 3 / ((z+20)/2);
		
			const int size_near = 7;
			const int size_far = 0;	
			int s = size_near - (size_near - size_far) * (z-near) / (far-near);
			UINT8 size = s;
			if (size != sprite_size[i])
			{
				set_sprite_tile(i, 168+size*2);
				sprite_size[i] = size;
			}
		
			move_sprite(i, px, py);
			
			sprite_x[i] = x;
			sprite_y[i] = y;
			sprite_z[i] = z;
			sprite_dx[i] = dx;
			sprite_dy[i] = dy;
			sprite_dz[i] = dz;			
		}
		
		wait_vbl_done();
    }
	
	//CRITICAL {
    //    remove_VBL(blittest_vbl);
    //}	
}
