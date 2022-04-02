;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module gb_dtmf
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _move_cursor
	.globl _init_cursor
	.globl _init_background
	.globl _init_key
	.globl _break_button
	.globl _press_button
	.globl _disp
	.globl _clr_disp
	.globl _disp_lcd
	.globl _dialtone
	.globl _init_dial
	.globl _strcpy
	.globl _sprintf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _joypad
	.globl _delay
	.globl _disp_tile
	.globl _pad
	.globl _init_disp
	.globl _dialing_press
	.globl _press_tile
	.globl _dialing_break
	.globl _break_tile
	.globl _dtmf_tile
	.globl _col
	.globl _row
	.globl _cursor_data
	.globl _key_num
	.globl _dtmf_lcd
	.globl _press_btn
	.globl _break_btn
	.globl _frame_lcd
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_disp_tile::
	.ds 60
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
;gb-dtmf.c:169: void init_dial()
;	---------------------------------
; Function init_dial
; ---------------------------------
_init_dial::
;gb-dtmf.c:172: NR52_REG = 0x83U;
	ld	a, #0x83
	ldh	(_NR52_REG+0),a
;gb-dtmf.c:173: NR51_REG = 0x00U;
	ld	a, #0x00
	ldh	(_NR51_REG+0),a
;gb-dtmf.c:174: NR50_REG = 0x77U;
	ld	a, #0x77
	ldh	(_NR50_REG+0),a
;gb-dtmf.c:176: NR24_REG = 0x87U;
	ld	a, #0x87
	ldh	(_NR24_REG+0),a
;gb-dtmf.c:177: NR22_REG = 0xffU;
	ld	a, #0xff
	ldh	(_NR22_REG+0),a
;gb-dtmf.c:178: NR21_REG = 0xbfU;
	ld	a, #0xbf
	ldh	(_NR21_REG+0),a
;gb-dtmf.c:180: NR14_REG = 0x87U;
	ld	a, #0x87
	ldh	(_NR14_REG+0),a
;gb-dtmf.c:181: NR12_REG = 0xffU;
	ld	a, #0xff
	ldh	(_NR12_REG+0),a
;gb-dtmf.c:182: NR11_REG = 0xbfU;
	ld	a, #0xbf
	ldh	(_NR11_REG+0),a
;gb-dtmf.c:183: NR10_REG = 0x04U;
	ld	a, #0x04
	ldh	(_NR10_REG+0),a
;gb-dtmf.c:184: }
	ret
_frame_lcd:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_break_btn:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
_press_btn:
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_dtmf_lcd:
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x20	; 32
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x20	; 32
	.db #0x3e	; 62
	.db #0x20	; 32
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x6b	; 107	'k'
	.db #0x6b	; 107	'k'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x67	; 103	'g'
	.db #0x67	; 103	'g'
	.db #0x67	; 103	'g'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x20	; 32
_key_num:
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x6e	; 110	'n'
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x6c	; 108	'l'
	.db #0xff	; 255
	.db #0x6e	; 110	'n'
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xc2	; 194
	.db #0xc2	; 194
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc2	; 194
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x97	; 151
	.db #0x97	; 151
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf2	; 242
	.db #0xf2	; 242
	.db #0xf2	; 242
	.db #0xf2	; 242
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x12	; 18
	.db #0x12	; 18
_cursor_data:
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x69	; 105	'i'
	.db #0x6f	; 111	'o'
	.db #0x19	; 25
	.db #0x3f	; 63
	.db #0x59	; 89	'Y'
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x69	; 105	'i'
	.db #0x6f	; 111	'o'
	.db #0x19	; 25
	.db #0x3f	; 63
	.db #0x59	; 89	'Y'
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0xa8	; 168
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x54	; 84	'T'
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
_row:
	.db #0x44	; 68	'D'
	.db #0x56	; 86	'V'
	.db #0x66	; 102	'f'
	.db #0x75	; 117	'u'
_col:
	.db #0x94	; 148
	.db #0x9e	; 158
	.db #0xa7	; 167
	.db #0xb0	; 176
_dtmf_tile:
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
_break_tile:
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
_dialing_break:
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x11	; 17
_press_tile:
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
_dialing_press:
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x1a	; 26
_init_disp:
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
_pad:
	.db #0x31	;  49	'1'
	.db #0x32	;  50	'2'
	.db #0x33	;  51	'3'
	.db #0x41	;  65	'A'
	.db #0x25	;  37
	.db #0x50	;  80	'P'
	.db #0x34	;  52	'4'
	.db #0x35	;  53	'5'
	.db #0x36	;  54	'6'
	.db #0x42	;  66	'B'
	.db #0x2d	;  45
	.db #0x46	;  70	'F'
	.db #0x37	;  55	'7'
	.db #0x38	;  56	'8'
	.db #0x39	;  57	'9'
	.db #0x43	;  67	'C'
	.db #0x2c	;  44
	.db #0x3f	;  63
	.db #0x2a	;  42
	.db #0x30	;  48	'0'
	.db #0x23	;  35
	.db #0x44	;  68	'D'
	.db #0x73	;  115	's'
	.db #0x73	;  115	's'
;gb-dtmf.c:187: void dialtone(UWORD dtmf_on, UWORD dtmf_off, char str[20])
;	---------------------------------
; Function dialtone
; ---------------------------------
_dialtone::
	dec	sp
;gb-dtmf.c:191: while(str[i]){
	xor	a, a
	ldhl	sp,	#0
	ld	(hl), a
00125$:
;c
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00128$
;gb-dtmf.c:192: switch(str[i]){
	cp	a, #0x23
	jp	Z,00118$
	cp	a, #0x2a
	jp	Z,00116$
	cp	a, #0x2c
	jp	Z,00121$
	cp	a, #0x30
	jp	Z,00117$
	cp	a, #0x31
	jr	Z, 00101$
	cp	a, #0x32
	jr	Z, 00102$
	cp	a, #0x33
	jr	Z, 00103$
	cp	a, #0x34
	jr	Z, 00106$
	cp	a, #0x35
	jr	Z, 00107$
	cp	a, #0x36
	jr	Z, 00108$
	cp	a, #0x37
	jp	Z,00111$
	cp	a, #0x38
	jp	Z,00112$
	cp	a, #0x39
	jp	Z,00113$
	cp	a, #0x41
	jr	Z, 00105$
	cp	a, #0x42
	jr	Z, 00110$
	cp	a, #0x43
	jp	Z,00115$
	cp	a, #0x44
	jp	Z,00120$
	cp	a, #0x61
	jr	Z, 00105$
	cp	a, #0x62
	jr	Z, 00110$
	cp	a, #0x63
	jr	Z, 00115$
	sub	a, #0x64
	jp	Z,00120$
	jp	00122$
;gb-dtmf.c:193: case '1':
00101$:
;gb-dtmf.c:194: NR13_REG = R1;
	ld	a, #0x44
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:195: NR23_REG = C1;
	ld	a, #0x94
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:196: break;
	jp	00123$
;gb-dtmf.c:197: case '2':
00102$:
;gb-dtmf.c:198: NR13_REG = R1;
	ld	a, #0x44
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:199: NR23_REG = C2;
	ld	a, #0x9e
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:200: break;
	jp	00123$
;gb-dtmf.c:201: case '3':
00103$:
;gb-dtmf.c:202: NR13_REG = R1;
	ld	a, #0x44
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:203: NR23_REG = C3;
	ld	a, #0xa7
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:204: break;
	jp	00123$
;gb-dtmf.c:206: case 'a':
00105$:
;gb-dtmf.c:207: NR13_REG = R1;
	ld	a, #0x44
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:208: NR23_REG = C4;
	ld	a, #0xb0
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:209: break;
	jp	00123$
;gb-dtmf.c:210: case '4':
00106$:
;gb-dtmf.c:211: NR13_REG = R2;
	ld	a, #0x56
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:212: NR23_REG = C1;
	ld	a, #0x94
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:213: break;
	jp	00123$
;gb-dtmf.c:214: case '5':
00107$:
;gb-dtmf.c:215: NR13_REG = R2;
	ld	a, #0x56
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:216: NR23_REG = C2;
	ld	a, #0x9e
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:217: break;
	jp	00123$
;gb-dtmf.c:218: case '6':
00108$:
;gb-dtmf.c:219: NR13_REG = R2;
	ld	a, #0x56
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:220: NR23_REG = C3;
	ld	a, #0xa7
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:221: break;
	jr	00123$
;gb-dtmf.c:223: case 'b':
00110$:
;gb-dtmf.c:224: NR13_REG = R2;
	ld	a, #0x56
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:225: NR23_REG = C4;
	ld	a, #0xb0
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:226: break;
	jr	00123$
;gb-dtmf.c:227: case '7':
00111$:
;gb-dtmf.c:228: NR13_REG = R3;
	ld	a, #0x66
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:229: NR23_REG = C1;
	ld	a, #0x94
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:230: break;
	jr	00123$
;gb-dtmf.c:231: case '8':
00112$:
;gb-dtmf.c:232: NR13_REG = R3;
	ld	a, #0x66
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:233: NR23_REG = C2;
	ld	a, #0x9e
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:234: break;
	jr	00123$
;gb-dtmf.c:235: case '9':
00113$:
;gb-dtmf.c:236: NR13_REG = R3;
	ld	a, #0x66
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:237: NR23_REG = C3;
	ld	a, #0xa7
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:238: break;
	jr	00123$
;gb-dtmf.c:240: case 'c':
00115$:
;gb-dtmf.c:241: NR13_REG = R3;
	ld	a, #0x66
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:242: NR23_REG = C4;
	ld	a, #0xb0
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:243: break;
	jr	00123$
;gb-dtmf.c:244: case '*':
00116$:
;gb-dtmf.c:245: NR13_REG = R4;
	ld	a, #0x75
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:246: NR23_REG = C1;
	ld	a, #0x94
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:247: break;
	jr	00123$
;gb-dtmf.c:248: case '0':
00117$:
;gb-dtmf.c:249: NR13_REG = R4;
	ld	a, #0x75
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:250: NR23_REG = C2;
	ld	a, #0x9e
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:251: break;
	jr	00123$
;gb-dtmf.c:252: case '#':
00118$:
;gb-dtmf.c:253: NR13_REG = R4;
	ld	a, #0x75
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:254: NR23_REG = C3;
	ld	a, #0xa7
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:255: break;
	jr	00123$
;gb-dtmf.c:257: case 'd':
00120$:
;gb-dtmf.c:258: NR13_REG = R4;
	ld	a, #0x75
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:259: NR23_REG = C4;
	ld	a, #0xb0
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:260: break;
	jr	00123$
;gb-dtmf.c:261: case ',':
00121$:
;gb-dtmf.c:262: delay(dtmf_on);	/* keep on */
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_delay
	add	sp, #2
;gb-dtmf.c:263: delay(dtmf_off);	/* keep off */
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_delay
	add	sp, #2
;gb-dtmf.c:265: default:
00122$:
;gb-dtmf.c:266: NR51_REG = 0x00U;	/* sound off */
	ld	a, #0x00
	ldh	(_NR51_REG+0),a
;gb-dtmf.c:267: goto skip;
	jr	00124$
;gb-dtmf.c:269: }
00123$:
;gb-dtmf.c:270: NR24_REG = 0x87U;	/* ch2 tips */
	ld	a, #0x87
	ldh	(_NR24_REG+0),a
;gb-dtmf.c:271: NR51_REG = 0x33U;	/* sound on */
	ld	a, #0x33
	ldh	(_NR51_REG+0),a
;gb-dtmf.c:272: delay(dtmf_on);		/* keep on */
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_delay
	add	sp, #2
;gb-dtmf.c:274: NR51_REG = 0x00U;	/* sound off */
	ld	a, #0x00
	ldh	(_NR51_REG+0),a
;gb-dtmf.c:275: delay(dtmf_off);	/* keep off */
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_delay
	add	sp, #2
;gb-dtmf.c:277: skip:
00124$:
;gb-dtmf.c:278: i++;
	ldhl	sp,	#0
	inc	(hl)
	jp	00125$
00128$:
;gb-dtmf.c:280: }
	inc	sp
	ret
;gb-dtmf.c:284: void disp_lcd(UBYTE len, char str[MAX_DTMF])
;	---------------------------------
; Function disp_lcd
; ---------------------------------
_disp_lcd::
	add	sp, #-2
;gb-dtmf.c:288: j = len;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;gb-dtmf.c:291: while(str[i]){
	xor	a, a
	inc	hl
	ld	(hl), a
00121$:
;c
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, (hl)
	ld	a, c
	or	a, a
	jp	Z, 00124$
;gb-dtmf.c:292: if(str[i] >= '0'||'9' <= str[i]){
	ld	a, c
	xor	a, #0x80
	sub	a, #0xb0
	jr	NC, 00101$
	ld	a, c
	xor	a, #0x80
	sub	a, #0xb9
	jr	C, 00102$
00101$:
;gb-dtmf.c:293: disp_tile[i] = OFFSET + (str[i] - '0') * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
;c
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, #0xd0
	add	a, a
	add	a, #0x1b
	ld	(bc), a
;gb-dtmf.c:294: disp_tile[i+j] = OFFSET + (str[i] - '0') * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	c, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	b, a
	ld	a, (de)
	add	a, #0xd0
	add	a, a
	add	a, #0x1c
	ld	(bc), a
00102$:
;gb-dtmf.c:296: switch(str[i]){
;c
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0x20
	jp	Z,00110$
	cp	a, #0x23
	jp	Z,00108$
	cp	a, #0x2a
	jp	Z,00109$
	cp	a, #0x2c
	jp	Z,00117$
	cp	a, #0x2d
	jp	Z,00115$
	cp	a, #0x41
	jr	Z, 00104$
	cp	a, #0x42
	jr	Z, 00105$
	cp	a, #0x43
	jr	Z, 00106$
	cp	a, #0x44
	jr	Z, 00107$
	cp	a, #0x46
	jp	Z,00118$
	cp	a, #0x47
	jp	Z,00114$
	cp	a, #0x4d
	jp	Z,00112$
	cp	a, #0x53
	jp	Z,00119$
	cp	a, #0x54
	jp	Z,00116$
	cp	a, #0x55
	jp	Z,00113$
	sub	a, #0x59
	jp	Z,00111$
	jp	00120$
;gb-dtmf.c:297: case 'A':
00104$:
;gb-dtmf.c:298: disp_tile[i] = OFFSET + 10 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x2f
;gb-dtmf.c:299: disp_tile[i+j] = OFFSET + 10 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x30
;gb-dtmf.c:300: break;
	jp	00120$
;gb-dtmf.c:301: case 'B':
00105$:
;gb-dtmf.c:302: disp_tile[i] = OFFSET + 11 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x31
;gb-dtmf.c:303: disp_tile[i+j] = OFFSET + 11 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x32
;gb-dtmf.c:304: break;
	jp	00120$
;gb-dtmf.c:305: case 'C':
00106$:
;gb-dtmf.c:306: disp_tile[i] = OFFSET + 12 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x33
;gb-dtmf.c:307: disp_tile[i+j] = OFFSET + 12 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x34
;gb-dtmf.c:308: break;
	jp	00120$
;gb-dtmf.c:309: case 'D':
00107$:
;gb-dtmf.c:310: disp_tile[i] = OFFSET + 13 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x35
;gb-dtmf.c:311: disp_tile[i+j] = OFFSET + 13 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x36
;gb-dtmf.c:312: break;
	jp	00120$
;gb-dtmf.c:313: case '#':
00108$:
;gb-dtmf.c:314: disp_tile[i] = OFFSET + 14 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x37
;gb-dtmf.c:315: disp_tile[i+j] = OFFSET + 14 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x38
;gb-dtmf.c:316: break;
	jp	00120$
;gb-dtmf.c:317: case '*':
00109$:
;gb-dtmf.c:318: disp_tile[i] = OFFSET + 15 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x39
;gb-dtmf.c:319: disp_tile[i+j] = OFFSET + 15 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x3a
;gb-dtmf.c:320: break;
	jp	00120$
;gb-dtmf.c:321: case ' ':
00110$:
;gb-dtmf.c:322: disp_tile[i] = OFFSET + 16 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c,l
	ld	(hl), #0x3b
;gb-dtmf.c:323: disp_tile[i+j] = OFFSET + 16 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x3c
;gb-dtmf.c:324: break;
	jp	00120$
;gb-dtmf.c:325: case 'Y':
00111$:
;gb-dtmf.c:326: disp_tile[i] = OFFSET + 17 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x3d
;gb-dtmf.c:327: disp_tile[i+j] = OFFSET + 17 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x3e
;gb-dtmf.c:328: break;
	jp	00120$
;gb-dtmf.c:329: case 'M':
00112$:
;gb-dtmf.c:330: disp_tile[i] = OFFSET + 18 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x3f
;gb-dtmf.c:331: disp_tile[i+j] = OFFSET + 18 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x40
;gb-dtmf.c:332: break;
	jp	00120$
;gb-dtmf.c:333: case 'U':
00113$:
;gb-dtmf.c:334: disp_tile[i] = OFFSET + 19 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x41
;gb-dtmf.c:335: disp_tile[i+j] = OFFSET + 19 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x42
;gb-dtmf.c:336: break;
	jp	00120$
;gb-dtmf.c:337: case 'G':
00114$:
;gb-dtmf.c:338: disp_tile[i] = OFFSET + 20 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x43
;gb-dtmf.c:339: disp_tile[i+j] = OFFSET + 20 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x44
;gb-dtmf.c:340: break;
	jp	00120$
;gb-dtmf.c:341: case '-':
00115$:
;gb-dtmf.c:342: disp_tile[i] = OFFSET + 21 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x45
;gb-dtmf.c:343: disp_tile[i+j] = OFFSET + 21 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x46
;gb-dtmf.c:344: break;
	jr	00120$
;gb-dtmf.c:345: case 'T':
00116$:
;gb-dtmf.c:346: disp_tile[i] = OFFSET + 22 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x47
;gb-dtmf.c:347: disp_tile[i+j] = OFFSET + 22 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x48
;gb-dtmf.c:348: break;
	jr	00120$
;gb-dtmf.c:349: case ',':
00117$:
;gb-dtmf.c:350: disp_tile[i] = OFFSET + 23 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x49
;gb-dtmf.c:351: disp_tile[i+j] = OFFSET + 23 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x4a
;gb-dtmf.c:352: break;
	jr	00120$
;gb-dtmf.c:353: case 'F':
00118$:
;gb-dtmf.c:354: disp_tile[i] = OFFSET + 24 * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c,l
	ld	(hl), #0x4b
;gb-dtmf.c:355: disp_tile[i+j] = OFFSET + 24 * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x4c
;gb-dtmf.c:356: break;
	jr	00120$
;gb-dtmf.c:357: case 'S':
00119$:
;gb-dtmf.c:358: disp_tile[i] = OFFSET + ('5' - '0') * 2;
;c
	ld	de, #_disp_tile
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x25
;gb-dtmf.c:359: disp_tile[i+j] = OFFSET + ('5' - '0') * 2 + 1;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, (hl)
	add	a, #<(_disp_tile)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_disp_tile)
	ld	h, a
	ld	(hl), #0x26
;gb-dtmf.c:361: }
00120$:
;gb-dtmf.c:362: i++;
	ldhl	sp,	#1
	inc	(hl)
	jp	00121$
00124$:
;gb-dtmf.c:364: }
	add	sp, #2
	ret
;gb-dtmf.c:367: void clr_disp()
;	---------------------------------
; Function clr_disp
; ---------------------------------
_clr_disp::
;gb-dtmf.c:369: set_bkg_data(OFFSET, 50, dtmf_lcd);
	ld	hl, #_dtmf_lcd
	push	hl
	ld	de, #0x321b
	push	de
	call	_set_bkg_data
	add	sp, #4
;gb-dtmf.c:370: set_bkg_tiles(LCD_X, LCD_Y, LCD_WIDTH, LCD_HIGHT, init_disp);
	ld	hl, #_init_disp
	push	hl
	ld	de, #0x0212
	push	de
	ld	de, #0x0201
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;gb-dtmf.c:371: }
	ret
;gb-dtmf.c:376: void disp(const char *str)
;	---------------------------------
; Function disp
; ---------------------------------
_disp::
	add	sp, #-35
;gb-dtmf.c:382: clr_disp();
	call	_clr_disp
;gb-dtmf.c:385: while(str[no]){
	ld	e, #0x00
00101$:
	push	de
;b
	ld	d, #0x00
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00103$
;gb-dtmf.c:386: no++;
	inc	e
	jr	00101$
00103$:
;gb-dtmf.c:389: if(no >= LCD_WIDTH){
;gb-dtmf.c:390: start_ch = no - LCD_WIDTH;
	ld	a,e
	cp	a,#0x12
	jr	C, 00105$
	add	a, #0xee
	ld	c, a
;gb-dtmf.c:391: end_ch = LCD_WIDTH;
	ldhl	sp,	#30
	ld	(hl), #0x12
	jr	00117$
00105$:
;gb-dtmf.c:394: start_ch = 0;
	ld	c, #0x00
;gb-dtmf.c:395: end_ch = no;
	ldhl	sp,	#30
	ld	(hl), e
;gb-dtmf.c:397: for(i = 0;i < end_ch;i++){
00117$:
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#31
	ld	(hl+), a
	ld	(hl), d
	ld	b, #0x00
00109$:
	ld	a, b
	ldhl	sp,	#30
	sub	a, (hl)
	jr	NC, 00107$
;gb-dtmf.c:398: work[i] = str[i+start_ch];
;c
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, b
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#35
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#34
	ld	(hl), a
	ld	e, b
	ld	d, #0x00
	ld	a, c
	ld	l, #0x00
	add	a, e
	ld	e, a
	ld	a, l
	adc	a, d
	ld	d, a
;c
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#33
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;gb-dtmf.c:397: for(i = 0;i < end_ch;i++){
	inc	b
	jr	00109$
00107$:
;gb-dtmf.c:400: work[end_ch] = 0x00;
;c
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;gb-dtmf.c:402: disp_lcd(end_ch, work);
	ldhl	sp,#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	dec	hl
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_disp_lcd
	add	sp, #3
;gb-dtmf.c:404: left_pos = 19 - end_ch;
	ldhl	sp,	#30
	ld	c, (hl)
	ld	a, #0x13
	sub	a, c
	ldhl	sp,	#34
	ld	(hl), a
;gb-dtmf.c:405: set_bkg_tiles(left_pos, 2, end_ch, LCD_HIGHT, disp_tile);
	ld	hl, #_disp_tile
	push	hl
	ld	a, #0x02
	push	af
	inc	sp
	ldhl	sp,	#33
	ld	d, (hl)
	ld	e,#0x02
	push	de
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;gb-dtmf.c:406: }
	add	sp, #35
	ret
;gb-dtmf.c:408: void press_button(UBYTE x, UBYTE y)
;	---------------------------------
; Function press_button
; ---------------------------------
_press_button::
;gb-dtmf.c:411: set_bkg_tiles(x * 3 + 1, y * 3 + 5, 3, 3, press_tile);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	c, (hl)
	ld	e, a
	add	a, a
	add	a, e
	ld	b, a
	ld	a, c
	add	a, a
	add	a, c
	ld	c, a
	ld	a, b
	add	a, #0x05
	ld	b, a
;gb-dtmf.c:410: if(x <= 3 && y <= 3){
	ld	a, #0x03
	ldhl	sp,	#2
	sub	a, (hl)
	jr	C, 00102$
	ld	a, #0x03
	inc	hl
	sub	a, (hl)
	jr	C, 00102$
;gb-dtmf.c:411: set_bkg_tiles(x * 3 + 1, y * 3 + 5, 3, 3, press_tile);
	ld	de, #_press_tile+0
	ld	a, c
	inc	a
	push	de
	ld	h, #0x03
	push	hl
	inc	sp
	ld	h, #0x03
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
00102$:
;gb-dtmf.c:413: if((x == 4 || x == 5) && (y <= 2)){
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	ld	a, #0x01
	jr	Z, 00145$
	xor	a, a
00145$:
	ld	e, a
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00147$
	xor	a, a
00147$:
	ld	d, a
	ld	a, e
	or	a,a
	jr	NZ, 00107$
	or	a,d
	jr	Z, 00105$
00107$:
	ld	a, #0x02
	ldhl	sp,	#3
	sub	a, (hl)
	jr	C, 00105$
;gb-dtmf.c:414: set_bkg_tiles(x * 3 + 2, y * 3 + 5, 3, 3, press_tile);
	ld	hl, #_press_tile
	ld	a, c
	inc	a
	inc	a
	push	de
	push	hl
	ld	h, #0x03
	push	hl
	inc	sp
	ld	h, #0x03
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
00105$:
;gb-dtmf.c:416: if((x == 4 || x == 5) && (y == 3)){
	ld	a, e
	or	a,a
	jr	NZ, 00111$
	or	a,d
	ret	Z
00111$:
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x03
	ret	NZ
;gb-dtmf.c:417: set_bkg_tiles(14, 14, 6, 3, dialing_press);
	ld	hl, #_dialing_press
	push	hl
	ld	de, #0x0306
	push	de
	ld	de, #0x0e0e
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;gb-dtmf.c:419: }
	ret
;gb-dtmf.c:421: void break_button(UBYTE x, UBYTE y)
;	---------------------------------
; Function break_button
; ---------------------------------
_break_button::
;gb-dtmf.c:424: set_bkg_tiles(x * 3 + 1, y * 3 + 5, 3, 3, break_tile);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	c, (hl)
	ld	e, a
	add	a, a
	add	a, e
	ld	b, a
	ld	a, c
	add	a, a
	add	a, c
	ld	c, a
	ld	a, b
	add	a, #0x05
	ld	b, a
;gb-dtmf.c:423: if(x <= 3 && y <= 3){
	ld	a, #0x03
	ldhl	sp,	#2
	sub	a, (hl)
	jr	C, 00102$
	ld	a, #0x03
	inc	hl
	sub	a, (hl)
	jr	C, 00102$
;gb-dtmf.c:424: set_bkg_tiles(x * 3 + 1, y * 3 + 5, 3, 3, break_tile);
	ld	de, #_break_tile+0
	ld	a, c
	inc	a
	push	de
	ld	h, #0x03
	push	hl
	inc	sp
	ld	h, #0x03
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
00102$:
;gb-dtmf.c:426: if((x == 4 || x == 5) && (y <= 2)){
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	ld	a, #0x01
	jr	Z, 00145$
	xor	a, a
00145$:
	ld	e, a
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00147$
	xor	a, a
00147$:
	ld	d, a
	ld	a, e
	or	a,a
	jr	NZ, 00107$
	or	a,d
	jr	Z, 00105$
00107$:
	ld	a, #0x02
	ldhl	sp,	#3
	sub	a, (hl)
	jr	C, 00105$
;gb-dtmf.c:427: set_bkg_tiles(x * 3 + 2, y * 3 + 5, 3, 3, break_tile);
	ld	hl, #_break_tile
	ld	a, c
	inc	a
	inc	a
	push	de
	push	hl
	ld	h, #0x03
	push	hl
	inc	sp
	ld	h, #0x03
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
00105$:
;gb-dtmf.c:429: if((x == 4 || x == 5) && (y == 3)){
	ld	a, e
	or	a,a
	jr	NZ, 00111$
	or	a,d
	ret	Z
00111$:
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x03
	ret	NZ
;gb-dtmf.c:430: set_bkg_tiles(14, 14, 6, 3, dialing_break);
	ld	hl, #_dialing_break
	push	hl
	ld	de, #0x0306
	push	de
	ld	de, #0x0e0e
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;gb-dtmf.c:432: }
	ret
;gb-dtmf.c:435: void init_key()
;	---------------------------------
; Function init_key
; ---------------------------------
_init_key::
	add	sp, #-3
;gb-dtmf.c:440: set_sprite_data(0, 24, key_num);
	ld	hl, #_key_num
	push	hl
	ld	a, #0x18
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;gb-dtmf.c:444: for(i = 1;i <= 3;i++){
	ld	c, #0x01
00127$:
;gb-dtmf.c:445: key_x = i * KEY_STEP;
	ld	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl,#_shadow_OAM+1+1
	add	hl,de
	ld	(hl), c
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), b
;gb-dtmf.c:444: for(i = 1;i <= 3;i++){
	inc	c
	ld	a, #0x03
	sub	a, c
	jr	NC, 00127$
;gb-dtmf.c:452: for(i = 4;i <= 6;i++){
	ld	c, #0x04
00129$:
;gb-dtmf.c:453: key_x = (i - 3) * KEY_STEP;
	ld	a, c
	add	a, #0xfd
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl,#_shadow_OAM+1+1
	add	hl,de
	ld	(hl), c
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x58
	ld	(hl+), a
	ld	(hl), b
;gb-dtmf.c:452: for(i = 4;i <= 6;i++){
	inc	c
	ld	a, #0x06
	sub	a, c
	jr	NC, 00129$
;gb-dtmf.c:460: for(i = 7;i <= 9;i++){
	ld	c, #0x07
00131$:
;gb-dtmf.c:461: key_x = (i - 6) * KEY_STEP;
	ld	a, c
	add	a, #0xfa
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl,#_shadow_OAM+1+1
	add	hl,de
	ld	(hl), c
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x70
	ld	(hl+), a
	ld	(hl), b
;gb-dtmf.c:460: for(i = 7;i <= 9;i++){
	inc	c
	ld	a, #0x09
	sub	a, c
	jr	NC, 00131$
;gb-dtmf.c:468: for(i = 0;i <= 3;i++){
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00133$:
;gb-dtmf.c:469: key_y = (i+1) * KEY_STEP + 40;
	ldhl	sp,	#2
	ld	c, (hl)
	ld	a, c
	inc	a
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x28
	ldhl	sp,	#0
	ld	(hl), a
;gb-dtmf.c:470: set_sprite_tile(i+10, i+10);
	ld	a, c
	add	a, #0x0a
	ld	e, a
	inc	hl
	ld	(hl), e
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, e
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(bc), a
;gb-dtmf.c:471: move_sprite(i+10, key_x, key_y);
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, #0x60
	ld	(bc), a
;gb-dtmf.c:468: for(i = 0;i <= 3;i++){
	inc	hl
	inc	hl
	inc	(hl)
	ld	a, #0x03
	sub	a, (hl)
	jr	NC, 00133$
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x003e)
	ld	(hl), #0x0f
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x003c)
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x88
	ld	(hl+), a
	ld	(hl), #0x18
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x88
	ld	(hl+), a
	ld	(hl), #0x30
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x003a)
	ld	(hl), #0x0e
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0038)
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x88
	ld	(hl+), a
	ld	(hl), #0x48
;gb-dtmf.c:484: for(i = 0;i <= 2;i++){
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00135$:
;gb-dtmf.c:485: key_y = (i+1) * KEY_STEP + 40;
	ldhl	sp,	#2
	ld	c, (hl)
	ld	a, c
	inc	a
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x28
	ldhl	sp,	#0
	ld	(hl), a
;gb-dtmf.c:486: set_sprite_tile(i+16, i+16);
	ld	a, c
	add	a, #0x10
	ld	e, a
	inc	hl
	ld	(hl), e
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, e
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(bc), a
;gb-dtmf.c:487: move_sprite(i+16, key_x, key_y);
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, #0x80
	ld	(bc), a
;gb-dtmf.c:484: for(i = 0;i <= 2;i++){
	inc	hl
	inc	hl
	inc	(hl)
	ld	a, #0x02
	sub	a, (hl)
	jr	NC, 00135$
;gb-dtmf.c:492: for(i = 0;i <= 2;i++){
	xor	a, a
	ld	(hl), a
00137$:
;gb-dtmf.c:493: key_y = (i+1) * KEY_STEP + 40;
	ldhl	sp,	#2
	ld	c, (hl)
	ld	a, c
	inc	a
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x28
	ldhl	sp,	#0
	ld	(hl), a
;gb-dtmf.c:494: set_sprite_tile(i+19, i+19);
	ld	a, c
	add	a, #0x13
	ld	e, a
	inc	hl
	ld	(hl), e
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, e
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(bc), a
;gb-dtmf.c:495: move_sprite(i+19, key_x, key_y);
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, #0x98
	ld	(bc), a
;gb-dtmf.c:492: for(i = 0;i <= 2;i++){
	inc	hl
	inc	hl
	inc	(hl)
	ld	a, #0x02
	sub	a, (hl)
	jr	NC, 00137$
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x005a)
	ld	(hl), #0x16
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0058)
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x88
	ld	(hl+), a
	ld	(hl), #0x8c
;gb-dtmf.c:502: move_sprite(22, key_x, key_y);
;gb-dtmf.c:503: }
	add	sp, #3
	ret
;gb-dtmf.c:505: void init_background()
;	---------------------------------
; Function init_background
; ---------------------------------
_init_background::
;gb-dtmf.c:508: set_bkg_data( 0, 9, frame_lcd);
	ld	hl, #_frame_lcd
	push	hl
	ld	a, #0x09
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;gb-dtmf.c:509: set_bkg_data( 9, 9, break_btn);
	ld	hl, #_break_btn
	push	hl
	ld	de, #0x0909
	push	de
	call	_set_bkg_data
	add	sp, #4
;gb-dtmf.c:510: set_bkg_data(18, 9, press_btn);
	ld	hl, #_press_btn
	push	hl
	ld	de, #0x0912
	push	de
	call	_set_bkg_data
	add	sp, #4
;gb-dtmf.c:512: set_bkg_tiles(0, 0, 20, 18, dtmf_tile);
	ld	hl, #_dtmf_tile
	push	hl
	ld	de, #0x1214
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;gb-dtmf.c:513: }
	ret
;gb-dtmf.c:515: void init_cursor()
;	---------------------------------
; Function init_cursor
; ---------------------------------
_init_cursor::
;gb-dtmf.c:520: set_sprite_data(23, 8, cursor_data);
	ld	hl, #_cursor_data
	push	hl
	ld	de, #0x0817
	push	de
	call	_set_sprite_data
	add	sp, #4
;gb-dtmf.c:522: for(i = 23;i <= 30;i++){
	ld	c, #0x17
00103$:
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM+0
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;gb-dtmf.c:522: for(i = 23;i <= 30;i++){
	inc	c
	ld	a, #0x1e
	sub	a, c
	jr	NC, 00103$
;gb-dtmf.c:525: }
	ret
;gb-dtmf.c:527: void move_cursor(UBYTE x, UBYTE y)
;	---------------------------------
; Function move_cursor
; ---------------------------------
_move_cursor::
	dec	sp
;gb-dtmf.c:529: move_sprite(23, x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	e, a
	ld	c, (hl)
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x005c)
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;gb-dtmf.c:530: move_sprite(24, x, y+8);
	ld	a, e
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	hl, #(_shadow_OAM + 0x0060)
	ld	(hl+), a
	ld	(hl), c
;gb-dtmf.c:531: move_sprite(25, x+8, y);
	ld	a, c
	add	a, #0x08
	ld	c, a
	ld	b, c
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0064)
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), b
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+104
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;gb-dtmf.c:532: move_sprite(26, x+8, y+8);
;gb-dtmf.c:533: }
	inc	sp
	ret
;gb-dtmf.c:535: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-64
;gb-dtmf.c:538: UBYTE non_flick = OFF;
	xor	a, a
	ldhl	sp,	#40
	ld	(hl), a
;gb-dtmf.c:545: key2 = 0;
	xor	a, a
	inc	hl
	ld	(hl), a
;gb-dtmf.c:548: on_time = DTMF_ON;
	ldhl	sp,	#57
	ld	(hl), #0x64
	xor	a, a
	inc	hl
;gb-dtmf.c:549: off_time = DTMF_OFF;
	ld	(hl+), a
	ld	(hl), #0x64
	xor	a, a
	inc	hl
	ld	(hl), a
;gb-dtmf.c:551: disable_interrupts();
	call	_disable_interrupts
;gb-dtmf.c:553: SPRITES_8x8;   /* sprites are 8x8 */
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfb
	ldh	(_LCDC_REG+0),a
;gb-dtmf.c:555: init_dial();
	call	_init_dial
;gb-dtmf.c:557: init_background();
	call	_init_background
;gb-dtmf.c:559: init_key();
	call	_init_key
;gb-dtmf.c:561: init_cursor();
	call	_init_cursor
;gb-dtmf.c:563: disp(TITLE);
	ld	hl, #___str_0
	push	hl
	call	_disp
	add	sp, #2
;gb-dtmf.c:565: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;gb-dtmf.c:566: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;gb-dtmf.c:567: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;gb-dtmf.c:569: enable_interrupts();
	call	_enable_interrupts
;gb-dtmf.c:571: i = j = 0;
	xor	a, a
	ldhl	sp,	#61
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;gb-dtmf.c:573: ch_pos = 0;
	xor	a, a
	inc	hl
	ld	(hl), a
;gb-dtmf.c:575: while(1) {
00187$:
;gb-dtmf.c:576: wait_vbl_done();
	call	_wait_vbl_done
;gb-dtmf.c:577: key1 = joypad();
	call	_joypad
	ldhl	sp,	#42
;gb-dtmf.c:579: if(key1 != key2){
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, (hl)
	jr	Z, 00102$
;gb-dtmf.c:580: pos_x = i * KEY_STEP + START_CURSOR_X;
	ldhl	sp,	#62
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#56
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x18
	ld	b, a
;gb-dtmf.c:581: pos_y = j * KEY_STEP + START_CURSOR_Y;
	ldhl	sp,	#61
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x48
;gb-dtmf.c:582: move_cursor(pos_x, pos_y);
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_move_cursor
	add	sp, #2
00102$:
;gb-dtmf.c:586: if(key1 & J_A){
	ldhl	sp,	#42
	ld	a, (hl)
	and	a, #0x10
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;gb-dtmf.c:588: if(i <= 3 && j <= 3){
	ld	a, #0x03
	ldhl	sp,	#62
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#53
	ld	(hl), a
	ld	a, #0x03
	ldhl	sp,	#61
	sub	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#54
	ld	(hl), a
;gb-dtmf.c:600: if(i == 5 && j == 0 && !non_flick){
	ldhl	sp,	#62
	ld	a, (hl)
	sub	a, #0x05
	ld	a, #0x01
	jr	Z, 00443$
	xor	a, a
00443$:
	ldhl	sp,	#45
	ld	(hl), a
;gb-dtmf.c:608: if(i == 5 && (j == 1 || j == 2) && !non_flick){
	ldhl	sp,	#61
	ld	a, (hl)
	dec	a
	ld	a, #0x01
	jr	Z, 00445$
	xor	a, a
00445$:
	ldhl	sp,	#46
	ld	(hl), a
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00447$
	xor	a, a
00447$:
	ldhl	sp,	#47
	ld	(hl), a
;gb-dtmf.c:585: if(key2 & J_A){
	ldhl	sp,	#41
	bit	4, (hl)
	jp	Z,00164$
;gb-dtmf.c:586: if(key1 & J_A){
	ldhl	sp,	#44
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00124$
;gb-dtmf.c:588: if(i <= 3 && j <= 3){
	ldhl	sp,	#53
	bit	0, (hl)
	jr	NZ, 00104$
	inc	hl
	bit	0, (hl)
	jr	NZ, 00104$
;gb-dtmf.c:590: NR13_REG = row[i];
;c
	ld	de, #_row
	ldhl	sp,	#62
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#57
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#56
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(_NR13_REG+0),a
;gb-dtmf.c:591: NR23_REG = col[j];
;c
	ld	de, #_col
	ldhl	sp,	#61
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#57
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#56
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(_NR23_REG+0),a
;gb-dtmf.c:592: NR24_REG = 0x87U;
	ld	a, #0x87
	ldh	(_NR24_REG+0),a
;gb-dtmf.c:595: NR51_REG = 0x33U;
	ld	a, #0x33
	ldh	(_NR51_REG+0),a
00104$:
;gb-dtmf.c:600: if(i == 5 && j == 0 && !non_flick){
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
	ldhl	sp,	#61
	ld	a, (hl)
	or	a, a
	jr	NZ, 00107$
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	NZ, 00107$
;gb-dtmf.c:601: disp(TITLE);
	ld	hl, #___str_0
	push	hl
	call	_disp
	add	sp, #2
;gb-dtmf.c:602: non_flick = ON;
	ldhl	sp,	#40
	ld	(hl), #0x01
00107$:
;gb-dtmf.c:608: if(i == 5 && (j == 1 || j == 2) && !non_flick){
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jp	Z, 00165$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00114$
	inc	hl
	ld	a, (hl)
	or	a, a
	jp	Z, 00165$
00114$:
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jp	NZ, 00165$
;gb-dtmf.c:609: sprintf(str_ms, "%u MS", on_time);
	ldhl	sp,	#30
	ld	a, l
	ld	d, h
	ldhl	sp,	#55
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #___str_1
	push	hl
	push	bc
	call	_sprintf
	add	sp, #6
;gb-dtmf.c:610: disp(str_ms);
	ldhl	sp,	#55
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_disp
	add	sp, #2
;gb-dtmf.c:611: non_flick = ON;
	ldhl	sp,	#40
	ld	(hl), #0x01
	jp	00165$
00124$:
;gb-dtmf.c:616: NR51_REG = 0x00U;
	ld	a, #0x00
	ldh	(_NR51_REG+0),a
;gb-dtmf.c:618: break_button(i, j);
	ldhl	sp,	#61
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_break_button
	add	sp, #2
;gb-dtmf.c:624: if(i == 5 && (j == 0 || j == 1 || j == 2)){
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jp	Z, 00165$
	ldhl	sp,	#61
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
	ldhl	sp,	#46
	ld	a, (hl)
	or	a, a
	jr	NZ, 00118$
	inc	hl
	ld	a, (hl)
	or	a, a
	jp	Z, 00165$
00118$:
;gb-dtmf.c:625: non_flick = OFF;
	xor	a, a
	ldhl	sp,	#40
	ld	(hl), a
;gb-dtmf.c:626: if(ch_pos == 0)
	ldhl	sp,	#63
	ld	a, (hl)
	or	a, a
	jr	NZ, 00116$
;gb-dtmf.c:627: clr_disp();
	call	_clr_disp
	jp	00165$
00116$:
;gb-dtmf.c:629: disp(str);
	ldhl	sp,	#0
	push	hl
	call	_disp
	add	sp, #2
	jp	00165$
00164$:
;gb-dtmf.c:634: if(key1 & J_A){
	ldhl	sp,	#44
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00165$
;gb-dtmf.c:636: press_button(i, j);
	ldhl	sp,	#61
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_press_button
	add	sp, #2
;gb-dtmf.c:642: str[ch_pos] = pad[j][i];
	ldhl	sp,	#61
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#57
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#56
	ld	(hl), a
;gb-dtmf.c:639: if(i <= 3 && j <= 3){
	ldhl	sp,	#53
	bit	0, (hl)
	jr	NZ, 00129$
	inc	hl
	bit	0, (hl)
	jr	NZ, 00129$
;gb-dtmf.c:641: if(ch_pos < MAX_DTMF-1){
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x1d
	jr	NC, 00129$
;gb-dtmf.c:642: str[ch_pos] = pad[j][i];
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ldhl	sp,	#63
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
	ld	(hl), a
;c
	ld	de, #_pad
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
;c
	ldhl	sp,	#62
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#53
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;gb-dtmf.c:643: ch_pos++;
	ldhl	sp,	#63
	inc	(hl)
;gb-dtmf.c:644: str[ch_pos] = 0x00;
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;gb-dtmf.c:645: disp(str);
	push	bc
	call	_disp
	add	sp, #2
00129$:
;gb-dtmf.c:650: if(i == 4 && j == 2){
	ldhl	sp,	#62
	ld	a, (hl)
	sub	a, #0x04
	ld	a, #0x01
	jr	Z, 00450$
	xor	a, a
00450$:
	ldhl	sp,	#48
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00134$
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00134$
;gb-dtmf.c:652: if(ch_pos < MAX_DTMF-1){
	ldhl	sp,	#63
	ld	a, (hl)
	sub	a, #0x1d
	jr	NC, 00134$
;gb-dtmf.c:653: str[ch_pos] = pad[j][i];
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#49
	ld	(hl+), a
;c
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#63
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#53
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#52
	ld	(hl), a
;c
	ld	de, #_pad
	ldhl	sp,	#55
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#55
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#54
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#62
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#57
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#56
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;gb-dtmf.c:654: ch_pos++;
	ldhl	sp,	#63
	inc	(hl)
;gb-dtmf.c:655: str[ch_pos] = 0x00;
;c
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#63
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;gb-dtmf.c:656: disp(str);
	ldhl	sp,#49
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_disp
	add	sp, #2
00134$:
;gb-dtmf.c:661: if(i == 4 && j == 0){
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00137$
	ldhl	sp,	#61
	ld	a, (hl)
	or	a, a
	jr	NZ, 00137$
;gb-dtmf.c:662: ch_pos = 0x00;
	xor	a, a
	inc	hl
	inc	hl
	ld	(hl), a
;gb-dtmf.c:663: strcpy(str,"");
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#55
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #___str_2
	push	hl
	push	bc
	call	_strcpy
	add	sp, #4
;gb-dtmf.c:664: clr_disp();
	call	_clr_disp
00137$:
;gb-dtmf.c:668: if(i == 4 && j == 1){
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	Z, 00145$
	dec	hl
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00145$
;gb-dtmf.c:669: if(ch_pos > 0){
	ldhl	sp,	#63
	ld	a, (hl)
	or	a, a
	jr	Z, 00145$
;gb-dtmf.c:670: ch_pos--;
	dec	(hl)
;gb-dtmf.c:671: str[ch_pos] = 0x00;
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ldhl	sp,	#63
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;gb-dtmf.c:672: if(ch_pos == 0)
	ldhl	sp,	#63
	ld	a, (hl)
	or	a, a
	jr	NZ, 00140$
;gb-dtmf.c:673: clr_disp();
	call	_clr_disp
	jr	00145$
00140$:
;gb-dtmf.c:675: disp(str);
	push	bc
	call	_disp
	add	sp, #2
00145$:
;gb-dtmf.c:680: if(i == 5 && j == 1){
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00150$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00150$
;gb-dtmf.c:681: if(on_time >= DTMF_ON / 2){
	ldhl	sp,	#57
	ld	a, (hl)
	sub	a, #0x32
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00150$
;gb-dtmf.c:682: on_time = on_time - 10;
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#58
	ld	(hl-), a
	ld	(hl), e
;gb-dtmf.c:683: off_time = off_time - 10;
	ldhl	sp,#59
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#60
	ld	(hl-), a
	ld	(hl), e
00150$:
;gb-dtmf.c:688: if(i == 5 && j == 2){
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00155$
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00155$
;gb-dtmf.c:689: if(on_time <= DTMF_ON * 2){
	ldhl	sp,	#57
	ld	a, #0xc8
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00155$
;gb-dtmf.c:690: on_time = on_time + 10;
;c
	ldhl	sp,#57
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#59
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#58
;gb-dtmf.c:691: off_time = off_time + 10;
;c
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#61
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#60
	ld	(hl), a
00155$:
;gb-dtmf.c:696: if((i==4 || i==5) && j==3){
	ldhl	sp,	#48
	ld	a, (hl)
	or	a, a
	jr	NZ, 00160$
	ldhl	sp,	#45
	ld	a, (hl)
	or	a, a
	jr	Z, 00165$
00160$:
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00165$
;gb-dtmf.c:697: dialtone(on_time, off_time, str);
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#55
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#61
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_dialtone
	add	sp, #6
00165$:
;gb-dtmf.c:701: if(!(key1 & J_A)){
	ldhl	sp,	#44
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00185$
;gb-dtmf.c:702: if((key1 & J_UP) && !(key2 & J_UP) && j > 0)
	dec	hl
	bit	2, (hl)
	jr	Z, 00171$
	ldhl	sp,	#41
	bit	2, (hl)
	jr	NZ, 00171$
	ldhl	sp,	#61
	ld	a, (hl)
	or	a, a
	jr	Z, 00171$
;gb-dtmf.c:703: j--;
	dec	(hl)
	jr	00172$
00171$:
;gb-dtmf.c:704: else if((key1 & J_DOWN) && !(key2 & J_DOWN) && j < 3)
	ldhl	sp,	#42
	bit	3, (hl)
	jr	Z, 00172$
	ldhl	sp,	#41
	bit	3, (hl)
	jr	NZ, 00172$
	ldhl	sp,	#61
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00172$
;gb-dtmf.c:705: j++;
	inc	(hl)
00172$:
;gb-dtmf.c:707: if((key1 & J_LEFT) && !(key2 & J_LEFT) && i > 0)
	ldhl	sp,	#42
	bit	1, (hl)
	jr	Z, 00180$
	ldhl	sp,	#41
	bit	1, (hl)
	jr	NZ, 00180$
	ldhl	sp,	#62
	ld	a, (hl)
	or	a, a
	jr	Z, 00180$
;gb-dtmf.c:708: i--;
	dec	(hl)
	jr	00185$
00180$:
;gb-dtmf.c:709: else if((key1 & J_RIGHT) && !(key2 & J_RIGHT) && i < 5)
	ldhl	sp,	#42
	bit	0, (hl)
	jr	Z, 00185$
	ldhl	sp,	#41
	bit	0, (hl)
	jr	NZ, 00185$
	ldhl	sp,	#62
	ld	a, (hl)
	sub	a, #0x05
	jr	NC, 00185$
;gb-dtmf.c:710: i++;
	inc	(hl)
00185$:
;gb-dtmf.c:712: key2 = key1;
	ldhl	sp,	#42
	ld	a, (hl-)
	ld	(hl), a
	jp	00187$
;gb-dtmf.c:714: }
	add	sp, #64
	ret
___str_0:
	.ascii " GB-DTMF BY 05AMU "
	.db 0x00
___str_1:
	.ascii "%u MS"
	.db 0x00
___str_2:
	.db 0x00
	.area _CODE
	.area _CABS (ABS)
