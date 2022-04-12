#pragma bank 30
const void __at(30) __bank_title;

#include "gameboy.h"
#include "../resources/bitmap_title.h"
#include "../resources/bitmap_title_full.h"

void Scene_Title() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_title); }
	
	set_mode1();
	BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	
	set_bkg_data(0, bitmap_title_tiledata_count, bitmap_title_tiledata);
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap14);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap14+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap15);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap15+4);
	
	FADE_OUT_WHITE();
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap12);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap12+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap13);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap13+4);
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap10);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap10+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap11);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap11+4);
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap8);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap8+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap9);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap9+4);	
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap6);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap6+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap7);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap7+4);	
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap4);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap4+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap5);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap5+4);
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap2);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap2+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap3);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap3+4);
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap0);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap1);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap1+4);
	PAUSE(3);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap2);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap2+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap3);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap3+4);
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap4);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap4+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap5);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap5+4);
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap2);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap2+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap3);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap3+4);
	PAUSE(1);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap0);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap1);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap1+4);
	
	FADE_IN_WHITE();
	set_bkg_data(0, bitmap_title_full_tiledata_count, bitmap_title_full_tiledata);
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_full_tilemap0);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_full_tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_full_tilemap1);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_full_tilemap1+4);
	BGP_REG = PALETTE(CWHITE, CSILVER, CGRAY, CBLACK);
	
	int i = 0;
	while (++i<80)
	{
		wait_vbl_done();
		wait_vbl_done();
		wait_vbl_done();
		wait_vbl_done();
		wait_vbl_done();
		wait_vbl_done();
		UINT8 p = (UINT8)i%PalScrollCount;
		BGP_REG = PalScroll[p];
	}
	
	FADE_OUT_BLACK();
}

void Scene_TitleZoomOut() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_title); }
	
	set_mode1();
	BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	
	set_bkg_data(0, bitmap_title_tiledata_count, bitmap_title_tiledata);
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap0);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap0+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap1);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap1+4);
	
	FADE_OUT_BLACK();
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap2);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap2+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap3);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap3+4);
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap4);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap4+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap5);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap5+4);
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap6);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap6+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap7);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap7+4);	
	PAUSE(2);

	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap8);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap8+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap9);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap9+4);	
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap10);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap10+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap11);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap11+4);
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap12);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap12+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap13);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap13+4);
	PAUSE(2);
	
	set_bkg_tiles(0, 0, 20, 12, bitmap_title_tilemap14);
	set_bkg_tiles(0, 12, 16, 1, bitmap_title_tilemap14+20*12);
	set_bkg_tiles(16, 12, 4, 1, bitmap_title_tilemap15);
	set_bkg_tiles(0, 13, 20, 5, bitmap_title_tilemap15+4);
	
	FADE_OUT_WHITE();
}