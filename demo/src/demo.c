#include "gameboy.h"

void Scene_Erase(int slow, UINT8 color, UINT8 empty) BANKED;
void Scene_ErasePal() BANKED;
void Scene_Shake() BANKED;
void Scene_Sega() BANKED;
void Scene_Lines() BANKED;
void Scene_Cube() BANKED;
void Scene_CubePhysics() BANKED;
void Scene_Fire() BANKED;
void Scene_Axelay() BANKED;
void Scene_SpritesPhysics() BANKED;
void Scene_Zoom() BANKED;
void Scene_Credits() BANKED;
void Scene_SquaresRace() BANKED;
void Scene_Rain() BANKED;
void Scene_VBarrels() BANKED;
void Scene_Kiss() BANKED;
void Scene_FunkyGirl() BANKED;
void Scene_Senses() BANKED;
void Scene_Logo() BANKED;
void Scene_Landscape() BANKED;
void Scene_Title() BANKED;
void Scene_TitleZoomOut() BANKED;
void Scene_Tunnel() BANKED;
void Scene_CubeVideo() BANKED;
void Scene_TunnelVideo() BANKED;
void Scene_Scroller() BANKED;

void main()
{
	set_mode1();
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	
	Scene_Shake();
	Scene_Erase(1, 255, 255);
	Scene_Sega();
	
	while (1)
	{
		play_music();
		
		Scene_Fire();	
		Scene_Lines();	
		Scene_Credits();	
		Scene_Logo();	
		Scene_Title();
		Scene_TitleZoomOut();
		Scene_FunkyGirl();
		Scene_Erase(0, 0, 255);
		Scene_SquaresRace();	
		Scene_CubeVideo();
		Scene_Cube();
		Scene_CubePhysics();	
		Scene_Zoom();	
		Scene_Kiss();	
		Scene_VBarrels();	
		Scene_SpritesPhysics();	
		Scene_TunnelVideo();
		Scene_Tunnel();	
		Scene_Senses();	
		Scene_Axelay();	
		Scene_Landscape();
		Scene_Rain();
		Scene_Scroller();
		
		HIDE_SPRITES;
		HIDE_WIN;
		Scene_Erase(0, 255, 255);
	}
}