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

#define FADE_IN_WHITE() for (fade_counter=0 ; fade_counter<PalScrollCount ; ++fade_counter) { BGP_REG = PalFadeWhite[fade_counter]; wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); }
#define FADE_OUT_WHITE() for (fade_counter=0 ; fade_counter<PalScrollCount ; ++fade_counter) { BGP_REG = PalFadeWhite[PalScrollCount-fade_counter-1]; wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); }
#define FADE_IN_BLACK() for (fade_counter=0 ; fade_counter<PalScrollCount ; ++fade_counter) { BGP_REG = PalFadeBlack[fade_counter]; wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); }
#define FADE_OUT_BLACK() for (fade_counter=0 ; fade_counter<PalScrollCount ; ++fade_counter) { BGP_REG = PalFadeBlack[PalScrollCount-fade_counter-1]; wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); wait_vbl_done(); }
extern unsigned int fade_counter;

#define PAUSE(c) for (pause_counter=0 ; pause_counter<c ; ++pause_counter) wait_vbl_done()
extern unsigned int pause_counter;

void play_music();
void vbl_music();

void play_sample(uint8_t *start, uint16_t len) OLDCALL;

INT8 abs(INT8 a);
INT8 mod(INT8 a, INT8 b);

extern const UINT8 sintable[];

void set_mode1();
void set_mode2();
void exit_draw_mode();

void draw_fullscreen_bitmap(UINT8 tiledata_count, UINT8* tiledata, UINT8* tilemap0, UINT8* tilemap1);
void draw_fullscreen_bitmap_mode2(UINT8 tiledata_count, UINT8* tiledata, UINT8* tilemap0, UINT8* tilemap1);
