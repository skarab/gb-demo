#pragma bank 1
const void __at(1) __bank_sega;

#include "gameboy.h"
#include "../resources/sega.h"
#include "../resources/sega_wav.h"
	
void Scene_Sega() BANKED
{
	disable_interrupts();
	DISPLAY_OFF;
	LCDC_REG = 0x67;
	BGP_REG = OBP0_REG = OBP1_REG = 0xE4U;

    move_bkg(0, 0);
	scroll_bkg(0, 0);
	
	const unsigned char black_tile[] = { 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 };
	const unsigned char black_tilemap[] = { 44 };
	set_win_data(44, 1, black_tile);
	set_bkg_data(44, 1, black_tile);
	for (int j=0 ; j<18 ; ++j)
	for (int i=0 ; i<20 ; ++i)
	{
		set_win_tiles(i, j, 1, 1, black_tilemap);
		set_bkg_tiles(i, j, 1, 1, black_tilemap);
	}
	
	set_win_data(0, 44, sega_tiledata);
	set_win_tiles(0, 0, 11, 4, sega_tilemap);
	move_win(44, 52);
	
	DISPLAY_ON;
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
	const unsigned char toto[] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	};
	play_sample(toto, 1);
	
	disable_interrupts();
	NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	enable_interrupts();
}


