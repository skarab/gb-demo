#pragma bank 26
const void __at(26) __bank_tunnel_video;

#include "gameboy.h"
#include "../resources/bitmap_tunnel_video.h"
#include "../resources/tunnel_video.h"

void Scene_TunnelVideo() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_tunnel_video); }
	
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	set_mode1();
	set_bkg_data(0, bitmap_tunnel_video_tiledata_count, bitmap_tunnel_video_tiledata);
	
	BGP_REG = PALETTE(CBLACK, CSILVER, CGRAY, CWHITE);
	
	const UINT8* frame = tunnel_video_frames;
	
	int time = 0;
	while (++time<124)
	{
		set_bkg_tiles(0, 0, 20, 18, frame);
		frame += 20*18;
		
		if (frame==tunnel_video_frames_end)
		{
			frame = tunnel_video_frames;
		}
		
		wait_vbl_done();
		BGP_REG = PalScroll[(time/4)%PalScrollCount];
		wait_vbl_done();
	}
}
