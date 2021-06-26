;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module lines
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_Lines
	.globl _Scene_Lines
	.globl _color
	.globl _line
	.globl _mod
	.globl _abs
	.globl _set_default_palette
	.globl _set_palette
	.globl ___bank_lines
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
	.area _CODE_3
;src\lines.c:7: void Scene_Lines() BANKED
;	---------------------------------
; Function Scene_Lines
; ---------------------------------
	b_Scene_Lines	= 3
_Scene_Lines::
	add	sp, #-94
;src\lines.c:9: LCDC_REG = 0xD1;
	ld	a, #0xd1
	ldh	(_LCDC_REG+0),a
;src\lines.c:11: set_default_palette();
	call	_set_default_palette
;src\lines.c:18: short int x0s[7] = { minx, 0, 0, 0 };
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#56
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src\lines.c:19: short int y0s[7] = { miny, 0, 0, 0 };
	ldhl	sp,	#14
	ld	a, l
	ld	d, h
	ldhl	sp,	#58
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ldhl	sp,	#58
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c
	ldhl	sp,#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src\lines.c:20: short int x1s[7] = { maxx, 0, 0, 0 };
	ldhl	sp,	#28
	ld	a, l
	ld	d, h
	ldhl	sp,	#60
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x9f
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src\lines.c:21: short int y1s[7] = { miny, 0, 0, 0 };
	ldhl	sp,	#42
	ld	a, l
	ld	d, h
	ldhl	sp,	#62
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;c
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src\lines.c:22: INT8 i = 0;
	xor	a, a
	ldhl	sp,	#76
	ld	(hl), a
;src\lines.c:24: short int dx0 = 0;
	xor	a, a
	ldhl	sp,	#83
	ld	(hl+), a
;src\lines.c:25: short int dy0 = 4;
	ld	(hl+), a
	ld	(hl), #0x04
	xor	a, a
	inc	hl
	ld	(hl), a
;src\lines.c:26: short int dx1 = 0;
	xor	a, a
	inc	hl
	ld	(hl+), a
;src\lines.c:27: short int dy1 = 4;
	ld	(hl+), a
	ld	(hl), #0x04
	xor	a, a
	inc	hl
;src\lines.c:33: UINT8 col_max = 6;
	ld	(hl+), a
	ld	(hl), #0x06
;src\lines.c:35: while (1)
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl), a
00135$:
;src\lines.c:37: ++sync;
	ldhl	sp,	#92
	inc	(hl)
	jr	NZ, 00335$
	inc	hl
	inc	(hl)
00335$:
;src\lines.c:64: short int x0 = x0s[i];
	ldhl	sp,	#76
	ld	a, (hl)
	ldhl	sp,	#64
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sla	c
	rl	b
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
	ld	(hl), a
;src\lines.c:65: short int y0 = y0s[i];
	ldhl	sp,	#58
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#70
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#69
	ld	(hl), a
;src\lines.c:66: short int x1 = x1s[i];
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#72
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#71
	ld	(hl), a
;src\lines.c:67: short int y1 = y1s[i];
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#74
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#73
	ld	(hl), a
;src\lines.c:38: if (sync==100)
	ldhl	sp,	#92
	ld	a, (hl)
	sub	a, #0x64
	inc	hl
	or	a, (hl)
	jr	NZ, 00113$
;src\lines.c:40: col_max = 7;
	ldhl	sp,	#91
	ld	(hl), #0x07
;src\lines.c:41: set_palette(0);
	ld	hl, #0x0000
	push	hl
	call	_set_palette
	add	sp, #2
	jr	00114$
00113$:
;src\lines.c:43: else if (sync==101)
	ldhl	sp,	#92
	ld	a, (hl)
	sub	a, #0x65
	inc	hl
	or	a, (hl)
	jr	NZ, 00110$
;src\lines.c:45: set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	ld	hl, #0x001b
	push	hl
	call	_set_palette
	add	sp, #2
	jr	00114$
00110$:
;src\lines.c:47: else if (sync==205)
	ldhl	sp,	#92
	ld	a, (hl)
	sub	a, #0xcd
	inc	hl
	or	a, (hl)
	jr	NZ, 00107$
;src\lines.c:49: dx0 = -4;
	ldhl	sp,	#83
	ld	a, #0xfc
	ld	(hl+), a
;src\lines.c:50: dy0 = 3;
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0x03
	xor	a, a
	inc	hl
;src\lines.c:51: dx1 = 2;
	ld	(hl+), a
	ld	(hl), #0x02
	xor	a, a
	inc	hl
;src\lines.c:52: dy1 = -3;
	ld	(hl+), a
	ld	a, #0xfd
	ld	(hl+), a
	ld	(hl), #0xff
	jr	00114$
00107$:
;src\lines.c:54: else if (sync==270)
	ldhl	sp,	#92
	ld	a, (hl)
	sub	a, #0x0e
	jr	NZ, 00104$
	inc	hl
	ld	a, (hl)
	dec	a
	jr	NZ, 00104$
;src\lines.c:56: set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	ld	hl, #0x00e4
	push	hl
	call	_set_palette
	add	sp, #2
	jr	00114$
00104$:
;src\lines.c:58: else if (sync==380)
	ldhl	sp,	#92
	ld	a, (hl)
	sub	a, #0x7c
	jr	NZ, 00114$
	inc	hl
	ld	a, (hl)
	dec	a
	jr	NZ, 00114$
;src\lines.c:60: set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	ld	hl, #0x001b
	push	hl
	call	_set_palette
	add	sp, #2
;src\lines.c:61: break;
	jp	00195$
00114$:
;src\lines.c:64: short int x0 = x0s[i];
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#81
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:65: short int y0 = y0s[i];
	ldhl	sp,#68
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#79
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:66: short int x1 = x1s[i];
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#77
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:67: short int y1 = y1s[i];
	ldhl	sp,#72
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:69: if (x0+dx0<minx || x0+dx0>maxx) dx0 = -dx0; x0 += dx0;
;c
	ldhl	sp,#81
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	bit	7, b
	jr	NZ, 00115$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x9f
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00347$
	bit	7, d
	jr	NZ, 00348$
	cp	a, a
	jr	00348$
00347$:
	bit	7, d
	jr	Z, 00348$
	scf
00348$:
	jr	NC, 00116$
00115$:
	ld	de, #0x0000
	ldhl	sp,	#83
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#84
	ld	(hl-), a
	ld	(hl), e
00116$:
;c
	ldhl	sp,#81
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#81
	ld	a, c
	ld	(hl+), a
;src\lines.c:70: if (y0+dy0<miny || y0+dy0>maxy) dy0 = -dy0; y0 += dy0;
;c
	ld	a, b
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#85
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	bit	7, b
	jr	NZ, 00118$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x8e
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00349$
	bit	7, d
	jr	NZ, 00350$
	cp	a, a
	jr	00350$
00349$:
	bit	7, d
	jr	Z, 00350$
	scf
00350$:
	jr	NC, 00119$
00118$:
	ld	de, #0x0000
	ldhl	sp,	#85
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#86
	ld	(hl-), a
	ld	(hl), e
00119$:
;c
	ldhl	sp,#79
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#85
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#79
	ld	a, c
	ld	(hl+), a
;src\lines.c:71: if (x1+dx1<minx || x1+dx1>maxx) dx1 = -dx1; x1 += dx1;
;c
	ld	a, b
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	bit	7, b
	jr	NZ, 00121$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x9f
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00351$
	bit	7, d
	jr	NZ, 00352$
	cp	a, a
	jr	00352$
00351$:
	bit	7, d
	jr	Z, 00352$
	scf
00352$:
	jr	NC, 00122$
00121$:
	ld	de, #0x0000
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#88
	ld	(hl-), a
	ld	(hl), e
00122$:
;c
	ldhl	sp,#77
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#77
	ld	a, c
	ld	(hl+), a
;src\lines.c:72: if (y1+dy1<miny || y1+dy1>maxy) dy1 = -dy1; y1 += dy1;
;c
	ld	a, b
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#89
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	bit	7, b
	jr	NZ, 00124$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x8e
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00353$
	bit	7, d
	jr	NZ, 00354$
	cp	a, a
	jr	00354$
00353$:
	bit	7, d
	jr	Z, 00354$
	scf
00354$:
	jr	NC, 00125$
00124$:
	ld	de, #0x0000
	ldhl	sp,	#89
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#90
	ld	(hl-), a
	ld	(hl), e
00125$:
;c
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#89
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#71
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\lines.c:74: if (sync>300)
	ldhl	sp,	#92
	ld	a, #0x2c
	sub	a, (hl)
	inc	hl
	ld	a, #0x01
	sbc	a, (hl)
	jp	NC, 00132$
;src\lines.c:76: w = abs(x0-x1);
	ldhl	sp,	#81
	ld	a, (hl)
	ldhl	sp,	#75
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, (hl)
	push	af
	inc	sp
	call	_abs
	inc	sp
	ldhl	sp,	#73
	ld	(hl), e
;src\lines.c:77: h = abs(y0-y1);
	ldhl	sp,	#79
	ld	a, (hl)
	ldhl	sp,	#71
	ld	c, (hl)
	sub	a, c
	push	af
	inc	sp
	call	_abs
	inc	sp
	ldhl	sp,	#74
;src\lines.c:79: if (w>max_length) x1 = x0 + (x1-x0)*max_length/w;
	ld	a, e
	ld	(hl-), a
	ld	e, (hl)
	ld	a,#0x28
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00355$
	bit	7, d
	jr	NZ, 00356$
	cp	a, a
	jr	00356$
00355$:
	bit	7, d
	jr	Z, 00356$
	scf
00356$:
	jr	NC, 00128$
	ldhl	sp,#77
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#81
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#76
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#79
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#78
	ld	(hl), a
	ldhl	sp,	#73
	ld	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	push	bc
	ldhl	sp,	#79
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
;c
	ldhl	sp,	#81
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#77
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00128$:
;src\lines.c:80: if (h>max_length) y1 = y0 + (y1-y0)*max_length/h;
	ldhl	sp,	#74
	ld	e, (hl)
	ld	a,#0x28
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00357$
	bit	7, d
	jr	NZ, 00358$
	cp	a, a
	jr	00358$
00357$:
	bit	7, d
	jr	Z, 00358$
	scf
00358$:
	jr	NC, 00132$
	ldhl	sp,#71
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#79
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#74
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	push	de
	push	bc
	call	__divsint
	add	sp, #4
;c
	ldhl	sp,	#79
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#71
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00132$:
;src\lines.c:83: i = (i+1)%7;
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	de, #0x0007
	push	de
	push	hl
	call	__modsint
	add	sp, #4
	ldhl	sp,	#76
	ld	(hl), e
;src\lines.c:84: x0s[i] = x0;
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sla	c
	rl	b
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#81
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:85: y0s[i] = y0;
	ldhl	sp,	#58
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#79
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:86: x1s[i] = x1;
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#77
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:87: y1s[i] = y1;
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#71
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src\lines.c:89: for (INT8 j=i-6 ; j<=i ; ++j)
	ldhl	sp,	#76
	ld	a, (hl)
	add	a, #0xfa
	ldhl	sp,	#82
	ld	(hl), a
00159$:
	ldhl	sp,	#82
	ld	e, (hl)
	ldhl	sp,	#76
	ld	d, (hl)
	ld	a, (hl)
	ldhl	sp,	#82
	sub	a, (hl)
	bit	7, e
	jr	Z, 00360$
	bit	7, d
	jr	NZ, 00361$
	cp	a, a
	jr	00361$
00360$:
	bit	7, d
	jr	Z, 00361$
	scf
00361$:
	jp	C, 00135$
;src\lines.c:91: INT8 col = 3-(((i-j)%7)*3/col_max);
	ldhl	sp,	#82
	ld	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ldhl	sp,#74
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	b, a
	ld	c, e
	ld	hl, #0x0007
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	ld	c, e
	ld	b, d
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#91
	ld	e, (hl)
	ld	d, #0x00
	push	de
	push	bc
	call	__divsint
	add	sp, #4
	ld	a, #0x03
	sub	a, e
	ld	b, a
;src\lines.c:92: INT8 id = mod(j, 7);
	push	bc
	ld	a, #0x07
	push	af
	inc	sp
	ldhl	sp,	#85
	ld	a, (hl)
	push	af
	inc	sp
	call	_mod
	add	sp, #2
	pop	bc
	ldhl	sp,	#81
	ld	(hl), e
;src\lines.c:93: color(col, 0, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_color
	add	sp, #3
;src\lines.c:94: line(x0s[id], y0s[id], x1s[id], y1s[id]);
	ldhl	sp,	#81
	ld	a, (hl-)
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#81
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
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#82
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#81
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#78
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	b, a
;c
	ldhl	sp,#58
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#78
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	c, a
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#78
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#81
	ld	h, (hl)
	push	hl
	inc	sp
	push	bc
	inc	sp
	ld	h, c
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_line
	add	sp, #4
;src\lines.c:89: for (INT8 j=i-6 ; j<=i ; ++j)
	ldhl	sp,	#82
	inc	(hl)
	jp	00159$
;src\lines.c:98: for (int k=0 ; k<144 ; k += 2)
00195$:
	xor	a, a
	ldhl	sp,	#91
	ld	(hl+), a
	ld	(hl), a
00165$:
	ldhl	sp,	#91
	ld	a, (hl)
	sub	a, #0x90
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jr	Z, 00363$
	bit	7, d
	jr	NZ, 00364$
	cp	a, a
	jr	00364$
00363$:
	bit	7, d
	jr	Z, 00364$
	scf
00364$:
	jp	NC, 00167$
;src\lines.c:100: miny = k+1;
	ldhl	sp,#91
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#81
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\lines.c:102: short int x0 = x0s[i];
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src\lines.c:103: short int y0 = y0s[i];
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#77
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:104: short int x1 = x1s[i];
	ldhl	sp,#70
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#79
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:105: short int y1 = y1s[i];
	ldhl	sp,#72
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\lines.c:107: if (x0+dx0<minx || x0+dx0>maxx) dx0 = -dx0; x0 += dx0;
;c
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#83
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#75
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#74
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00365$
	bit	7, d
	jr	NZ, 00366$
	cp	a, a
	jr	00366$
00365$:
	bit	7, d
	jr	Z, 00366$
	scf
00366$:
	jr	C, 00137$
	ldhl	sp,	#73
	ld	a, #0x9f
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00367$
	bit	7, d
	jr	NZ, 00368$
	cp	a, a
	jr	00368$
00367$:
	bit	7, d
	jr	Z, 00368$
	scf
00368$:
	jr	NC, 00138$
00137$:
	ld	de, #0x0000
	ldhl	sp,	#83
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#84
	ld	(hl-), a
	ld	(hl), e
00138$:
;c
	ldhl	sp,#66
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#83
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#72
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\lines.c:108: if (y0+dy0<miny || y0+dy0>maxy) dy0 = -dy0; y0 += dy0;
;c
	ldhl	sp,#77
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#85
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#81
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00369$
	bit	7, d
	jr	NZ, 00370$
	cp	a, a
	jr	00370$
00369$:
	bit	7, d
	jr	Z, 00370$
	scf
00370$:
	jr	C, 00140$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x8e
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00371$
	bit	7, d
	jr	NZ, 00372$
	cp	a, a
	jr	00372$
00371$:
	bit	7, d
	jr	Z, 00372$
	scf
00372$:
	jr	NC, 00141$
00140$:
	ld	de, #0x0000
	ldhl	sp,	#85
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#86
	ld	(hl-), a
	ld	(hl), e
00141$:
;c
	ldhl	sp,#77
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#85
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#77
	ld	a, c
	ld	(hl+), a
;src\lines.c:109: if (x1+dx1<minx || x1+dx1>maxx) dx1 = -dx1; x1 += dx1;
;c
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	bit	7, b
	jr	NZ, 00143$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x9f
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00373$
	bit	7, d
	jr	NZ, 00374$
	cp	a, a
	jr	00374$
00373$:
	bit	7, d
	jr	Z, 00374$
	scf
00374$:
	jr	NC, 00144$
00143$:
	ld	de, #0x0000
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#88
	ld	(hl-), a
	ld	(hl), e
00144$:
;c
	ldhl	sp,#79
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#87
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#79
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\lines.c:110: if (y1+dy1<miny || y1+dy1>maxy) dy1 = -dy1; y1 += dy1;
;c
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#89
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#81
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00375$
	bit	7, d
	jr	NZ, 00376$
	cp	a, a
	jr	00376$
00375$:
	bit	7, d
	jr	Z, 00376$
	scf
00376$:
	jr	C, 00146$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x8e
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00377$
	bit	7, d
	jr	NZ, 00378$
	cp	a, a
	jr	00378$
00377$:
	bit	7, d
	jr	Z, 00378$
	scf
00378$:
	jr	NC, 00147$
00146$:
	ld	de, #0x0000
	ldhl	sp,	#89
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#90
	ld	(hl-), a
	ld	(hl), e
00147$:
;c
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#89
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#81
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\lines.c:112: w = abs(x0-x1);
	ldhl	sp,	#72
	ld	a, (hl)
	ldhl	sp,	#79
	ld	c, (hl)
	sub	a, c
	push	af
	inc	sp
	call	_abs
	inc	sp
	ld	c, e
;src\lines.c:113: h = abs(y0-y1);
	ldhl	sp,	#77
	ld	a, (hl)
	ldhl	sp,	#81
	ld	b, (hl)
	sub	a, b
	push	bc
	push	af
	inc	sp
	call	_abs
	inc	sp
	pop	bc
	ldhl	sp,	#93
	ld	(hl), e
;src\lines.c:115: if (w>max_length) x1 = x0 + (x1-x0)*max_length/w;
	ld	e, c
	ld	a,#0x28
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00379$
	bit	7, d
	jr	NZ, 00380$
	cp	a, a
	jr	00380$
00379$:
	bit	7, d
	jr	Z, 00380$
	scf
00380$:
	jr	NC, 00150$
	ldhl	sp,#79
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#76
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, c
	rla
	sbc	a, a
	ld	b, a
	push	bc
	push	hl
	call	__divsint
	add	sp, #4
;c
	ldhl	sp,	#72
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#79
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00150$:
;src\lines.c:116: if (h>max_length) y1 = y0 + (y1-y0)*max_length/h;
	ldhl	sp,	#93
	ld	e, (hl)
	ld	a,#0x28
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00381$
	bit	7, d
	jr	NZ, 00382$
	cp	a, a
	jr	00382$
00381$:
	bit	7, d
	jr	Z, 00382$
	scf
00382$:
	jr	NC, 00152$
	ldhl	sp,#81
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#77
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#93
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	push	de
	push	bc
	call	__divsint
	add	sp, #4
;c
	ldhl	sp,	#77
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#81
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00152$:
;src\lines.c:118: i = (i+1)%7;
	ldhl	sp,	#64
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	de, #0x0007
	push	de
	push	hl
	call	__modsint
	add	sp, #4
	ldhl	sp,	#74
	ld	(hl), e
;src\lines.c:64: short int x0 = x0s[i];
	ld	a, (hl)
	ldhl	sp,	#64
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
;src\lines.c:119: x0s[i] = x0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#75
	ld	(hl+), a
	ld	(hl), e
;src\lines.c:64: short int x0 = x0s[i];
	ldhl	sp,#64
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sla	c
	rl	b
	ldhl	sp,	#56
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#68
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#67
;src\lines.c:119: x0s[i] = x0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#72
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:65: short int y0 = y0s[i];
	ldhl	sp,	#58
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#70
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#69
;src\lines.c:120: y0s[i] = y0;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#77
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:66: short int x1 = x1s[i];
	ldhl	sp,	#60
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#72
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#71
;src\lines.c:121: x1s[i] = x1;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#79
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:67: short int y1 = y1s[i];
	ldhl	sp,	#62
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#74
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#73
;src\lines.c:122: y1s[i] = y1;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#81
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\lines.c:124: for (INT8 j=i-6 ; j<=i ; ++j)
	ldhl	sp,	#74
	ld	a, (hl)
	add	a, #0xfa
	ldhl	sp,	#93
	ld	(hl), a
00162$:
	ldhl	sp,	#93
	ld	e, (hl)
	ldhl	sp,	#74
	ld	d, (hl)
	ld	a, (hl)
	ldhl	sp,	#93
	sub	a, (hl)
	bit	7, e
	jr	Z, 00384$
	bit	7, d
	jr	NZ, 00385$
	cp	a, a
	jr	00385$
00384$:
	bit	7, d
	jr	Z, 00385$
	scf
00385$:
	jp	C, 00156$
;src\lines.c:126: INT8 col = 3-(((i-j)%7)*3/7);
	ldhl	sp,	#93
	ld	a, (hl)
	ldhl	sp,	#79
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,#75
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#79
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#82
	ld	(hl-), a
	ld	(hl), e
	ld	hl, #0x0007
	push	hl
	ldhl	sp,	#83
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__modsint
	add	sp, #4
	ld	c, e
	ld	b, d
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	de, #0x0007
	push	de
	push	hl
	call	__divsint
	add	sp, #4
	ld	a, #0x03
	sub	a, e
	ld	b, a
;src\lines.c:127: INT8 id = mod(j, 7);
	push	bc
	ld	a, #0x07
	push	af
	inc	sp
	ldhl	sp,	#96
	ld	a, (hl)
	push	af
	inc	sp
	call	_mod
	add	sp, #2
	pop	bc
;src\lines.c:128: color(col, 0, SOLID);
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_color
	add	sp, #3
	pop	de
;src\lines.c:129: if (y0s[id]>k && y1s[id] >k)
	ld	a, e
	rla
	sbc	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#77
	ld	(hl), e
	inc	hl
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#58
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#79
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#91
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00387$
	bit	7, d
	jr	NZ, 00388$
	cp	a, a
	jr	00388$
00387$:
	bit	7, d
	jr	Z, 00388$
	scf
00388$:
	jr	NC, 00163$
;c
	ldhl	sp,#62
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#77
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#81
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#91
	ld	e, l
	ld	d, h
	ldhl	sp,	#81
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00389$
	bit	7, d
	jr	NZ, 00390$
	cp	a, a
	jr	00390$
00389$:
	bit	7, d
	jr	Z, 00390$
	scf
00390$:
	jr	NC, 00163$
;src\lines.c:131: line(x0s[id], y0s[id], x1s[id], y1s[id]);
	ldhl	sp,	#81
	ld	(hl), c
;c
	ldhl	sp,#60
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#77
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#82
	ld	(hl), a
	ldhl	sp,	#79
	ld	c, (hl)
;c
	ldhl	sp,#56
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#77
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#81
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#83
	ld	h, (hl)
	push	hl
	inc	sp
	ld	h, c
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_line
	add	sp, #4
00163$:
;src\lines.c:124: for (INT8 j=i-6 ; j<=i ; ++j)
	ldhl	sp,	#93
	inc	(hl)
	jp	00162$
00156$:
;src\lines.c:135: color(BLACK, 0, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src\lines.c:136: line(0, k, 159, k);
	ldhl	sp,	#91
	ld	a, (hl)
	push	af
	inc	sp
	ld	h, #0x9f
	push	hl
	inc	sp
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_line
	add	sp, #4
;src\lines.c:137: line(0, k+1, 159, k+1);
	ldhl	sp,	#91
	ld	a, (hl)
	inc	a
	push	af
	inc	sp
	ld	h, #0x9f
	push	hl
	inc	sp
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_line
	add	sp, #4
;src\lines.c:98: for (int k=0 ; k<144 ; k += 2)
;c
	ldhl	sp,#91
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#93
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#92
	ld	(hl), a
	jp	00165$
00167$:
;src\lines.c:139: }
	add	sp, #94
	ret
___bank_lines	=	0x0003
	.area _CODE_3
	.area _CABS (ABS)
