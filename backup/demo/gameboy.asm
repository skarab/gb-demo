;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module gameboy
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _vbl_music
	.globl _hUGE_dosound
	.globl _hUGE_init
	.globl _add_VBL
	.globl _current_music_bank
	.globl _pause_counter
	.globl _sintable
	.globl _PalFadeCount
	.globl _PalFadeBlack
	.globl _PalFadeWhite
	.globl _PalScrollCount
	.globl _PalScroll
	.globl _set_palette
	.globl _set_default_palette
	.globl _play_music
	.globl _abs
	.globl _mod
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_pause_counter::
	.ds 2
_current_music_bank::
	.ds 1
_vbl_music___save_65536_111:
	.ds 1
_play_music_vbl_done_65536_113:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;src\gameboy.c:55: static int vbl_done = 0;
	ld	hl, #_play_music_vbl_done_65536_113
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src\gameboy.c:29: inline void set_palette(unsigned int palette)
;	---------------------------------
; Function set_palette
; ---------------------------------
_set_palette::
;src\gameboy.c:31: BGP_REG = palette;
	ldhl	sp,	#2
	ld	a, (hl)
	ldh	(_BGP_REG+0),a
;src\gameboy.c:32: }
	ret
_PalScroll:
	.dw #0x00e4
	.dw #0x00c9
	.dw #0x00d2
_PalScrollCount:
	.dw #0x0003
_PalFadeWhite:
	.dw #0x00e4
	.dw #0x0090
	.dw #0x0040
	.dw #0x0000
_PalFadeBlack:
	.dw #0x00e4
	.dw #0x00f9
	.dw #0x00fe
	.dw #0x00ff
_PalFadeCount:
	.dw #0x0004
_sintable:
	.db #0x80	; 128
	.db #0x85	; 133
	.db #0x8b	; 139
	.db #0x90	; 144
	.db #0x96	; 150
	.db #0x9b	; 155
	.db #0xa0	; 160
	.db #0xa6	; 166
	.db #0xab	; 171
	.db #0xb0	; 176
	.db #0xb5	; 181
	.db #0xba	; 186
	.db #0xbf	; 191
	.db #0xc4	; 196
	.db #0xc9	; 201
	.db #0xcd	; 205
	.db #0xd1	; 209
	.db #0xd6	; 214
	.db #0xda	; 218
	.db #0xde	; 222
	.db #0xe1	; 225
	.db #0xe5	; 229
	.db #0xe8	; 232
	.db #0xeb	; 235
	.db #0xee	; 238
	.db #0xf1	; 241
	.db #0xf3	; 243
	.db #0xf5	; 245
	.db #0xf7	; 247
	.db #0xf9	; 249
	.db #0xfb	; 251
	.db #0xfc	; 252
	.db #0xfd	; 253
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xfc	; 252
	.db #0xfb	; 251
	.db #0xf9	; 249
	.db #0xf7	; 247
	.db #0xf5	; 245
	.db #0xf3	; 243
	.db #0xf1	; 241
	.db #0xee	; 238
	.db #0xeb	; 235
	.db #0xe8	; 232
	.db #0xe5	; 229
	.db #0xe1	; 225
	.db #0xde	; 222
	.db #0xda	; 218
	.db #0xd6	; 214
	.db #0xd1	; 209
	.db #0xcd	; 205
	.db #0xc9	; 201
	.db #0xc4	; 196
	.db #0xbf	; 191
	.db #0xba	; 186
	.db #0xb5	; 181
	.db #0xb0	; 176
	.db #0xab	; 171
	.db #0xa6	; 166
	.db #0xa0	; 160
	.db #0x9b	; 155
	.db #0x96	; 150
	.db #0x90	; 144
	.db #0x8b	; 139
	.db #0x85	; 133
	.db #0x80	; 128
	.db #0x7a	; 122	'z'
	.db #0x74	; 116	't'
	.db #0x6f	; 111	'o'
	.db #0x69	; 105	'i'
	.db #0x64	; 100	'd'
	.db #0x5f	; 95
	.db #0x59	; 89	'Y'
	.db #0x54	; 84	'T'
	.db #0x4f	; 79	'O'
	.db #0x4a	; 74	'J'
	.db #0x45	; 69	'E'
	.db #0x40	; 64
	.db #0x3b	; 59
	.db #0x36	; 54	'6'
	.db #0x32	; 50	'2'
	.db #0x2e	; 46
	.db #0x29	; 41
	.db #0x25	; 37
	.db #0x21	; 33
	.db #0x1e	; 30
	.db #0x1a	; 26
	.db #0x17	; 23
	.db #0x14	; 20
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0a	; 10
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x08	; 8
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x14	; 20
	.db #0x17	; 23
	.db #0x1a	; 26
	.db #0x1e	; 30
	.db #0x21	; 33
	.db #0x25	; 37
	.db #0x29	; 41
	.db #0x2e	; 46
	.db #0x32	; 50	'2'
	.db #0x36	; 54	'6'
	.db #0x3b	; 59
	.db #0x40	; 64
	.db #0x45	; 69	'E'
	.db #0x4a	; 74	'J'
	.db #0x4f	; 79	'O'
	.db #0x54	; 84	'T'
	.db #0x59	; 89	'Y'
	.db #0x5f	; 95
	.db #0x64	; 100	'd'
	.db #0x69	; 105	'i'
	.db #0x6f	; 111	'o'
	.db #0x74	; 116	't'
	.db #0x7a	; 122	'z'
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
;src\gameboy.c:34: inline void set_default_palette()
;	---------------------------------
; Function set_default_palette
; ---------------------------------
_set_default_palette::
;src\gameboy.c:36: BGP_REG = 0xE4U;
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
;src\gameboy.c:37: }
	ret
;src\gameboy.c:44: void vbl_music()
;	---------------------------------
; Function vbl_music
; ---------------------------------
_vbl_music::
;src\gameboy.c:47: __save = _current_bank;
	ldh	a, (__current_bank+0)
	ld	(#_vbl_music___save_65536_111),a
;src\gameboy.c:48: SWITCH_ROM_MBC1(current_music_bank);
	ld	hl, #_current_music_bank
	ld	a, (hl)
	ldh	(__current_bank+0),a
	ld	de, #0x2000
	ld	a, (hl)
	ld	(de), a
;src\gameboy.c:49: hUGE_dosound();
	call	_hUGE_dosound
;src\gameboy.c:50: SWITCH_ROM_MBC1(__save);
	ld	hl, #_vbl_music___save_65536_111
	ld	a, (hl)
	ldh	(__current_bank+0),a
	ld	de, #0x2000
	ld	a, (hl)
	ld	(de), a
;src\gameboy.c:51: }
	ret
;src\gameboy.c:53: void play_music(const hUGESong_t * music, UINT8 music_bank)
;	---------------------------------
; Function play_music
; ---------------------------------
_play_music::
;src\gameboy.c:66: }
	di
;src\gameboy.c:57: SWITCH_ROM_MBC1(music_bank);
	ldhl	sp,	#4
	ld	c, (hl)
	ld	a, c
	ldh	(__current_bank+0),a
	ld	de, #0x2000
	ld	a, (hl)
	ld	(de), a
;src\gameboy.c:58: hUGE_init(music);
	push	bc
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_hUGE_init
	add	sp, #2
	pop	bc
;src\gameboy.c:59: current_music_bank = music_bank;
	ld	hl, #_current_music_bank
	ld	(hl), c
;src\gameboy.c:61: if (vbl_done==0)
	ld	hl, #_play_music_vbl_done_65536_113 + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;src\gameboy.c:63: add_VBL(vbl_music);
	ld	hl, #_vbl_music
	push	hl
	call	_add_VBL
	add	sp, #2
;src\gameboy.c:64: vbl_done = 1;
	ld	hl, #_play_music_vbl_done_65536_113
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
00102$:
	ei
;src\gameboy.c:67: }
	ret
;src\gameboy.c:69: INT8 abs(INT8 a)
;	---------------------------------
; Function abs
; ---------------------------------
_abs::
;src\gameboy.c:71: return a<0?-a:a;
	ldhl	sp,	#2
	bit	7, (hl)
	jr	Z, 00103$
	xor	a, a
	sub	a, (hl)
	ld	e, a
	ret
00103$:
	ldhl	sp,	#2
	ld	e, (hl)
;src\gameboy.c:72: }
	ret
;src\gameboy.c:74: INT8 mod(INT8 a, INT8 b)
;	---------------------------------
; Function mod
; ---------------------------------
_mod::
;src\gameboy.c:76: INT8 r = a % b;
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	__modschar
	add	sp, #2
	ld	c, e
;src\gameboy.c:77: return r < 0 ? r + b : r;
	bit	7, c
	jr	Z, 00103$
	ld	a, c
	ldhl	sp,	#3
	add	a, (hl)
	jr	00104$
00103$:
	ld	a, c
00104$:
	ld	e, a
;src\gameboy.c:78: }
	ret
	.area _CODE
	.area _CABS (ABS)
