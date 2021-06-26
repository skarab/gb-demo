#pragma bank 1
const void __at(1) __bank_nintendo;

#include "gameboy.h"

#define slots_max_count 10
// x, y, id, previousId, speed
UINT8 slots[slots_max_count*5];
UINT8 tile_x = 0;
UINT8 tile_y = 0;

void init_slots()
{
	for (UINT8 i=0 ; i<slots_max_count ; ++i)
	{
		slots[i*5+2] = 0;
		slots[i*5+3] = 255;
		slots[i*5+4] = i%3+1;
	}
	
	tile_x = 0;
	tile_y = 0;
}

UINT8 get_next_tile(UINT8* x, UINT8* y, UINT8* id)
{
	while (1)
	{
		UINT8 tx = tile_x;
		UINT8 ty = tile_y;
		
		++tile_x;
		if (tile_x==160/8)
		{
			tile_x = 0;
			++tile_y;
		}
		
		if (tile_y==144/8)
			return 0;
		
		UINT8 tileId;
		get_bkg_tiles(tx, ty, 1, 1, &tileId);
		if (tileId!=0)
		{
			*x = tx;
			*y = ty;
			*id = tileId;
			return 1;
		}
	}
}

// x, y, id, previousId, speed
UINT8 update_slots()
{
	UINT8 usedSlots = 0;
	
	for (UINT8 i=0 ; i<slots_max_count ; ++i)
	{
		if (slots[i*5+2]==0)
		{
			UINT8 x, y, id;
			if (get_next_tile(&x, &y, &id))
			{
				slots[i*5+0] = x;
				slots[i*5+1] = y;
				slots[i*5+2] = id;
				slots[i*5+3] = 255;
				
				UINT8 clear = 0;
				set_bkg_tiles(x, y, 1, 1, &clear);
				++usedSlots;
			}
		}
		
		if (slots[i*5+2]!=0)
		{
			UINT8 x = slots[i*5+0];
			UINT8 y = slots[i*5+1];
			UINT8 id = slots[i*5+2];
			UINT8 previousId = slots[i*5+3];
			UINT8 speed = slots[i*5+4];
			
			if (previousId != 255)
			{
				set_bkg_tiles(x, y, 1, 1, &previousId);
			}
			
			y += speed;
			if (y>=144/8)
			{
				slots[i*5+2] = 0;
				slots[i*5+3] = 255;
				++usedSlots;
			}
			else
			{
				get_bkg_tiles(x, y, 1, 1, &previousId);
				if (previousId==255)
					previousId = 0;
				
				set_bkg_tiles(x, y, 1, 1, &id);
				slots[i*5+1] = y;
				slots[i*5+3] = previousId;
				++usedSlots;
			}
		}
	}
	return usedSlots;
}

void Scene_Nintendo() BANKED
{
	init_slots();
	
	while (1)
	{
		if (!update_slots())
			return;
		
		wait_vbl_done();
	}
}
