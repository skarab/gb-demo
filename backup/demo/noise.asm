;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module noise
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_Noise
	.globl _Scene_Noise
	.globl _noise_lcd
	.globl _noise_vbl
	.globl _set_palette
	.globl _set_bkg_data
	.globl _get_bkg_xy_addr
	.globl _display_off
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _mode
	.globl _add_LCD
	.globl _add_VBL
	.globl _remove_LCD
	.globl _remove_VBL
	.globl _noise_scanline_offsets
	.globl _noise_scanline
	.globl _noise
	.globl _noise_pos
	.globl _noise_y
	.globl _noise_output
	.globl _noise_scanline_offsets_tbl
	.globl ___bank_noise
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_noise_output::
	.ds 720
_noise_y::
	.ds 1
_noise_pos::
	.ds 2
_noise::
	.ds 1
_noise_scanline::
	.ds 1
_noise_scanline_offsets::
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
;src\noise.c:11: UINT8 noise_y = 0;
	ld	hl, #_noise_y
	ld	(hl), #0x00
;src\noise.c:12: UINT8** noise_pos = noise_output+20;
	ld	hl, #_noise_pos
	ld	(hl), #<((_noise_output + 0x0028))
	inc	hl
	ld	(hl), #>((_noise_output + 0x0028))
;src\noise.c:13: UINT8 noise = 0;
	ld	hl, #_noise
	ld	(hl), #0x00
;src\noise.c:14: UINT8 noise_scanline = 0;
	ld	hl, #_noise_scanline
	ld	(hl), #0x00
;src\noise.c:16: const UBYTE* noise_scanline_offsets = noise_scanline_offsets_tbl;
	ld	hl, #_noise_scanline_offsets
	ld	(hl), #<(_noise_scanline_offsets_tbl)
	inc	hl
	ld	(hl), #>(_noise_scanline_offsets_tbl)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_4
;src\noise.c:18: void noise_vbl()
;	---------------------------------
; Function noise_vbl
; ---------------------------------
_noise_vbl::
;src\noise.c:20: noise_pos = noise_output+(20*2+2);
	ld	hl, #_noise_pos
	ld	a, #<((_noise_output + 0x0054))
	ld	(hl+), a
	ld	(hl), #>((_noise_output + 0x0054))
;src\noise.c:21: noise_y = 0;
	ld	hl, #_noise_y
	ld	(hl), #0x00
;src\noise.c:22: noise_scanline = 0;
	ld	hl, #_noise_scanline
	ld	(hl), #0x00
;src\noise.c:23: }
	ret
___bank_noise	=	0x0004
_noise_scanline_offsets_tbl:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
;src\noise.c:25: void noise_lcd()
;	---------------------------------
; Function noise_lcd
; ---------------------------------
_noise_lcd::
	dec	sp
;src\noise.c:27: SCX_REG = (noise_scanline_offsets[noise_scanline & (UBYTE)7]+1)*2;
	ld	a, (#_noise_scanline)
	and	a, #0x07
	ld	c, a
	ld	hl, #_noise_scanline_offsets
	ld	a, (hl)
	add	a, c
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	inc	a
	add	a, a
	ldh	(_SCX_REG+0),a
;src\noise.c:29: for (UINT8 i=noise_scanline ; i<=LY_REG ; ++i)
	ld	a, (#_noise_scanline)
	ldhl	sp,	#0
	ld	(hl), a
00110$:
	ldh	a, (_LY_REG+0)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	C, 00112$
;src\noise.c:31: UINT8 old = noise_y;
	ld	hl, #_noise_y
	ld	c, (hl)
;src\noise.c:32: noise_y = noise_scanline>>3;
	ld	a, (#_noise_scanline)
	swap	a
	rlca
	and	a, #0x1f
	ld	(#_noise_y),a
;src\noise.c:33: ++noise_scanline;
	ld	hl, #_noise_scanline
	inc	(hl)
;src\noise.c:35: if (noise_y!=old)
	ld	a, (#_noise_y)
	sub	a, c
	jr	Z, 00105$
;src\noise.c:37: if (noise_y==10)
	ld	a, (#_noise_y)
	sub	a, #0x0a
	jr	NZ, 00102$
;src\noise.c:39: noise_pos = noise_output+2;
	ld	hl, #_noise_pos
	ld	a, #<((_noise_output + 0x0004))
	ld	(hl+), a
	ld	(hl), #>((_noise_output + 0x0004))
	jr	00105$
00102$:
;src\noise.c:43: noise_pos += 4;
	ld	hl, #_noise_pos
	ld	a, (hl)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
00105$:
;src\noise.c:47: if (noise_y<9)
	ld	a, (#_noise_y)
	sub	a, #0x09
	jr	NC, 00111$
;src\noise.c:49: **noise_pos = noise;
	ld	hl, #_noise_pos + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (#_noise)
	ld	(bc), a
;src\noise.c:50: ++noise_pos;
	ld	hl, #_noise_pos
	ld	a, (hl)
	add	a, #0x02
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
;src\noise.c:51: **noise_pos = noise;
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (#_noise)
	ld	(bc), a
;src\noise.c:52: ++noise_pos;
	ld	hl, #_noise_pos
	ld	a, (hl)
	add	a, #0x02
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
00111$:
;src\noise.c:29: for (UINT8 i=noise_scanline ; i<=LY_REG ; ++i)
	ldhl	sp,	#0
	inc	(hl)
	jr	00110$
00112$:
;src\noise.c:55: }
	inc	sp
	ret
;src\noise.c:57: void Scene_Noise() BANKED
;	---------------------------------
; Function Scene_Noise
; ---------------------------------
	b_Scene_Noise	= 4
_Scene_Noise::
	add	sp, #-11
;src\noise.c:61: mode(M_TEXT_OUT);
	ld	a, #0x02
	push	af
	inc	sp
	call	_mode
	inc	sp
;src\noise.c:63: disable_interrupts();
	call	_disable_interrupts
;src\noise.c:64: DISPLAY_OFF;
	call	_display_off
;src\noise.c:65: set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	ld	hl, #0x001b
	push	hl
	call	_set_palette
	add	sp, #2
;src\noise.c:66: set_bkg_data(0, 32, fire_tiles_tiledata);
	ld	hl, #_fire_tiles_tiledata
	push	hl
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src\noise.c:69: for (y=0 ; y!=18 ; ++y)
	xor	a, a
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src\noise.c:71: for (x=0 ; x!=20 ; ++x)
00120$:
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
;c
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_noise_output
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x0c
	ld	a, #0x01
	jr	Z, 00167$
	xor	a, a
00167$:
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#10
	ld	(hl), a
00111$:
;src\noise.c:73: *(noise_output+oy+x) = get_bkg_xy_addr(x, y);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_xy_addr
	add	sp, #2
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src\noise.c:75: if (y==12 && x>=2 && x<18)
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00102$
	ld	a, (hl)
	sub	a, #0x12
	jr	NC, 00102$
;src\noise.c:77: **(noise_output+oy+x) = 16+x-2;
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, #0x0e
	ld	(bc), a
	jr	00112$
00102$:
;src\noise.c:81: **(noise_output+oy+x) = 4;
;c
	pop	de
	push	de
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	l, c
	ld	h, a
	ld	(hl), #0x04
00112$:
;src\noise.c:71: for (x=0 ; x!=20 ; ++x)
	ldhl	sp,	#10
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	NZ, 00111$
;src\noise.c:84: oy += 20;
;c
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
;src\noise.c:69: for (y=0 ; y!=18 ; ++y)
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x12
	jp	NZ,00120$
;src\noise.c:91: }
	di
;src\noise.c:88: STAT_REG = 0x18;
	ld	a, #0x18
	ldh	(_STAT_REG+0),a
;src\noise.c:89: add_VBL(noise_vbl);
	ld	hl, #_noise_vbl
	push	hl
	call	_add_VBL
	add	sp, #2
;src\noise.c:90: add_LCD(noise_lcd);
	ld	hl, #_noise_lcd
	push	hl
	call	_add_LCD
	add	sp, #2
	ei
;src\noise.c:92: set_interrupts(LCD_IFLAG | VBL_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src\noise.c:94: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\noise.c:95: enable_interrupts();
	call	_enable_interrupts
;src\noise.c:99: while (sync++<30)
	ld	bc, #0x0000
00108$:
	ld	a, c
	sub	a, #0x1e
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00110$
	inc	bc
;src\noise.c:101: noise = (noise+1)%16;
	ld	hl, #_noise
	ld	e, (hl)
	ld	d, #0x00
	inc	de
	push	bc
	ld	hl, #0x0010
	push	hl
	push	de
	call	__modsint
	add	sp, #4
	pop	bc
	ld	hl, #_noise
	ld	(hl), e
;src\noise.c:102: noise_scanline_offsets = &noise_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
	ld	hl, #_sys_time + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	and	a, #0x07
	ld	e, a
	ld	d, #0x00
	ld	hl, #_noise_scanline_offsets_tbl
	add	hl, de
	ld	a, l
	ld	(_noise_scanline_offsets), a
	ld	a, h
	ld	(_noise_scanline_offsets + 1), a
	jr	00108$
00110$:
;src\noise.c:106: disable_interrupts();
	call	_disable_interrupts
;src\noise.c:107: DISPLAY_OFF;
	call	_display_off
;src\noise.c:114: }
	di
;src\noise.c:110: remove_LCD(noise_lcd);
	ld	hl, #_noise_lcd
	push	hl
	call	_remove_LCD
	add	sp, #2
;src\noise.c:111: remove_VBL(noise_vbl);
	ld	hl, #_noise_vbl
	push	hl
	call	_remove_VBL
	add	sp, #2
;src\noise.c:112: SCX_REG = 0;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
;src\noise.c:113: STAT_REG = 0x44;
	ld	a, #0x44
	ldh	(_STAT_REG+0),a
	ei
;src\noise.c:116: set_interrupts(LCD_IFLAG | VBL_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src\noise.c:117: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\noise.c:118: enable_interrupts();
	call	_enable_interrupts
;src\noise.c:119: }
	add	sp, #11
	ret
	.area _CODE_4
	.area _CABS (ABS)
