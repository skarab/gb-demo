#pragma bank 20
const void __at(20) __bank_sega;

#include "gameboy.h"
#include "../resources/bitmap_sega.h"
#include "../resources/sega_wav.h"
	
void Scene_Sega() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_sega); }
	
	disable_interrupts();
	set_palette(PalFadeWhite[PalFadeCount-1]);
	SHOW_WIN;
	
    move_bkg(0, 0);
	scroll_bkg(0, 0);
	
	const unsigned char black_tile[] = { 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 };
	const unsigned char black_tilemap[] = { 70 };
	set_win_data(70, 1, black_tile);
	set_bkg_data(70, 1, black_tile);
	for (int j=0 ; j<18 ; ++j)
	for (int i=0 ; i<20 ; ++i)
	{
		set_win_tiles(i, j, 1, 1, black_tilemap);
		set_bkg_tiles(i, j, 1, 1, black_tilemap);
	}
	
	set_win_data(0, bitmap_sega_tiledata_count, bitmap_sega_tiledata);
	set_win_tiles(0, 0, 11, 4, bitmap_sega_tilemap0); // rebels: 17, 4
	move_win(44, 52); // rebels: 20, 52
	enable_interrupts();
	
	int i = 0;
	for (i=0 ; i<PalFadeCount ; ++i)
	{
		set_palette(PalFadeWhite[PalFadeCount-i-1]);
		PAUSE(20);
	}
	
	while (i < 2000)
	{
		BGP_REG = PalScroll[++i%PalScrollCount];
	}	
	
	play_sample(sega_raw, sega_raw_len/16);
	
	for (i=0 ; i<PalFadeCount ; ++i)
	{
		set_palette(PalFadeWhite[i]);
		PAUSE(10);
	}

	// clean play_sample garbage
	const unsigned char empty_sample[] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	};
	play_sample(empty_sample, 1);
	
	disable_interrupts();
	HIDE_WIN;
	NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	enable_interrupts();
}


