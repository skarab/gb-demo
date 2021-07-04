#include "gameboy.h"

extern const void __bank_erase;
void Scene_Erase(int slow) BANKED;
extern const void __bank_sega;
void Scene_Sega() BANKED;
extern const void __bank_lines;
void Scene_Lines() BANKED;
extern const void __bank_cube;
void Scene_Cube() BANKED;
void Scene_CubePhysics() BANKED;
void Scene_Noise() BANKED;
void Scene_Fire() BANKED;
extern const void __bank_axelay;
void Scene_Axelay() BANKED;
void Scene_SpritesPhysics() BANKED;
extern const void __bank_squares_zoom;
void Scene_SquaresZoom() BANKED;
void Scene_SquaresZoom2() BANKED;
extern const void __bank_squares_race;
void Scene_SquaresRace() BANKED;
extern const void __bank_squares_rain;
void Scene_Rain() BANKED;

void main()
{
	LCDC_REG = 0xD1;
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	
	SWITCH_ROM_MBC1((UINT8)&__bank_sega);
	Scene_Erase(1);
	Scene_Sega();
	
	play_music();
	
	SWITCH_ROM_MBC1((UINT8)&__bank_lines);
	Scene_Lines();
	SWITCH_ROM_MBC1((UINT8)&__bank_squares_zoom);
	Scene_SquaresZoom2();
	SWITCH_ROM_MBC1((UINT8)&__bank_cube);
	Scene_Noise();
	Scene_Erase(0);
	Scene_Fire();
	Scene_Erase(1);
	Scene_Cube();
	Scene_CubePhysics();
	SWITCH_ROM_MBC1((UINT8)&__bank_axelay);
	Scene_SpritesPhysics();
	Scene_Erase(0);
	Scene_Axelay();
	SWITCH_ROM_MBC1((UINT8)&__bank_squares_race);
	Scene_SquaresRace();
	SWITCH_ROM_MBC1((UINT8)&__bank_squares_rain);
	Scene_Rain();
	SWITCH_ROM_MBC1((UINT8)&__bank_squares_zoom);
	Scene_SquaresZoom();
}
