#include <gb/gb.h>

#define CWHITE  0U
#define CSILVER 1U
#define CGRAY   2U
#define CBLACK  3U

#define PALETTE(c0, c1, c2, c3) c0 | c1 << 2 | c2 << 4 | c3 << 6

extern const unsigned int PalScroll[];
extern const unsigned int PalScrollCount;
extern const unsigned int PalFadeWhite[];
extern const unsigned int PalFadeBlack[];
extern const unsigned int PalFadeCount;

void set_palette(unsigned int palette);
void set_default_palette();

#define PAUSE(c) for (pause_counter=0 ; pause_counter<c ; ++pause_counter) wait_vbl_done()
extern unsigned int pause_counter;

void play_music();
void vbl_music();

void play_sample(uint8_t *start, uint16_t len) OLDCALL;

INT8 abs(INT8 a);
INT8 mod(INT8 a, INT8 b);

extern const UINT8 sintable[];

void draw_fullscreen_bitmap(UINT8 tiledata_count, UINT8* tiledata, UINT8* tilemap0, UINT8* tilemap1);
