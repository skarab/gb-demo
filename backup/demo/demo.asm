;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module demo
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl b_Scene_SquaresZoom
	.globl _Scene_SquaresZoom
	.globl _play_music
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src\demo.c:23: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src\demo.c:25: LCDC_REG = 0xD1;
	ld	a, #0xd1
	ldh	(_LCDC_REG+0),a
;src\demo.c:26: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG+0),a
;src\demo.c:27: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG+0),a
;src\demo.c:28: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG+0),a
;src\demo.c:34: play_music(&part1_music, (UINT8)&__bank_part1_music);
	ld	b, #<(___bank_part1_music)
	push	bc
	inc	sp
	ld	hl, #_part1_music
	push	hl
	call	_play_music
	add	sp, #3
;src\demo.c:48: SWITCH_ROM_MBC1((UINT8)&__bank_squares_zoom);
	ld	a, #<(___bank_squares_zoom)
	ldh	(__current_bank+0),a
	ld	a, #<(___bank_squares_zoom)
	ld	(#0x2000),a
;src\demo.c:49: Scene_SquaresZoom();
	ld	e, #b_Scene_SquaresZoom
	ld	hl, #_Scene_SquaresZoom
;src\demo.c:52: }
	jp  ___sdcc_bcall_ehl
	.area _CODE
	.area _CABS (ABS)
