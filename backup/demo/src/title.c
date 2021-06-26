#pragma bank 3
const void __at(3) __bank_title;

#include "gameboy.h"
#include <gb/drawing.h>
#include "../resources/title.h"

void Scene_Title() BANKED
{
	LCDC_REG = 0xD1;
	
	set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
			
	color(BLACK, WHITE, SOLID);
	//line(0, 0, 159, 143);

	UINT8 x, y, k;
	
	for (x=0 ; x<25 ; ++x)
	for (k=0 ; k<4 ; ++k)
	for (y=k ; y<142 ; y+=4)
	{
		UINT8 p = resources_title_raw[y*25+x];
		plot(x * 4, y, (p & 3), SOLID);
		plot(x * 4 + 1, y, (p >> 2) & 3, SOLID);
		plot(x * 4 + 2, y, (p >> 4) & 3, SOLID);
		plot(x * 4 + 3, y, (p >> 6) & 3, SOLID);
	}
	
	x = 0;
	y = 0;
	
	PAUSE(50);
	set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	PAUSE(105);
	
	int sync = 0;
	while (1)
	{
		++sync;
		if (sync>615)
			break;
		
		for (k=0 ; k<10 ; ++k)
		{
			UINT8 c = getpix(x, y);
			plot_point(x, y);
			plot(x, y+1, c, SOLID);
			plot(x, y+2, c, SOLID);
			
			x += 3;
			if (x>=100) x-= 100;
		}
		
		y += 3;
		if (y>=142) y-= 142;
	}
	
	color(0, 0, SOLID);
	for (y=0 ; y<144 ; ++y)
	{
		line(0, y, 159, y);
	}
}
