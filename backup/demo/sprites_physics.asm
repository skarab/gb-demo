;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module sprites_physics
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_SpritesPhysics
	.globl _Scene_SpritesPhysics
	.globl _rand
	.globl _set_palette
	.globl _init_bkg
	.globl _set_sprite_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl ___bank_sprites_physics
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
	.area _CODE_5
;src\sprites_physics.c:10: void Scene_SpritesPhysics() BANKED
;	---------------------------------
; Function Scene_SpritesPhysics
; ---------------------------------
	b_Scene_SpritesPhysics	= 5
_Scene_SpritesPhysics::
	add	sp, #-128
	add	sp, #-36
;src\sprites_physics.c:14: disable_interrupts();
	call	_disable_interrupts
;src\sprites_physics.c:15: DISPLAY_OFF;
	call	_display_off
;src\sprites_physics.c:17: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;src\sprites_physics.c:18: set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	ld	hl, #0x00e4
	push	hl
	call	_set_palette
	add	sp, #2
;src\sprites_physics.c:19: init_bkg(255);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;src\sprites_physics.c:21: SPRITES_8x16;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x04
	ldh	(_LCDC_REG+0),a
;src\sprites_physics.c:22: for (i=0 ; i<8 ; ++i)
	ld	c, #0x00
00127$:
;src\sprites_physics.c:24: set_sprite_data(168+i*2, 1, axelay_sprites_tiledata+i*16);
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_axelay_sprites_tiledata)
	ld	e, a
	ld	a, h
	adc	a, #>(_axelay_sprites_tiledata)
	ld	d, a
	ld	l, e
	ld	h, d
	ld	a, c
	add	a, a
	ld	b, a
	add	a, #0xa8
	push	de
	push	hl
	ld	h, #0x01
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
	pop	de
;src\sprites_physics.c:25: set_sprite_data(168+i*2+1, 1, axelay_sprites_tiledata+i*16+16*8);
	ld	hl, #0x0080
	add	hl, de
	ld	a, b
	add	a, #0xa9
	push	hl
	ld	h, #0x01
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;src\sprites_physics.c:22: for (i=0 ; i<8 ; ++i)
	inc	c
	ld	a, c
	sub	a, #0x08
	jr	C, 00127$
;src\sprites_physics.c:27: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src\sprites_physics.c:47: for (i=0 ; i<40 ; ++i)
	ld	c, #0x00
00129$:
;D:/prog/gameboy/gbdk/include/gb/gb.h:1244: shadow_OAM[nb].y = 0;
	ld	de, #_shadow_OAM+0
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	(hl), #0x00
;src\sprites_physics.c:47: for (i=0 ; i<40 ; ++i)
	inc	c
	ld	a, c
	sub	a, #0x28
	jr	C, 00129$
;src\sprites_physics.c:52: for (i=0 ; i<sprite_count ; ++i)
	ldhl	sp,	#80
	ld	a, l
	ld	d, h
	ld	hl, #130
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#100
	ld	a, l
	ld	d, h
	ld	hl, #132
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#120
	ld	a, l
	ld	d, h
	ld	hl, #134
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ld	hl, #136
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#20
	ld	a, l
	ld	d, h
	ld	hl, #138
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#40
	ld	a, l
	ld	d, h
	ld	hl, #140
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#60
	ld	a, l
	ld	d, h
	ld	hl, #142
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	xor	a, a
	ld	hl, #163
	add	hl, sp
	ld	(hl), a
00131$:
;src\sprites_physics.c:54: sprite_size[i] = 255;
;c
	ld	hl, #135
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #163
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0xff
;src\sprites_physics.c:55: sprite_x[i] = rand()/(128/right);
	ld	hl, #163
	add	hl, sp
	ld	a, (hl)
	ld	c, #0x00
	add	a, a
	rl	c
	ld	hl, #157
	add	hl, sp
	ld	(hl+), a
	ld	(hl), c
;c
	ld	hl, #137
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	call	_rand
	pop	bc
	ld	a, e
	rla
	sbc	a, a
	ld	d, a
	push	bc
	ld	hl, #0x0005
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src\sprites_physics.c:56: sprite_y[i] = rand()/(128/-bottom);
;c
	ld	hl, #139
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	call	_rand
	pop	bc
	ld	a, e
	rla
	sbc	a, a
	ld	d, a
	push	bc
	ld	hl, #0x0006
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src\sprites_physics.c:57: sprite_z[i] = TOINT(5);
;c
	ld	hl, #141
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x64
	inc	bc
	ld	a, #0x00
	ld	(bc), a
;src\sprites_physics.c:58: sprite_dx[i] = rand()/32;
;c
	ld	hl, #143
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #161
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #160
	add	hl, sp
	ld	(hl), a
	call	_rand
	ld	a, e
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #161
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00137$
	ld	hl, #0x001f
	add	hl, bc
	push	hl
	ld	a, l
	ld	hl, #163
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #162
	add	hl, sp
	ld	(hl), a
00137$:
	ld	hl, #162
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #159
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\sprites_physics.c:59: if (sprite_dx[i]==0) sprite_dx[i] = 1;
	ld	a, b
	or	a, c
	jr	NZ, 00104$
	ld	hl, #159
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
00104$:
;src\sprites_physics.c:60: sprite_dy[i] = 4;
;c
	ld	hl, #131
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x04
	inc	bc
	ld	a, #0x00
	ld	(bc), a
;src\sprites_physics.c:61: sprite_dz[i] = rand()/32;
;c
	ld	hl, #133
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #163
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #162
	add	hl, sp
	ld	(hl), a
	call	_rand
	ld	a, e
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #159
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00138$
	ld	hl, #0x001f
	add	hl, bc
	push	hl
	ld	a, l
	ld	hl, #161
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #160
	add	hl, sp
	ld	(hl), a
00138$:
	ld	hl, #160
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\sprites_physics.c:62: if (sprite_dz[i]==0) sprite_dz[i] = 1;
	ld	a, b
	or	a, c
	jr	NZ, 00132$
	ld	hl, #161
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
00132$:
;src\sprites_physics.c:52: for (i=0 ; i<sprite_count ; ++i)
	ld	hl, #163
	add	hl, sp
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jp	C, 00131$
;src\sprites_physics.c:65: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\sprites_physics.c:66: enable_interrupts();
	call	_enable_interrupts
;src\sprites_physics.c:72: for (i=0 ; i<sprite_count ; ++i)
00158$:
	xor	a, a
	ld	hl, #159
	add	hl, sp
	ld	(hl), a
00133$:
;src\sprites_physics.c:74: int x = sprite_x[i];
	ld	hl, #159
	add	hl, sp
	ld	a, (hl)
	ld	c, #0x00
	add	a, a
	rl	c
	ld	hl, #162
	add	hl, sp
	ld	(hl+), a
;c
	ld	a, c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #136
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #151
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\sprites_physics.c:75: int y = sprite_y[i];
;c
	ld	hl, #163
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #138
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #153
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\sprites_physics.c:76: int z = sprite_z[i];
;c
	ld	hl, #163
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #140
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #155
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\sprites_physics.c:77: int dx = sprite_dx[i];
;c
	ld	hl, #163
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #142
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #160
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src\sprites_physics.c:78: int dy = sprite_dy[i];
;c
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #130
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #157
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src\sprites_physics.c:79: int dz = sprite_dz[i];
;c
	ld	hl, #163
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #132
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #162
	add	hl, sp
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src\sprites_physics.c:81: if (x+dx<-right || x+dx>right) dx = -dx;
;c
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #151
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, c
	sub	a, #0xe7
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	C, 00108$
	ld	e, b
	ld	d, #0x00
	ld	a, #0x19
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00247$
	bit	7, d
	jr	NZ, 00248$
	cp	a, a
	jr	00248$
00247$:
	bit	7, d
	jr	Z, 00248$
	scf
00248$:
	jr	NC, 00109$
00108$:
	ld	de, #0x0000
	ld	hl, #160
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #161
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
00109$:
;src\sprites_physics.c:82: if (y+dy<bottom) dy = -dy;
;c
	ld	hl, #154
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, c
	sub	a, #0xec
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00112$
	ld	de, #0x0000
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #158
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
00112$:
;src\sprites_physics.c:83: if (y+dy>top) dy = -5;
;c
	ld	hl, #154
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, b
	ld	d, #0x00
	ld	a, #0x0f
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00249$
	bit	7, d
	jr	NZ, 00250$
	cp	a, a
	jr	00250$
00249$:
	bit	7, d
	jr	Z, 00250$
	scf
00250$:
	jr	NC, 00114$
	ld	hl, #157
	add	hl, sp
	ld	a, #0xfb
	ld	(hl+), a
	ld	(hl), #0xff
00114$:
;src\sprites_physics.c:84: if (z+dz<near || z+dz>far) dz = -dz;
;c
	ld	hl, #156
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #162
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, c
	sub	a, #0x14
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00115$
	ld	e, b
	ld	d, #0x00
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00251$
	bit	7, d
	jr	NZ, 00252$
	cp	a, a
	jr	00252$
00251$:
	bit	7, d
	jr	Z, 00252$
	scf
00252$:
	jr	NC, 00116$
00115$:
	ld	de, #0x0000
	ld	hl, #162
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #163
	add	hl, sp
	ld	(hl-), a
	ld	(hl), e
00116$:
;src\sprites_physics.c:86: x += dx;
;c
	ld	hl, #152
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #160
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #144
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\sprites_physics.c:87: y += dy;
;c
	ld	hl, #154
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #157
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #146
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\sprites_physics.c:88: z += dz;
;c
	ld	hl, #156
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #162
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #148
	add	hl, sp
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\sprites_physics.c:90: ++dy;
;c
	ld	hl, #158
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ld	hl, #152
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #151
	add	hl, sp
	ld	(hl), a
;src\sprites_physics.c:92: int px = 160 / 2 + x * 160 / 3 / ((z+20)/2);
	ld	hl, #145
	add	hl, sp
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
	add	hl, hl
	add	hl, hl
	ld	de, #0x0003
	push	de
	push	hl
	call	__divsint
	add	sp, #4
	push	hl
	ld	hl, #159
	add	hl, sp
	ld	(hl), e
	ld	hl, #160
	add	hl, sp
	ld	(hl), d
	pop	hl
;c
	ld	hl, #149
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #154
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #153
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00253$
	bit	7, d
	jr	NZ, 00254$
	cp	a, a
	jr	00254$
00253$:
	bit	7, d
	jr	Z, 00254$
	scf
00254$:
	ld	a, #0x00
	rla
	ld	hl, #154
	add	hl, sp
;c
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ld	hl, #157
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #156
	add	hl, sp
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00139$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00139$:
	sra	b
	rr	c
	push	bc
	ld	hl, #159
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	ld	a, e
	add	a, #0x50
	ld	c, a
;src\sprites_physics.c:93: int py = 144 / 2 + y * 144 / 3 / ((z+20)/2);
	ld	hl, #147
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	de, #0x0003
	push	de
	push	hl
	call	__divsint
	add	sp, #4
	push	hl
	ld	hl, #161
	add	hl, sp
	ld	(hl), e
	ld	hl, #162
	add	hl, sp
	ld	(hl), d
	pop	hl
	pop	bc
	ld	hl, #153
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00140$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00140$:
	sra	d
	rr	e
	push	bc
	push	de
	ld	hl, #161
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	add	a, #0x48
	ld	b, a
;src\sprites_physics.c:97: int s = size_near - (size_near - size_far) * (z-near) / (far-near);
	ld	hl, #149
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #158
	add	hl, sp
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
	add	hl, de
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x008c
	push	de
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, #0x07
	sub	a, e
	ld	hl, #155
	add	hl, sp
	ld	(hl), a
;src\sprites_physics.c:99: if (size != sprite_size[i])
;c
	ld	hl, #135
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #159
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #158
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #157
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ld	hl, #155
	add	hl, sp
	ld	a, (hl)
	ld	hl, #158
	add	hl, sp
	sub	a, (hl)
	jr	Z, 00119$
;src\sprites_physics.c:101: set_sprite_tile(i, 168+size*2);
	ld	hl, #155
	add	hl, sp
	ld	a, (hl)
	add	a, a
	add	a, #0xa8
	ld	e, a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #159
	add	hl, sp
	ld	l, (hl)
	ld	d, #0x00
	ld	h, d
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), e
;src\sprites_physics.c:102: sprite_size[i] = size;
	ld	hl, #157
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	hl
	ld	a, (hl)
	ld	(de), a
00119$:
;src\sprites_physics.c:105: move_sprite(i, px, py);
	ld	hl, #157
	add	hl, sp
	ld	a, b
	ld	(hl+), a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, c
	ld	(hl+), a
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	hl, #157
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\sprites_physics.c:107: sprite_x[i] = x;
	sla	c
	rl	b
	ld	hl, #136
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #144
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\sprites_physics.c:108: sprite_y[i] = y;
	ld	hl, #138
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #146
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\sprites_physics.c:109: sprite_z[i] = z;
	ld	hl, #140
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #148
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\sprites_physics.c:110: sprite_dx[i] = dx;
	ld	hl, #142
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #160
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\sprites_physics.c:111: sprite_dy[i] = dy;
	ld	hl, #130
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #150
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src\sprites_physics.c:112: sprite_dz[i] = dz;			
	ld	hl, #132
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #162
	add	hl, sp
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src\sprites_physics.c:72: for (i=0 ; i<sprite_count ; ++i)
	ld	hl, #159
	add	hl, sp
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jp	C, 00133$
;src\sprites_physics.c:115: wait_vbl_done();
	call	_wait_vbl_done
	jp	00158$
;src\sprites_physics.c:121: }
	add	sp, #127
	add	sp, #37
	ret
___bank_sprites_physics	=	0x0005
	.area _CODE_5
	.area _CABS (ABS)
