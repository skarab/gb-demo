;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module squares_race
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_SquaresRace
	.globl _Scene_SquaresRace
	.globl _squares_race_lcd
	.globl _squares_race_vbl
	.globl _squares_race_precalc
	.globl _set_palette
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _add_LCD
	.globl _add_VBL
	.globl _race_anim
	.globl _squares_precalc_y
	.globl _squares_precalc_x
	.globl ___bank_squares_race
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_squares_precalc_x::
	.ds 2880
_squares_precalc_y::
	.ds 2880
_race_anim::
	.ds 1
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
;src\squares_race.c:51: UINT8 race_anim = 0;
	ld	hl, #_race_anim
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_6
;src\squares_race.c:21: void squares_race_precalc()
;	---------------------------------
; Function squares_race_precalc
; ---------------------------------
_squares_race_precalc::
	add	sp, #-18
;src\squares_race.c:23: for (UINT8 i = 0 ; i<race_loop ; ++i)
	xor	a, a
	ldhl	sp,	#17
	ld	(hl), a
00111$:
	ldhl	sp,	#17
;src\squares_race.c:25: UINT8 old_size = ((i*race_i_mul)*(i*race_i_mul))/race_divide;
	ld	a,(hl)
	cp	a,#0x28
	jp	NC,00113$
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	pop	bc
	push	bc
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00177$
	bit	7, d
	jr	NZ, 00178$
	cp	a, a
	jr	00178$
00177$:
	bit	7, d
	jr	Z, 00178$
	scf
00178$:
	ld	a, #0x00
	rla
	ldhl	sp,	#4
;c
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00115$
	inc	hl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), e
00115$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00116$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00116$:
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	push	de
	push	bc
	call	__mulint
	add	sp, #4
	ld	hl, #0x000c
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ldhl	sp,	#7
	ld	(hl), e
;src\squares_race.c:26: UINT8 s = ((i*race_i_mul)/race_divide)&1;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00117$:
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #0x000c
	push	hl
	push	bc
	call	__divsint
	add	sp, #4
	ld	a, e
	and	a, #0x01
	ldhl	sp,	#8
	ld	(hl), a
;src\squares_race.c:28: for (UINT8 j = 0 ; j<72 ; ++j)
	ld	c, #0x00
00108$:
	ld	a, c
	sub	a, #0x48
	jp	NC, 00112$
;src\squares_race.c:30: UINT8 square_size = j*2/3 + 16;
	ldhl	sp,	#9
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sla	e
	rl	d
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	add	a, #0x10
	ldhl	sp,	#11
;src\squares_race.c:31: UINT8 p = (j+(i*race_i_mul))/race_divide;
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00118$:
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
;c
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	ld	hl, #0x000c
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
;src\squares_race.c:32: UINT8 psquare_size = p*p;
	push	bc
	push	af
	inc	sp
	push	af
	inc	sp
	call	__muluchar
	add	sp, #2
	pop	bc
;src\squares_race.c:34: if (psquare_size!=old_size)
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, e
	jr	Z, 00102$
;src\squares_race.c:36: old_size = psquare_size;
	ldhl	sp,	#7
;src\squares_race.c:37: s = !s;
	ld	a, e
	ld	(hl+), a
	ld	a, (hl)
	sub	a,#0x01
	ld	a, #0x00
	rla
	ld	(hl), a
00102$:
;src\squares_race.c:40: UINT8 add = 0;
	xor	a, a
	ldhl	sp,	#12
	ld	(hl), a
;src\squares_race.c:41: if (s!=0) add = square_size;
	ldhl	sp,	#8
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	(hl), a
00104$:
;src\squares_race.c:43: UINT8 sin = j*sintable[i*3]/64;
	pop	de
	push	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	ld	de, #_sintable
	add	hl, de
	ld	a, (hl)
	push	bc
	ld	b, a
	push	bc
	call	__muluchar
	add	sp, #2
	push	hl
	ldhl	sp,	#17
	ld	(hl), e
	ldhl	sp,	#18
	ld	(hl), d
	pop	hl
	pop	bc
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00181$
	bit	7, d
	jr	NZ, 00182$
	cp	a, a
	jr	00182$
00181$:
	bit	7, d
	jr	Z, 00182$
	scf
00182$:
	jr	NC, 00119$
;c
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x003f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
00119$:
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
;src\squares_race.c:45: squares_precalc_x[j][i] = (add + j + sin) % (square_size*2);
	ld	e, c
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
;c
	ld	de, #_squares_precalc_x
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
;c
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#12
	ld	e, (hl)
	ld	d, #0x00
;c
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	l, b
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	l, (hl)
	ld	b, #0x00
	ld	h, b
	add	hl, hl
	push	bc
	push	hl
	push	de
	call	__modsint
	add	sp, #4
	pop	bc
	ld	b, e
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), b
;src\squares_race.c:46: squares_precalc_y[j][i] = (square_size - 16)*4;
;c
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_squares_precalc_y
	add	hl, de
	ld	e, l
	ld	d, h
;c
	ldhl	sp,	#17
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, #0xf0
	add	a, a
	add	a, a
	ld	(de), a
;src\squares_race.c:28: for (UINT8 j = 0 ; j<72 ; ++j)
	inc	c
	jp	00108$
00112$:
;src\squares_race.c:23: for (UINT8 i = 0 ; i<race_loop ; ++i)
	ldhl	sp,	#17
	inc	(hl)
	jp	00111$
00113$:
;src\squares_race.c:49: }
	add	sp, #18
	ret
___bank_squares_race	=	0x0006
;src\squares_race.c:53: void squares_race_vbl()
;	---------------------------------
; Function squares_race_vbl
; ---------------------------------
_squares_race_vbl::
;src\squares_race.c:55: ++race_anim;
	ld	hl, #_race_anim
	inc	(hl)
;src\squares_race.c:56: if (race_anim>=race_loop)
	ld	a, (hl)
	sub	a, #0x28
	ret	C
;src\squares_race.c:57: race_anim = 8;
	ld	(hl), #0x08
;src\squares_race.c:58: }
	ret
;src\squares_race.c:60: void squares_race_lcd()
;	---------------------------------
; Function squares_race_lcd
; ---------------------------------
_squares_race_lcd::
	add	sp, #-2
;src\squares_race.c:62: UINT8 y = LY_REG;
	ldh	a, (_LY_REG+0)
	ldhl	sp,	#0
	ld	(hl), a
;src\squares_race.c:67: UINT8 ra = race_anim;
	ld	a, (#_race_anim)
	ldhl	sp,	#1
;src\squares_race.c:64: if (y<30)
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x1e
	jr	NC, 00105$
;src\squares_race.c:66: UINT8 cy = 72-y*2-6;
	ld	l, (hl)
	add	hl, hl
	ld	a, #0x42
	sub	a, l
	ld	c, a
;src\squares_race.c:68: UINT8 sx = squares_precalc_x[cy][ra];
	ld	b, #0x00
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
	ld	hl, #_squares_precalc_x
	add	hl, bc
	ld	e, l
	ld	d, h
;c
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldh	(_SCX_REG+0),a
;src\squares_race.c:69: UINT8 sy = squares_precalc_y[cy][ra]-y;
	ld	hl, #_squares_precalc_y
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#0
	sub	a, (hl)
	ldh	(_SCY_REG+0),a
;src\squares_race.c:71: SCY_REG = sy;
	jr	00107$
00105$:
;src\squares_race.c:73: else if (y<80)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x50
	jr	NC, 00102$
;src\squares_race.c:75: SCY_REG = -y-10;
	xor	a, a
	sub	a, (hl)
	add	a, #0xf6
	ldh	(_SCY_REG+0),a
;src\squares_race.c:76: SCX_REG = 0;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
	jr	00107$
00102$:
;src\squares_race.c:80: UINT8 cy = y-80;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0xb0
	ld	c, a
;src\squares_race.c:82: UINT8 sx = squares_precalc_x[cy][ra];
	ld	b, #0x00
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
	ld	hl, #_squares_precalc_x
	add	hl, bc
	ld	e, l
	ld	d, h
;c
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldh	(_SCX_REG+0),a
;src\squares_race.c:83: UINT8 sy = squares_precalc_y[cy][ra]-y;
	ld	hl, #_squares_precalc_y
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#0
	sub	a, (hl)
	ldh	(_SCY_REG+0),a
;src\squares_race.c:85: SCY_REG = sy;
00107$:
;src\squares_race.c:87: }
	add	sp, #2
	ret
;src\squares_race.c:89: void Scene_SquaresRace() BANKED
;	---------------------------------
; Function Scene_SquaresRace
; ---------------------------------
	b_Scene_SquaresRace	= 6
_Scene_SquaresRace::
;src\squares_race.c:91: squares_race_precalc();
	call	_squares_race_precalc
;src\squares_race.c:93: disable_interrupts();
	call	_disable_interrupts
;src\squares_race.c:94: DISPLAY_OFF;
	call	_display_off
;src\squares_race.c:96: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;src\squares_race.c:97: set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	ld	hl, #0x00e4
	push	hl
	call	_set_palette
	add	sp, #2
;src\squares_race.c:98: set_bkg_data(0, squares_zoom_tiledata_count, squares_zoom_tiledata);
	ld	de, #_squares_zoom_tiledata+0
	ld	hl, #_squares_zoom_tiledata_count
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	push	de
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src\squares_race.c:99: set_bkg_tiles(0, 0, 32, 8, squares_zoom_tilemap0);
	ld	hl, #_squares_zoom_tilemap0
	push	hl
	ld	de, #0x0820
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\squares_race.c:100: set_bkg_tiles(0, 8, 32, 8, squares_zoom_tilemap1);
	ld	hl, #_squares_zoom_tilemap1
	push	hl
	ld	de, #0x0820
	push	de
	ld	a, #0x08
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\squares_race.c:101: set_bkg_tiles(0, 16, 32, 6, squares_zoom_tilemap2);
	ld	hl, #_squares_zoom_tilemap2
	push	hl
	ld	de, #0x0620
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\squares_race.c:107: }
	di
;src\squares_race.c:104: STAT_REG = 0x18;
	ld	a, #0x18
	ldh	(_STAT_REG+0),a
;src\squares_race.c:105: add_VBL(squares_race_vbl);
	ld	hl, #_squares_race_vbl
	push	hl
	call	_add_VBL
	add	sp, #2
;src\squares_race.c:106: add_LCD(squares_race_lcd);
	ld	hl, #_squares_race_lcd
	push	hl
	call	_add_LCD
	add	sp, #2
	ei
;src\squares_race.c:108: set_interrupts(LCD_IFLAG | VBL_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src\squares_race.c:110: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\squares_race.c:111: enable_interrupts();
	call	_enable_interrupts
;src\squares_race.c:113: while (1)
00102$:
;src\squares_race.c:115: wait_vbl_done();		
	call	_wait_vbl_done
;src\squares_race.c:122: }
	jr	00102$
	.area _CODE_6
	.area _CABS (ABS)
