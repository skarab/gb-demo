#include "gameboy.h"

void Scene_Erase(int slow) BANKED;
void Scene_Shake() BANKED;
void Scene_Sega() BANKED;
void Scene_Lines() BANKED;
void Scene_Cube() BANKED;
void Scene_CubePhysics() BANKED;
void Scene_Noise() BANKED;
void Scene_Fire() BANKED;
void Scene_Axelay() BANKED;
void Scene_SpritesPhysics() BANKED;
void Scene_SquaresZoom() BANKED;
void Scene_SquaresZoom2() BANKED;
void Scene_SquaresRace() BANKED;
void Scene_Rain() BANKED;
void Scene_VBarrels() BANKED;
void Scene_Kiss() BANKED;
void Scene_FunkyGirl() BANKED;
void Scene_Senses() BANKED;
void Scene_Logo() BANKED;
void Scene_Landscape() BANKED;
void Scene_Scroller() BANKED;

void main()
{
	LCDC_REG = 0xD1;
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	HIDE_SPRITES;
	HIDE_WIN;
	
	Scene_Shake();
	Scene_Erase(1);
	Scene_Sega();
	
	play_music();
	Scene_Fire();
	Scene_Erase(1);
	Scene_SpritesPhysics();
	Scene_Erase(0);
	Scene_Logo();
	Scene_SquaresRace();
	Scene_Lines();
	Scene_Cube();
	Scene_FunkyGirl();
	Scene_VBarrels();
	Scene_CubePhysics();
	Scene_Erase(0);
	Scene_Kiss();
	Scene_SquaresZoom2();
	Scene_Axelay();
	Scene_Senses();
	Scene_Rain();
	Scene_SquaresZoom();
	Scene_Noise();
	Scene_Erase(0);
	Scene_Landscape();
	Scene_Scroller();
}
