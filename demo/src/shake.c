#pragma bank 15
const void __at(15) __bank_shake;

#include "gameboy.h"
#include "rand.h"

UINT8 shake_glitch = 0;

void shake_vbl() BANKED
{
	SCY_REG = 0;
}

void shake_lcd() BANKED
{
	UINT8 y = LY_REG;
	
	if (y%2 == 1)
	{
		SCY_REG = shake_glitch;
	}
	else
	{
		SCY_REG = 0;
	}
}

void Scene_Shake() BANKED
{
	shake_glitch = 0;
	
	__critical { SWITCH_ROM_MBC5((UINT8)&__bank_shake); }
	
	shake_vbl();
	
	CRITICAL {
        STAT_REG = 0x18;
		add_VBL(shake_vbl);
		add_LCD(shake_lcd);
	}
    set_interrupts(LCD_IFLAG | VBL_IFLAG);
	
	int i = 0;
	while (i++<40)
	{
		shake_glitch = (shake_glitch + 1) % 3;
		wait_vbl_done();
	}
	
	CRITICAL {
		remove_LCD(shake_lcd);
		remove_VBL(shake_vbl);
		SCX_REG = SCY_REG = 0;
	}
	set_interrupts(VBL_IFLAG);
}
