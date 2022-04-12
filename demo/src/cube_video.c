#pragma bank 32
const void __at(32) __bank_cube_video;

#include "gameboy.h"
#include "../resources/bitmap_cube_video.h"
#include "../resources/cube_video.h"

void Scene_CubeVideo() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_cube_video); }
	
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	set_mode1();
	set_bkg_data(0, bitmap_cube_video_tiledata_count, bitmap_cube_video_tiledata);
	
	BGP_REG = PALETTE(CBLACK, CSILVER, CGRAY, CWHITE);
	
	const UINT8* frame = cube_video_frames;
	
	int time = 0;
	while (++time<80)
	{
		set_bkg_tiles(0, 0, 20, 18, frame);
		frame += 20*18;
		
		if (frame==cube_video_frames_end)
		{
			frame = cube_video_frames;
		}
		
		wait_vbl_done();
		BGP_REG = PalScroll[(time)%PalScrollCount];
		wait_vbl_done();
	}
}
