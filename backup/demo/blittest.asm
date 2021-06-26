;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module blittest
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_BlitTest
	.globl _Scene_BlitTest
	.globl _blittest_lcd
	.globl _blittest_vbl
	.globl _set_palette
	.globl _set_bkg_data
	.globl _get_bkg_xy_addr
	.globl _display_off
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _add_LCD
	.globl _add_VBL
	.globl _test_scanline_offsets
	.globl _scanline
	.globl _toto
	.globl _blittest_pos
	.globl _blittest_offset
	.globl _blittest_y
	.globl _blittest_buffer
	.globl _blittest_output
	.globl _test_scanline_offsets_tbl
	.globl ___bank_fire
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_blittest_output::
	.ds 720
_blittest_buffer::
	.ds 360
_blittest_y::
	.ds 1
_blittest_offset::
	.ds 2
_blittest_pos::
	.ds 2
_toto::
	.ds 1
_scanline::
	.ds 1
_test_scanline_offsets::
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
;src\blittest.c:13: UINT8 blittest_y = 0;
	ld	hl, #_blittest_y
	ld	(hl), #0x00
;src\blittest.c:14: UINT16 blittest_offset = 0;
	ld	hl, #_blittest_offset
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x00
;src\blittest.c:15: UINT8** blittest_pos = blittest_output+20;
	ld	hl, #_blittest_pos
	ld	(hl), #<((_blittest_output + 0x0028))
	inc	hl
	ld	(hl), #>((_blittest_output + 0x0028))
;src\blittest.c:17: UINT8 toto = 0;
	ld	hl, #_toto
	ld	(hl), #0x00
;src\blittest.c:18: UINT8 scanline = 0;
	ld	hl, #_scanline
	ld	(hl), #0x00
;src\blittest.c:31: const UBYTE* test_scanline_offsets = test_scanline_offsets_tbl;
	ld	hl, #_test_scanline_offsets
	ld	(hl), #<(_test_scanline_offsets_tbl)
	inc	hl
	ld	(hl), #>(_test_scanline_offsets_tbl)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_4
;src\blittest.c:20: void blittest_vbl()
;	---------------------------------
; Function blittest_vbl
; ---------------------------------
_blittest_vbl::
;src\blittest.c:22: blittest_pos = blittest_output+(20*2+2);
	ld	hl, #_blittest_pos
	ld	a, #<((_blittest_output + 0x0054))
	ld	(hl+), a
	ld	(hl), #>((_blittest_output + 0x0054))
;src\blittest.c:24: blittest_y = 0;
	ld	hl, #_blittest_y
	ld	(hl), #0x00
;src\blittest.c:27: scanline = 0;
	ld	hl, #_scanline
	ld	(hl), #0x00
;src\blittest.c:28: }
	ret
___bank_fire	=	0x0004
;src\blittest.c:33: void blittest_lcd()
;	---------------------------------
; Function blittest_lcd
; ---------------------------------
_blittest_lcd::
	dec	sp
;src\blittest.c:35: SCX_REG = (test_scanline_offsets[scanline & (UBYTE)7]+1)*2;
	ld	a, (#_scanline)
	and	a, #0x07
	ld	c, a
	ld	hl, #_test_scanline_offsets
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
;src\blittest.c:37: for (UINT8 i=scanline ; i<=LY_REG ; ++i)
	ld	a, (#_scanline)
	ldhl	sp,	#0
	ld	(hl), a
00110$:
	ldh	a, (_LY_REG+0)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	C, 00112$
;src\blittest.c:39: UINT8 old = blittest_y;
	ld	hl, #_blittest_y
	ld	c, (hl)
;src\blittest.c:40: blittest_y = scanline>>3; //LY_REG>>3;
	ld	a, (#_scanline)
	swap	a
	rlca
	and	a, #0x1f
	ld	(#_blittest_y),a
;src\blittest.c:41: ++scanline;
	ld	hl, #_scanline
	inc	(hl)
;src\blittest.c:43: if (blittest_y!=old)
	ld	a, (#_blittest_y)
	sub	a, c
	jr	Z, 00105$
;src\blittest.c:45: if (blittest_y==14)
	ld	a, (#_blittest_y)
	sub	a, #0x0e
	jr	NZ, 00102$
;src\blittest.c:47: blittest_pos = blittest_output+2;
	ld	hl, #_blittest_pos
	ld	a, #<((_blittest_output + 0x0004))
	ld	(hl+), a
	ld	(hl), #>((_blittest_output + 0x0004))
	jr	00105$
00102$:
;src\blittest.c:52: blittest_pos += 4;
	ld	hl, #_blittest_pos
	ld	a, (hl)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
00105$:
;src\blittest.c:57: if (blittest_y<13)
	ld	a, (#_blittest_y)
	sub	a, #0x0d
	jr	NC, 00111$
;src\blittest.c:59: **blittest_pos = toto; //toto; //(*blittest_buf_pos)>>2;
	ld	hl, #_blittest_pos + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (#_toto)
	ld	(bc), a
;src\blittest.c:60: ++blittest_pos;
	ld	hl, #_blittest_pos
	ld	a, (hl)
	add	a, #0x02
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
;src\blittest.c:62: **blittest_pos = toto; //(*blittest_buf_pos)>>2;
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (#_toto)
	ld	(bc), a
;src\blittest.c:63: ++blittest_pos;
	ld	hl, #_blittest_pos
	ld	a, (hl)
	add	a, #0x02
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
00111$:
;src\blittest.c:37: for (UINT8 i=scanline ; i<=LY_REG ; ++i)
	ldhl	sp,	#0
	inc	(hl)
	jr	00110$
00112$:
;src\blittest.c:70: }
	inc	sp
	ret
_test_scanline_offsets_tbl:
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
;src\blittest.c:72: void Scene_BlitTest() BANKED
;	---------------------------------
; Function Scene_BlitTest
; ---------------------------------
	b_Scene_BlitTest	= 4
_Scene_BlitTest::
	add	sp, #-8
;src\blittest.c:76: disable_interrupts();
	call	_disable_interrupts
;src\blittest.c:77: DISPLAY_OFF;
	call	_display_off
;src\blittest.c:79: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;src\blittest.c:80: set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	ld	hl, #0x001b
	push	hl
	call	_set_palette
	add	sp, #2
;src\blittest.c:81: set_bkg_data(0, 16, fire_tiles_tiledata);
	ld	hl, #_fire_tiles_tiledata
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src\blittest.c:84: for (y=0 ; y!=18 ; ++y)
	ld	bc, #0x0000
	xor	a, a
	ldhl	sp,	#6
	ld	(hl), a
;src\blittest.c:86: for (x=0 ; x!=20 ; ++x)
00112$:
	ld	e, c
	ld	d, b
	sla	e
	rl	d
;c
	ld	hl, #_blittest_output
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #_blittest_buffer
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#7
	ld	(hl), a
00106$:
;src\blittest.c:88: *(blittest_output+oy+x) = get_bkg_xy_addr(x, y);
	ldhl	sp,	#7
	ld	a, (hl)
	ld	d, #0x00
	add	a, a
	rl	d
;c
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_xy_addr
	add	sp, #2
	push	hl
	ldhl	sp,	#8
	ld	(hl), e
	ldhl	sp,	#9
	ld	(hl), d
	pop	hl
	pop	de
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\blittest.c:89: *(blittest_buffer+oy+x) = 0;
;c
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#7
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;src\blittest.c:90: **(blittest_output+oy+x) = 4;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x04
;src\blittest.c:86: for (x=0 ; x!=20 ; ++x)
	ldhl	sp,	#7
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	NZ, 00106$
;src\blittest.c:92: oy += 20;
	ld	hl, #0x0014
	add	hl, bc
	ld	c, l
	ld	b, h
;src\blittest.c:84: for (y=0 ; y!=18 ; ++y)
	ldhl	sp,	#6
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x12
	jr	NZ, 00112$
;src\blittest.c:99: }
	di
;src\blittest.c:96: STAT_REG = 0x18;
	ld	a, #0x18
	ldh	(_STAT_REG+0),a
;src\blittest.c:97: add_VBL(blittest_vbl);
	ld	hl, #_blittest_vbl
	push	hl
	call	_add_VBL
	add	sp, #2
;src\blittest.c:98: add_LCD(blittest_lcd);
	ld	hl, #_blittest_lcd
	push	hl
	call	_add_LCD
	add	sp, #2
	ei
;src\blittest.c:100: set_interrupts(LCD_IFLAG | VBL_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src\blittest.c:102: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\blittest.c:103: enable_interrupts();
	call	_enable_interrupts
;src\blittest.c:105: while (1)
00104$:
;src\blittest.c:109: }
	di
;src\blittest.c:108: toto = (toto+1)%16;
	ld	hl, #_toto
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #0x0010
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	ld	hl, #_toto
	ld	(hl), e
	ei
;src\blittest.c:115: test_scanline_offsets = &test_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
	ld	bc, #_test_scanline_offsets_tbl+0
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
	ld	e, #0x00
	and	a, #0x07
	ld	h, #0x00
	ld	l, a
	add	hl, bc
	ld	a, l
	ld	(_test_scanline_offsets), a
	ld	a, h
	ld	(_test_scanline_offsets + 1), a
;src\blittest.c:116: wait_vbl_done(); 
	call	_wait_vbl_done
;src\blittest.c:117: test_scanline_offsets = &test_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
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
	ld	e, #0x00
	and	a, #0x07
	ld	h, #0x00
	ld	l, a
	add	hl, bc
	ld	a, l
	ld	(_test_scanline_offsets), a
	ld	a, h
	ld	(_test_scanline_offsets + 1), a
;src\blittest.c:118: wait_vbl_done();		
	call	_wait_vbl_done
	jr	00104$
;src\blittest.c:124: }
	add	sp, #8
	ret
	.area _CODE_4
	.area _CABS (ABS)
