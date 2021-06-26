;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module axelay
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_Axelay
	.globl _Scene_Axelay
	.globl _axelay_lcd
	.globl _axelay_vbl
	.globl _rand
	.globl _set_palette
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _add_LCD
	.globl _add_VBL
	.globl _remove_LCD
	.globl _remove_VBL
	.globl _axelay_mod
	.globl _enable_sprites
	.globl _create
	.globl _sprite_id
	.globl _sprite_size
	.globl _sprite_y
	.globl _sprite_x
	.globl _axelay_offset
	.globl _axelay_lines
	.globl _axelay_scroll_y
	.globl _axelay_scroll_x
	.globl _axelay_sprites_tilemap
	.globl _axelay_sprites_tiledata
	.globl _axelay_overlay_tilemap
	.globl _axelay_overlay_tiledata
	.globl _axelay_sky_tilemap
	.globl _axelay_sky_tiledata
	.globl ___bank_axelay
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_axelay_scroll_x::
	.ds 1
_axelay_scroll_y::
	.ds 1
_axelay_lines::
	.ds 144
_axelay_offset::
	.ds 1
_sprite_x::
	.ds 8
_sprite_y::
	.ds 8
_sprite_size::
	.ds 8
_sprite_id::
	.ds 1
_create::
	.ds 1
_enable_sprites::
	.ds 1
_axelay_mod::
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
;src\axelay.c:11: UINT8 axelay_scroll_x = 0;
	ld	hl, #_axelay_scroll_x
	ld	(hl), #0x00
;src\axelay.c:12: UINT8 axelay_scroll_y = 0;
	ld	hl, #_axelay_scroll_y
	ld	(hl), #0x00
;src\axelay.c:14: UINT8 axelay_offset = 0;
	ld	hl, #_axelay_offset
	ld	(hl), #0x00
;src\axelay.c:21: UINT8 sprite_id = 0;
	ld	hl, #_sprite_id
	ld	(hl), #0x00
;src\axelay.c:22: UINT8 create = 0;
	ld	hl, #_create
	ld	(hl), #0x00
;src\axelay.c:23: UINT8 enable_sprites = 0;
	ld	hl, #_enable_sprites
	ld	(hl), #0x00
;src\axelay.c:79: UINT8 axelay_mod = 0;
	ld	hl, #_axelay_mod
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_5
;src\axelay.c:25: void axelay_vbl()
;	---------------------------------
; Function axelay_vbl
; ---------------------------------
_axelay_vbl::
	add	sp, #-8
;src\axelay.c:27: ++axelay_scroll_x;
	ld	hl, #_axelay_scroll_x
	inc	(hl)
;src\axelay.c:28: axelay_scroll_y -= 2;
	ld	hl, #_axelay_scroll_y
	ld	a, (hl)
	add	a, #0xfe
	ld	(hl), a
;src\axelay.c:29: BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	ld	a, #0x00
	ldh	(_BGP_REG+0),a
;src\axelay.c:31: if (enable_sprites)
	ld	a, (#_enable_sprites)
	or	a, a
	jp	Z, 00125$
;src\axelay.c:33: sprite_id = (sprite_id+1)&7;
	ld	hl, #_sprite_id
	ld	a, (hl)
	inc	a
	and	a, #0x07
	ld	(hl), a
;src\axelay.c:34: UINT8 y = sprite_id;
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;src\axelay.c:35: if (sprite_size[y]==255)
;c
	ld	de, #_sprite_size
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	a
	jp	NZ,00115$
;src\axelay.c:37: create = (create+1)&7;
	ld	hl, #_create
	ld	a, (hl)
	inc	a
	and	a, #0x07
	ld	(hl), a
;src\axelay.c:39: if (create==0)
	ld	a, (hl)
	or	a, a
	jp	NZ, 00125$
;src\axelay.c:41: sprite_x[y] = ((UINT8)rand())/4+32;
;c
	ld	de, #_sprite_x
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	call	_rand
	ld	c, e
	ld	b, #0x00
	ld	l, c
	ld	h, b
	bit	7, b
	jr	Z, 00127$
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
00127$:
	sra	h
	rr	l
	sra	h
	rr	l
	ld	a, l
	add	a, #0x20
	ld	c, a
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src\axelay.c:42: sprite_y[y] = 0;
	ld	bc, #_sprite_y+0
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src\axelay.c:43: sprite_size[y] = 0;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#5
	ld	c, (hl)
	ld	b, #0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_shadow_OAM+1+1
	add	hl,bc
	ld	a,h
	ld	(hl), #0xa8
;src\axelay.c:46: if (rand()>0)
	push	bc
	call	_rand
	push	hl
	ldhl	sp,	#11
	ld	(hl), e
	pop	hl
	pop	bc
	ldhl	sp,	#7
	ld	e, (hl)
	ld	d, #0x00
	xor	a, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00188$
	bit	7, d
	jr	NZ, 00189$
	cp	a, a
	jr	00189$
00188$:
	bit	7, d
	jr	Z, 00189$
	scf
00189$:
	jp	NC, 00125$
;D:/prog/gameboy/gbdk/include/gb/gb.h:1201: return shadow_OAM[nb].prop;
	ld	hl,#_shadow_OAM+1+1+1
	add	hl,bc
;src\axelay.c:48: set_sprite_prop(y, get_sprite_prop(y) | S_PALETTE);
	ld	e, (hl)
	set	4, e
;D:/prog/gameboy/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	hl,#_shadow_OAM+1+1+1
	add	hl,bc
	ld	(hl), e
;src\axelay.c:48: set_sprite_prop(y, get_sprite_prop(y) | S_PALETTE);
	jp	00125$
00115$:
;src\axelay.c:54: sprite_y[y] += 6;
	ld	bc, #_sprite_y+0
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	add	a, #0x06
	ld	(bc), a
;src\axelay.c:55: UINT8 yeight = sprite_y[y]/9+1;
	ld	a, (bc)
	ldhl	sp,	#7
	ld	(hl), a
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0009
	push	hl
	push	bc
	call	__divsint
	add	sp, #4
	ld	a, e
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
;src\axelay.c:56: int x = 84+(((int)(sprite_x[y]/2))-35)*2*(1+yeight*yeight/20);
	ld	bc, #_sprite_x+0
	dec	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00128$
	inc	bc
	dec	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00128$:
	ldhl	sp,#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ld	a, c
	add	a, #0xdd
	ld	l, a
	ld	a, b
	adc	a, #0xff
	ld	h, a
	add	hl, hl
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	__muluchar
	add	sp, #2
	push	hl
	ldhl	sp,	#7
	ld	(hl), e
	ldhl	sp,	#8
	ld	(hl), d
	pop	hl
	ld	hl, #0x0014
	push	hl
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	inc	de
	push	de
	push	bc
	call	__mulint
	add	sp, #4
	ld	hl, #0x0054
	add	hl, de
	ld	c, l
	ld	b, h
;src\axelay.c:58: if (sprite_y[y]>=100 || x<8 || x>=160)
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x64
	jr	NC, 00109$
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00109$
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00110$
00109$:
;src\axelay.c:60: sprite_size[y] = 255;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xff
;D:/prog/gameboy/gbdk/include/gb/gb.h:1244: shadow_OAM[nb].y = 0;
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	(hl), #0x00
;src\axelay.c:61: hide_sprite(y);
	jp	00125$
00110$:
;src\axelay.c:65: move_sprite(y, x, sprite_y[y]+32);
	ldhl	sp,	#7
	ld	a, (hl)
	add	a, #0x20
	ld	e, a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	dec	hl
	dec	hl
	ld	a, (hl)
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, a
	rl	b
	inc	hl
	ld	(hl+), a
	ld	(hl), b
	push	de
;c
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
;D:/prog/gameboy/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;src\axelay.c:67: UINT8 size = (yeight*yeight)/16;
	ldhl	sp,#3
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
	jr	Z, 00191$
	bit	7, d
	jr	NZ, 00192$
	cp	a, a
	jr	00192$
00191$:
	bit	7, d
	jr	Z, 00192$
	scf
00192$:
	jr	NC, 00129$
;c
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
00129$:
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#0
	ld	(hl), c
;src\axelay.c:68: if (size>7) size = 7;
	ld	a, #0x07
	sub	a, (hl)
	jr	NC, 00106$
	ld	(hl), #0x07
00106$:
;src\axelay.c:69: if (size != sprite_size[y])
;c
	ld	de, #_sprite_size
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	dec	hl
	dec	hl
	ld	a, (hl)
	sub	a, c
	jr	Z, 00125$
;src\axelay.c:71: set_sprite_tile(y, 168+size*2);
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, a
	add	a, #0xa8
	ldhl	sp,	#3
	ld	(hl), a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(de), a
;src\axelay.c:72: sprite_size[y] = size;
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	hl
	ld	a, (hl)
	ld	(de), a
00125$:
;src\axelay.c:77: }
	add	sp, #8
	ret
___bank_axelay	=	0x0005
_axelay_sky_tiledata:
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xae	; 174
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xbf	; 191
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xfa	; 250
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xab	; 171
	.db #0x51	; 81	'Q'
	.db #0xaf	; 175
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xfe	; 254
	.db #0x51	; 81	'Q'
	.db #0xfe	; 254
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xba	; 186
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x51	; 81	'Q'
	.db #0xaf	; 175
	.db #0xbe	; 190
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xfb	; 251
	.db #0x50	; 80	'P'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfa	; 250
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xfe	; 254
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x51	; 81	'Q'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xfb	; 251
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xba	; 186
	.db #0xea	; 234
	.db #0x51	; 81	'Q'
	.db #0xfe	; 254
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xfe	; 254
	.db #0x51	; 81	'Q'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xfa	; 250
	.db #0x51	; 81	'Q'
	.db #0xfe	; 254
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xab	; 171
	.db #0xfa	; 250
	.db #0x51	; 81	'Q'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xfa	; 250
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xbf	; 191
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0x41	; 65	'A'
	.db #0xbf	; 191
	.db #0xee	; 238
	.db #0xab	; 171
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x50	; 80	'P'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x54	; 84	'T'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xae	; 174
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xbf	; 191
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xeb	; 235
	.db #0xeb	; 235
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x05	; 5
	.db #0xfa	; 250
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x54	; 84	'T'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xeb	; 235
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x45	; 69	'E'
	.db #0xbf	; 191
	.db #0xba	; 186
	.db #0xaf	; 175
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xfa	; 250
	.db #0x55	; 85	'U'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x45	; 69	'E'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xfe	; 254
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xfe	; 254
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xea	; 234
	.db #0xba	; 186
	.db #0xea	; 234
	.db #0x55	; 85	'U'
	.db #0xfa	; 250
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xbf	; 191
	.db #0xaa	; 170
	.db #0xbf	; 191
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x55	; 85	'U'
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_axelay_sky_tilemap:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7a	; 122	'z'
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x7f	; 127
_axelay_overlay_tiledata:
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0x41	; 65	'A'
	.db #0x94	; 148
	.db #0xc9	; 201
	.db #0xb6	; 182
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc5	; 197
	.db #0x3f	; 63
	.db #0x70	; 112	'p'
	.db #0xaf	; 175
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf0	; 240
	.db #0xf4	; 244
	.db #0xf0	; 240
	.db #0xe6	; 230
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc5	; 197
	.db #0xe3	; 227
	.db #0xc1	; 193
	.db #0xe2	; 226
	.db #0xf1	; 241
	.db #0xe2	; 226
	.db #0x70	; 112	'p'
	.db #0xf3	; 243
	.db #0x71	; 113	'q'
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0x0c	; 12
	.db #0x84	; 132
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x29	; 41
	.db #0x00	; 0
	.db #0x45	; 69	'E'
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x8a	; 138
	.db #0x81	; 129
	.db #0x1c	; 28
	.db #0x87	; 135
	.db #0x8f	; 143
	.db #0x9f	; 159
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x43	; 67	'C'
	.db #0x83	; 131
	.db #0xaa	; 170
	.db #0x02	; 2
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x2a	; 42
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x21	; 33
	.db #0x03	; 3
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0xd2	; 210
	.db #0x29	; 41
	.db #0xf8	; 248
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0x87	; 135
	.db #0x8f	; 143
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0x86	; 134
	.db #0x80	; 128
	.db #0x02	; 2
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x88	; 136
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xb0	; 176
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x2b	; 43
	.db #0x01	; 1
	.db #0x11	; 17
	.db #0x39	; 57	'9'
	.db #0x2b	; 43
	.db #0x31	; 49	'1'
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x34	; 52	'4'
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x23	; 35
	.db #0x26	; 38
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xac	; 172
	.db #0x20	; 32
	.db #0xfc	; 252
	.db #0xbc	; 188
	.db #0x2c	; 44
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0xf2	; 242
	.db #0x13	; 19
	.db #0xf1	; 241
	.db #0xf2	; 242
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0x73	; 115	's'
	.db #0xf3	; 243
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xd5	; 213
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0x08	; 8
	.db #0x91	; 145
	.db #0x9b	; 155
	.db #0x99	; 153
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xfd	; 253
	.db #0xfe	; 254
	.db #0xf9	; 249
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0xb0	; 176
	.db #0x08	; 8
	.db #0x98	; 152
	.db #0x01	; 1
	.db #0xb8	; 184
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x9c	; 156
	.db #0xeb	; 235
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0xc3	; 195
	.db #0x28	; 40
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x08	; 8
	.db #0xb6	; 182
	.db #0x49	; 73	'I'
	.db #0xec	; 236
	.db #0xfb	; 251
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0x1f	; 31
	.db #0x40	; 64
	.db #0xb0	; 176
	.db #0x4a	; 74	'J'
	.db #0x1b	; 27
	.db #0x40	; 64
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0x15	; 21
	.db #0x4b	; 75	'K'
	.db #0xb7	; 183
	.db #0x4b	; 75	'K'
	.db #0xac	; 172
	.db #0x53	; 83	'S'
	.db #0x2d	; 45
	.db #0xd2	; 210
	.db #0x86	; 134
	.db #0x50	; 80	'P'
	.db #0xec	; 236
	.db #0x12	; 18
	.db #0x45	; 69	'E'
	.db #0x12	; 18
	.db #0xab	; 171
	.db #0x5f	; 95
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc3	; 195
	.db #0xbc	; 188
	.db #0x8e	; 142
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x35	; 53	'5'
	.db #0xff	; 255
	.db #0x52	; 82	'R'
	.db #0xad	; 173
	.db #0xd8	; 216
	.db #0x25	; 37
	.db #0xe8	; 232
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe4	; 228
	.db #0xc0	; 192
	.db #0xe7	; 231
	.db #0xce	; 206
	.db #0x86	; 134
	.db #0x49	; 73	'I'
	.db #0xdf	; 223
	.db #0x28	; 40
	.db #0xf6	; 246
	.db #0x09	; 9
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x20	; 32
	.db #0x18	; 24
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0xb7	; 183
	.db #0x4a	; 74	'J'
	.db #0x5f	; 95
	.db #0xff	; 255
	.db #0x0b	; 11
	.db #0x61	; 97	'a'
	.db #0x41	; 65	'A'
	.db #0x61	; 97	'a'
	.db #0xe1	; 225
	.db #0x63	; 99	'c'
	.db #0xd1	; 209
	.db #0x63	; 99	'c'
	.db #0x2e	; 46
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0x50	; 80	'P'
	.db #0x2d	; 45
	.db #0xd2	; 210
	.db #0xf4	; 244
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0x81	; 129
	.db #0x9f	; 159
	.db #0x9f	; 159
	.db #0x8b	; 139
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0x94	; 148
	.db #0x3b	; 59
	.db #0x84	; 132
	.db #0x6a	; 106	'j'
	.db #0x95	; 149
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xd8	; 216
	.db #0x25	; 37
	.db #0x1e	; 30
	.db #0xa1	; 161
	.db #0xcb	; 203
	.db #0x35	; 53	'5'
	.db #0x60	; 96
	.db #0xf9	; 249
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x22	; 34
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x5c	; 92
	.db #0xab	; 171
	.db #0xf6	; 246
	.db #0x09	; 9
	.db #0xd4	; 212
	.db #0x2b	; 43
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x98	; 152
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0xa1	; 161
	.db #0x5f	; 95
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x98	; 152
	.db #0x89	; 137
	.db #0x10	; 16
	.db #0x88	; 136
	.db #0x10	; 16
	.db #0x80	; 128
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0x1f	; 31
	.db #0x6b	; 107	'k'
	.db #0x94	; 148
	.db #0xab	; 171
	.db #0x14	; 20
	.db #0x17	; 23
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xf4	; 244
	.db #0x2a	; 42
	.db #0x05	; 5
	.db #0x18	; 24
	.db #0x25	; 37
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xaf	; 175
	.db #0xd8	; 216
	.db #0x25	; 37
	.db #0x03	; 3
	.db #0x20	; 32
	.db #0x22	; 34
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x38	; 56	'8'
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x2b	; 43
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0x3f	; 63
	.db #0xb4	; 180
	.db #0x48	; 72	'H'
	.db #0xe4	; 228
	.db #0x18	; 24
	.db #0xbc	; 188
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xfa	; 250
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x0b	; 11
	.db #0xf3	; 243
	.db #0x53	; 83	'S'
	.db #0xf1	; 241
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf4	; 244
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x2b	; 43
	.db #0xd4	; 212
	.db #0x2d	; 45
	.db #0xd2	; 210
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x99	; 153
	.db #0x19	; 25
	.db #0x39	; 57	'9'
	.db #0x19	; 25
	.db #0x79	; 121	'y'
	.db #0x39	; 57	'9'
	.db #0x81	; 129
	.db #0xfe	; 254
	.db #0x63	; 99	'c'
	.db #0x94	; 148
	.db #0x4b	; 75	'K'
	.db #0xb4	; 180
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0x38	; 56	'8'
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x88	; 136
	.db #0x98	; 152
	.db #0xd8	; 216
	.db #0x88	; 136
	.db #0xaf	; 175
	.db #0xff	; 255
	.db #0xda	; 218
	.db #0x25	; 37
	.db #0x5e	; 94
	.db #0xa1	; 161
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0x7f	; 127
	.db #0xd3	; 211
	.db #0x2f	; 47
	.db #0x76	; 118	'v'
	.db #0x09	; 9
	.db #0xf7	; 247
	.db #0xfa	; 250
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xa1	; 161
	.db #0x5f	; 95
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_axelay_overlay_tilemap:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
_axelay_sprites_tiledata:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x38	; 56	'8'
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
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x18	; 24
	.db #0x7c	; 124
	.db #0x38	; 56	'8'
	.db #0x7c	; 124
	.db #0x30	; 48	'0'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x18	; 24
	.db #0x7c	; 124
	.db #0x38	; 56	'8'
	.db #0x7c	; 124
	.db #0x30	; 48	'0'
	.db #0x7c	; 124
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x1c	; 28
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
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
	.db #0x3c	; 60
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
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
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
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x1c	; 28
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
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x34	; 52	'4'
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_axelay_sprites_tilemap:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
;src\axelay.c:80: void axelay_lcd()
;	---------------------------------
; Function axelay_lcd
; ---------------------------------
_axelay_lcd::
	add	sp, #-5
;src\axelay.c:82: UINT8 y = LY_REG;
	ldh	a, (_LY_REG+0)
	ldhl	sp,	#0
	ld	(hl), a
;src\axelay.c:84: if (y<144-axelay_offset)
	ld	a, (#_axelay_offset)
	ldhl	sp,	#1
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	de, #0x0090
	dec	hl
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
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00142$
	bit	7, d
	jr	NZ, 00143$
	cp	a, a
	jr	00143$
00142$:
	bit	7, d
	jr	Z, 00143$
	scf
00143$:
	jr	NC, 00102$
;src\axelay.c:86: SCX_REG = axelay_scroll_x+sintable[y+axelay_scroll_x&127];
	ld	hl, #_axelay_scroll_x
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	res	7, c
	ld	b, #0x00
	ld	hl, #_sintable
	add	hl, bc
	ld	a, (hl)
	ld	hl, #_axelay_scroll_x
	add	a, (hl)
	ldh	(_SCX_REG+0),a
;src\axelay.c:87: SCY_REG = axelay_scroll_y+axelay_lines[y+axelay_offset];
;c
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	bc,#_axelay_lines
	add	hl,bc
	ld	a, (hl)
	ld	hl, #_axelay_scroll_y
	add	a, (hl)
	ldh	(_SCY_REG+0),a
	jr	00103$
00102$:
;src\axelay.c:91: SCX_REG = 0;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
;src\axelay.c:92: SCY_REG = 0;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
00103$:
;src\axelay.c:95: if (y<=4) BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CSILVER);
	ld	a, #0x04
	ldhl	sp,	#0
	sub	a, (hl)
	jr	C, 00113$
	ld	a, #0x40
	ldh	(_BGP_REG+0),a
	jr	00115$
00113$:
;src\axelay.c:96: else if (y<=8) BGP_REG = PALETTE(CWHITE, CWHITE, CSILVER, CGRAY);
	ld	a, #0x08
	ldhl	sp,	#0
	sub	a, (hl)
	jr	C, 00110$
	ld	a, #0x90
	ldh	(_BGP_REG+0),a
	jr	00115$
00110$:
;src\axelay.c:97: else if (y<=30) BGP_REG = PALETTE(CWHITE, CSILVER, CGRAY, CBLACK);
	ld	a, #0x1e
	ldhl	sp,	#0
	sub	a, (hl)
	jr	C, 00107$
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
	jr	00115$
00107$:
;src\axelay.c:98: else if (y>=143) BGP_REG = PALETTE(CWHITE, CWHITE, CWHITE, CWHITE);
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x8f
	jr	C, 00115$
	ld	a, #0x00
	ldh	(_BGP_REG+0),a
00115$:
;src\axelay.c:99: }
	add	sp, #5
	ret
;src\axelay.c:101: void Scene_Axelay() BANKED
;	---------------------------------
; Function Scene_Axelay
; ---------------------------------
	b_Scene_Axelay	= 5
_Scene_Axelay::
	add	sp, #-7
;src\axelay.c:105: disable_interrupts();
	call	_disable_interrupts
;src\axelay.c:106: DISPLAY_OFF;
	call	_display_off
;src\axelay.c:108: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;src\axelay.c:109: set_palette(PALETTE(CWHITE, CSILVER, CGRAY, CBLACK));
	ld	hl, #0x00e4
	push	hl
	call	_set_palette
	add	sp, #2
;src\axelay.c:110: set_bkg_data(0, 128, axelay_sky_tiledata);
	ld	hl, #_axelay_sky_tiledata
	push	hl
	ld	a, #0x80
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src\axelay.c:111: set_bkg_tiles(0, 0, 16, 8, axelay_sky_tilemap);
	ld	bc, #_axelay_sky_tilemap+0
	push	bc
	ld	de, #0x0810
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:112: set_bkg_tiles(0, 8, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	ld	a, #0x08
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:113: set_bkg_tiles(16, 0, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x10
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:114: set_bkg_tiles(16, 8, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	ld	de, #0x0810
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:115: set_bkg_tiles(0, 16, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:116: set_bkg_tiles(0, 24, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	ld	a, #0x18
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:117: set_bkg_tiles(16, 16, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	ld	de, #0x1010
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:118: set_bkg_tiles(16, 24, 16, 8, axelay_sky_tilemap);
	push	bc
	ld	de, #0x0810
	push	de
	ld	de, #0x1810
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src\axelay.c:120: set_win_data(128, 40, axelay_overlay_tiledata);
	ld	hl, #_axelay_overlay_tiledata
	push	hl
	ld	de, #0x2880
	push	de
	call	_set_win_data
	add	sp, #4
;src\axelay.c:121: for (y=0 ; y<40 ; ++y)
	xor	a, a
	ldhl	sp,	#6
	ld	(hl), a
00120$:
;src\axelay.c:123: UINT8 tile_id = y+128;
	ldhl	sp,	#6
	ld	a, (hl)
	add	a, #0x80
	ldhl	sp,	#2
	ld	(hl), a
;src\axelay.c:124: set_win_tiles(y%20, y/20, 1, 1, &tile_id);
	ldhl	sp,	#2
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	hl, #0x0014
	push	hl
	push	bc
	call	__divsint
	add	sp, #4
	pop	bc
	push	de
	ld	hl, #0x0014
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	ld	b, e
	ld	c, d
	pop	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ld	d, #0x01
	push	de
	push	bc
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;src\axelay.c:121: for (y=0 ; y<40 ; ++y)
	ldhl	sp,	#6
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x28
	jr	C, 00120$
;D:/prog/gameboy/gbdk/include/gb/gb.h:1015: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG+0),a
	ld	a, #0x90
	ldh	(_WY_REG+0),a
;src\axelay.c:128: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src\axelay.c:129: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
;src\axelay.c:131: SPRITES_8x16;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x04
	ldh	(_LCDC_REG+0),a
;src\axelay.c:132: for (y=0 ; y<8 ; ++y)
	ld	c, #0x00
00122$:
;src\axelay.c:134: set_sprite_data(168+y*2, 1, axelay_sprites_tiledata+y*16);
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
;src\axelay.c:135: set_sprite_data(168+y*2+1, 1, axelay_sprites_tiledata+y*16+16*8);
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
;src\axelay.c:132: for (y=0 ; y<8 ; ++y)
	inc	c
	ld	a, c
	sub	a, #0x08
	jr	C, 00122$
;src\axelay.c:137: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src\axelay.c:139: for (y=0 ; y<sprite_count ; ++y)
	ld	bc, #_sprite_size+0
	ld	e, #0x00
00124$:
;src\axelay.c:141: sprite_size[y] = 255;
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	(hl), #0xff
;src\axelay.c:139: for (y=0 ; y<sprite_count ; ++y)
	inc	e
	ld	a, e
	sub	a, #0x08
	jr	C, 00124$
;src\axelay.c:145: for (y=0 ; y<144 ; ++y)
	xor	a, a
	ldhl	sp,	#6
	ld	(hl), a
00126$:
;src\axelay.c:149: UINT16 decay = sin_limit-y;
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src\axelay.c:147: if (y<sin_limit)
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x58
	jr	NC, 00105$
;src\axelay.c:149: UINT16 decay = sin_limit-y;
	ld	de, #0x0058
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
;src\axelay.c:150: axelay_lines[y] = sintable[144-sin_limit]/10 - decay*decay / 20;
;c
	ld	de, #_axelay_lines
	ldhl	sp,	#6
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#(_sintable + 0x0038) + 0)
	ld	e, a
	ld	d, #0x00
	push	bc
	ld	hl, #0x000a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#5
	ld	(hl), e
	push	bc
	push	bc
	call	__mulint
	add	sp, #4
	ld	hl, #0x0014
	push	hl
	push	de
	call	__divuint
	add	sp, #4
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, e
	ld	c, a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	jr	00127$
00105$:
;src\axelay.c:154: axelay_lines[y] = sintable[144-y]/10;
;c
	ld	de, #_axelay_lines
	ldhl	sp,	#6
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	de, #0x0090
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ld	hl, #_sintable
	add	hl, bc
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x000a
	push	hl
	push	bc
	call	__divsint
	add	sp, #4
	ld	c, e
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
00127$:
;src\axelay.c:145: for (y=0 ; y<144 ; ++y)
	ldhl	sp,	#6
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x90
	jp	C, 00126$
;src\axelay.c:162: }
	di
;src\axelay.c:159: STAT_REG = 0x18;
	ld	a, #0x18
	ldh	(_STAT_REG+0),a
;src\axelay.c:160: add_VBL(axelay_vbl);
	ld	hl, #_axelay_vbl
	push	hl
	call	_add_VBL
	add	sp, #2
;src\axelay.c:161: add_LCD(axelay_lcd);
	ld	hl, #_axelay_lcd
	push	hl
	call	_add_LCD
	add	sp, #2
	ei
;src\axelay.c:163: set_interrupts(LCD_IFLAG | VBL_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src\axelay.c:165: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\axelay.c:166: enable_interrupts();
	call	_enable_interrupts
;src\axelay.c:170: while (1)
	ld	bc, #0x0000
00116$:
;src\axelay.c:172: ++time;
	inc	bc
;src\axelay.c:174: if (time>200 && axelay_offset<16)
	ld	e, b
	ld	d, #0x00
	ld	a, #0xc8
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00207$
	bit	7, d
	jr	NZ, 00208$
	cp	a, a
	jr	00208$
00207$:
	bit	7, d
	jr	Z, 00208$
	scf
00208$:
	jr	NC, 00109$
	ld	hl, #_axelay_offset
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00109$
;src\axelay.c:176: ++axelay_offset;
	inc	(hl)
;src\axelay.c:177: move_win(7, 144-axelay_offset);
	ld	e, (hl)
	ld	a, #0x90
	sub	a, e
	ld	e, a
;D:/prog/gameboy/gbdk/include/gb/gb.h:1015: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG+0),a
	ld	a, e
	ldh	(_WY_REG+0),a
;src\axelay.c:177: move_win(7, 144-axelay_offset);
00109$:
;src\axelay.c:180: if (time>300)
	ld	e, b
	ld	d, #0x01
	ld	a, #0x2c
	cp	a, c
	ld	a, #0x01
	sbc	a, b
	bit	7, e
	jr	Z, 00209$
	bit	7, d
	jr	NZ, 00210$
	cp	a, a
	jr	00210$
00209$:
	bit	7, d
	jr	Z, 00210$
	scf
00210$:
	jr	NC, 00112$
;src\axelay.c:181: enable_sprites = 1;
	ld	hl, #_enable_sprites
	ld	(hl), #0x01
00112$:
;src\axelay.c:183: wait_vbl_done();	
	call	_wait_vbl_done
;src\axelay.c:185: if (time>500)
	ld	e, b
	ld	d, #0x01
	ld	a, #0xf4
	cp	a, c
	ld	a, #0x01
	sbc	a, b
	bit	7, e
	jr	Z, 00211$
	bit	7, d
	jr	NZ, 00212$
	cp	a, a
	jr	00212$
00211$:
	bit	7, d
	jr	Z, 00212$
	scf
00212$:
	jr	NC, 00116$
;src\axelay.c:189: disable_interrupts();
	call	_disable_interrupts
;src\axelay.c:190: DISPLAY_OFF;
	call	_display_off
;src\axelay.c:197: }
	di
;src\axelay.c:193: remove_LCD(axelay_vbl);
	ld	hl, #_axelay_vbl
	push	hl
	call	_remove_LCD
	add	sp, #2
;src\axelay.c:194: remove_VBL(axelay_lcd);
	ld	hl, #_axelay_lcd
	push	hl
	call	_remove_VBL
	add	sp, #2
;src\axelay.c:195: SCX_REG = 0;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
;src\axelay.c:196: STAT_REG = 0x44;
	ld	a, #0x44
	ldh	(_STAT_REG+0),a
	ei
;src\axelay.c:199: set_interrupts(LCD_IFLAG | VBL_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src\axelay.c:200: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\axelay.c:201: enable_interrupts();
	call	_enable_interrupts
;src\axelay.c:202: }
	add	sp, #7
	ret
	.area _CODE_5
	.area _CABS (ABS)
