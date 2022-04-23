#pragma bank 25
const void __at(25) __bank_tunnel;

#include "gameboy.h"
#include "rand.h"
#include "../resources/tunnel_animation.h"

void Scene_Tunnel() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_tunnel); }
	
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	set_mode1();
	set_bkg_data(0, tunnel_tiledata_count, tunnel_tiledata);
	
	BGP_REG = PALETTE(CBLACK, CSILVER, CGRAY, CWHITE);
	
	const UINT8* frame = tunnel_frames;
	
	int time = 0;
	while (++time<128)
	{
		set_bkg_tiles(0, 0, 20, 18, frame);
		frame += 20*18;
		
		if (frame==tunnel_frames_end)
		{
			frame = tunnel_frames;
		}
		
		wait_vbl_done();
		wait_vbl_done();
	}
}
