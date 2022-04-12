#include "gameboy.h"

void Scene_Erase(int slow) BANKED;
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
void Scene_Scroller() BANKED;
void Scene_Title() BANKED;
void Scene_TitleZoomOut() BANKED;
void Scene_Tunnel() BANKED;
void Scene_CubeVideo() BANKED;

/*
so the framerate should be 60 FPS and shutter speed is 1/160 (1/180 is ok)


The Dubstep part on the city fits well from yesterday!
Gordian
Gordian Neumann
would make the scene longer until the plasma maybe
*/

void main()
{
	set_mode1();
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	
	Scene_Shake();
	Scene_Erase(1);
	Scene_Sega();
	
	play_music();
	
	Scene_Lines();	
	Scene_Logo();	
	Scene_Fire();	
	Scene_Zoom();	
	Scene_TitleZoomOut();	
	Scene_SpritesPhysics();	
	Scene_FunkyGirl();	
	Scene_CubeVideo();
	Scene_Cube();
	Scene_CubePhysics();	
	Scene_Title();	
	Scene_VBarrels();	
	Scene_Kiss();	
	Scene_Credits();	
	Scene_Axelay();	
	Scene_Landscape();
	Scene_Rain();	
	Scene_SquaresRace();	
	Scene_Senses();	
	Scene_Tunnel();	
	Scene_Scroller();
	
	
/*
	Scene_Fire();
	Scene_Erase(0);
	Scene_Logo();
	//Scene_ErasePal();
	Scene_Lines();
	Scene_FunkyGirl();
	Scene_Erase(0);
	Scene_VBarrels();
	Scene_Credits();
	Scene_SquaresRace();
	Scene_Title();
	Scene_SpritesPhysics();
	Scene_Erase(0);
	Scene_CubeVideo();
	//Scene_ErasePal();
	Scene_Cube();
	Scene_CubePhysics();
	Scene_TitleZoomOut();
	Scene_Senses();
	Scene_Erase(0);
	Scene_Landscape();
	Scene_Rain();
	Scene_Axelay();
	Scene_Kiss();
	Scene_Tunnel();
	Scene_Zoom();
	Scene_Scroller();
	*/

/*
  Rebels:
	Scene_Logo();
	Scene_FunkyGirl();    with picture
	Scene_VBarrels();
	Scene_SquaresRace();
	Scene_Axelay();
	
  Pictures:
	Scene_Senses();
	Scene_Kiss();
	
  Others:
	Scene_Fire();
	Scene_Lines();
	Scene_Landscape();
	Scene_Rain();
	Scene_Zoom();
	Scene_Tunnel();
	Scene_SpritesPhysics();
	
	Scene_CubeVideo();
	Scene_Cube();
	Scene_CubePhysics();
	
  Specials:
	Scene_Credits();
	
	Scene_Title();
	Scene_TitleZoomOut();
	
	Scene_Scroller();	
*/
}
