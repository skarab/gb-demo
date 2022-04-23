#pragma bank 17
const void __at(17) __bank_scroller_start;

#include "gameboy.h"
#include "rand.h"

void Scene_Scroller_Start() BANKED
{
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_scroller_start); }
	
	
}
