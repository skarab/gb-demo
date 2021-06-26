#include "gameboy.h"

extern const void __bank_sega;
void Scene_Nintendo() BANKED;
void Scene_Sega() BANKED;
extern const void __bank_part1_music;
extern const hUGESong_t part1_music;
extern const void __bank_title;
extern const void __bank_cube;
void Scene_Title() BANKED;
void Scene_Lines() BANKED;
void Scene_Cube() BANKED;
void Scene_CubePhysics() BANKED;
void Scene_Noise() BANKED;
void Scene_Fire() BANKED;
void Scene_BlitTest() BANKED;
extern const void __bank_axelay;
void Scene_Axelay() BANKED;
void Scene_SpritesPhysics() BANKED;
extern const void __bank_squares_zoom;
void Scene_SquaresZoom() BANKED;
void Scene_SquaresRace() BANKED;

void main()
{
	LCDC_REG = 0xD1;
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	/*
	SWITCH_ROM_MBC1((UINT8)&__bank_sega);
	Scene_Nintendo();
	Scene_Sega();
	*/
	play_music(&part1_music, (UINT8)&__bank_part1_music);
	/*
	SWITCH_ROM_MBC1((UINT8)&__bank_title);
	Scene_Lines();
	Scene_Title();
	SWITCH_ROM_MBC1((UINT8)&__bank_cube);
	Scene_Cube();
	Scene_CubePhysics();
	Scene_Noise();
	Scene_Nintendo();
	Scene_Fire();
	SWITCH_ROM_MBC1((UINT8)&__bank_axelay);
	Scene_Axelay();
	Scene_SpritesPhysics();*/
	SWITCH_ROM_MBC1((UINT8)&__bank_squares_zoom);
	//Scene_SquaresZoom();
	Scene_SquaresRace();
	
	//Scene_BlitTest();
}
