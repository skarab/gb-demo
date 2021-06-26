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
	.globl b_Scene_SpritesPhysics
	.globl _Scene_SpritesPhysics
	.globl b_Scene_Axelay
	.globl _Scene_Axelay
	.globl b_Scene_Fire
	.globl _Scene_Fire
	.globl b_Scene_Noise
	.globl _Scene_Noise
	.globl b_Scene_CubePhysics
	.globl _Scene_CubePhysics
	.globl b_Scene_Cube
	.globl _Scene_Cube
	.globl b_Scene_Lines
	.globl _Scene_Lines
	.globl b_Scene_Title
	.globl _Scene_Title
	.globl b_Scene_Sega
	.globl _Scene_Sega
	.globl b_Scene_Nintendo
	.globl _Scene_Nintendo
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
;src\demo.c:21: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src\demo.c:23: LCDC_REG = 0xD1;
	ld	a, #0xd1
	ldh	(_LCDC_REG+0),a
;src\demo.c:24: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG+0),a
;src\demo.c:25: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG+0),a
;src\demo.c:26: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG+0),a
;src\demo.c:28: SWITCH_ROM_MBC1((UINT8)&__bank_sega);
	ld	a, #<(___bank_sega)
	ldh	(__current_bank+0),a
	ld	a, #<(___bank_sega)
	ld	(#0x2000),a
;src\demo.c:29: Scene_Nintendo();
	ld	e, #b_Scene_Nintendo
	ld	hl, #_Scene_Nintendo
	call	___sdcc_bcall_ehl
;src\demo.c:30: Scene_Sega();
	ld	e, #b_Scene_Sega
	ld	hl, #_Scene_Sega
	call	___sdcc_bcall_ehl
;src\demo.c:32: play_music(&part1_music, (UINT8)&__bank_part1_music);
	ld	b, #<(___bank_part1_music)
	push	bc
	inc	sp
	ld	hl, #_part1_music
	push	hl
	call	_play_music
	add	sp, #3
;src\demo.c:34: SWITCH_ROM_MBC1((UINT8)&__bank_title);
	ld	a, #<(___bank_title)
	ldh	(__current_bank+0),a
	ld	a, #<(___bank_title)
	ld	(#0x2000),a
;src\demo.c:35: Scene_Lines();
	ld	e, #b_Scene_Lines
	ld	hl, #_Scene_Lines
	call	___sdcc_bcall_ehl
;src\demo.c:36: Scene_Title();
	ld	e, #b_Scene_Title
	ld	hl, #_Scene_Title
	call	___sdcc_bcall_ehl
;src\demo.c:37: SWITCH_ROM_MBC1((UINT8)&__bank_cube);
	ld	a, #<(___bank_cube)
	ldh	(__current_bank+0),a
	ld	a, #<(___bank_cube)
	ld	(#0x2000),a
;src\demo.c:38: Scene_Cube();
	ld	e, #b_Scene_Cube
	ld	hl, #_Scene_Cube
	call	___sdcc_bcall_ehl
;src\demo.c:39: Scene_CubePhysics();
	ld	e, #b_Scene_CubePhysics
	ld	hl, #_Scene_CubePhysics
	call	___sdcc_bcall_ehl
;src\demo.c:40: Scene_Noise();
	ld	e, #b_Scene_Noise
	ld	hl, #_Scene_Noise
	call	___sdcc_bcall_ehl
;src\demo.c:41: Scene_Nintendo();
	ld	e, #b_Scene_Nintendo
	ld	hl, #_Scene_Nintendo
	call	___sdcc_bcall_ehl
;src\demo.c:42: Scene_Fire();
	ld	e, #b_Scene_Fire
	ld	hl, #_Scene_Fire
	call	___sdcc_bcall_ehl
;src\demo.c:43: SWITCH_ROM_MBC1((UINT8)&__bank_axelay);
	ld	a, #<(___bank_axelay)
	ldh	(__current_bank+0),a
	ld	a, #<(___bank_axelay)
	ld	(#0x2000),a
;src\demo.c:44: Scene_Axelay();
	ld	e, #b_Scene_Axelay
	ld	hl, #_Scene_Axelay
	call	___sdcc_bcall_ehl
;src\demo.c:45: Scene_SpritesPhysics();
	ld	e, #b_Scene_SpritesPhysics
	ld	hl, #_Scene_SpritesPhysics
;src\demo.c:48: }
	jp  ___sdcc_bcall_ehl
	.area _CODE
	.area _CABS (ABS)
