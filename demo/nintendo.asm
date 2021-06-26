;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module nintendo
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_Nintendo
	.globl _Scene_Nintendo
	.globl _update_slots
	.globl _get_next_tile
	.globl _init_slots
	.globl _get_bkg_tiles
	.globl _set_bkg_tiles
	.globl _wait_vbl_done
	.globl _tile_y
	.globl _tile_x
	.globl _slots
	.globl ___bank_nintendo
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_slots::
	.ds 50
_tile_x::
	.ds 1
_tile_y::
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
;src\nintendo.c:9: UINT8 tile_x = 0;
	ld	hl, #_tile_x
	ld	(hl), #0x00
;src\nintendo.c:10: UINT8 tile_y = 0;
	ld	hl, #_tile_y
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_1
;src\nintendo.c:12: void init_slots()
;	---------------------------------
; Function init_slots
; ---------------------------------
_init_slots::
	dec	sp
;src\nintendo.c:14: for (UINT8 i=0 ; i<slots_max_count ; ++i)
	xor	a, a
	ldhl	sp,	#0
	ld	(hl), a
00103$:
	ldhl	sp,	#0
;src\nintendo.c:16: slots[i*5+2] = 0;
	ld	a,(hl)
	cp	a,#0x0a
	jr	NC, 00101$
	ld	c, a
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
	inc	a
	inc	a
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	hl, #_slots
	add	hl, de
	ld	(hl), #0x00
;src\nintendo.c:17: slots[i*5+3] = 255;
	ld	a, c
	inc	a
	inc	a
	inc	a
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	hl, #_slots
	add	hl, de
	ld	(hl), #0xff
;src\nintendo.c:18: slots[i*5+4] = i%3+1;
	inc	c
	inc	c
	inc	c
	inc	c
	ld	a, c
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_slots
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, e
	inc	a
	ld	(bc), a
;src\nintendo.c:14: for (UINT8 i=0 ; i<slots_max_count ; ++i)
	ldhl	sp,	#0
	inc	(hl)
	jr	00103$
00101$:
;src\nintendo.c:21: tile_x = 0;
	ld	hl, #_tile_x
	ld	(hl), #0x00
;src\nintendo.c:22: tile_y = 0;
	ld	hl, #_tile_y
	ld	(hl), #0x00
;src\nintendo.c:23: }
	inc	sp
	ret
___bank_nintendo	=	0x0001
;src\nintendo.c:25: UINT8 get_next_tile(UINT8* x, UINT8* y, UINT8* id)
;	---------------------------------
; Function get_next_tile
; ---------------------------------
_get_next_tile::
	dec	sp
;src\nintendo.c:27: while (1)
00108$:
;src\nintendo.c:29: UINT8 tx = tile_x;
	ld	hl, #_tile_x
	ld	c, (hl)
;src\nintendo.c:30: UINT8 ty = tile_y;
	ld	hl, #_tile_y
	ld	b, (hl)
;src\nintendo.c:32: ++tile_x;
	ld	hl, #_tile_x
	inc	(hl)
;src\nintendo.c:33: if (tile_x==160/8)
	ld	a, (hl)
	sub	a, #0x14
	jr	NZ, 00102$
;src\nintendo.c:35: tile_x = 0;
	ld	hl, #_tile_x
	ld	(hl), #0x00
;src\nintendo.c:36: ++tile_y;
	ld	hl, #_tile_y
	inc	(hl)
00102$:
;src\nintendo.c:39: if (tile_y==144/8)
	ld	a, (#_tile_y)
;src\nintendo.c:40: return 0;
	sub	a,#0x12
	jr	NZ, 00104$
	ld	e,a
	jr	00110$
00104$:
;src\nintendo.c:43: get_bkg_tiles(tx, ty, 1, 1, &tileId);
	ldhl	sp,	#0
	push	hl
	ld	de, #0x0101
	push	de
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_get_bkg_tiles
	add	sp, #6
;src\nintendo.c:44: if (tileId!=0)
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00108$
;src\nintendo.c:46: *x = tx;
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	ld	(de), a
;src\nintendo.c:47: *y = ty;
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, b
	ld	(de), a
;src\nintendo.c:48: *id = tileId;
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
;src\nintendo.c:49: return 1;
	ld	e, #0x01
00110$:
;src\nintendo.c:52: }
	inc	sp
	ret
;src\nintendo.c:55: UINT8 update_slots()
;	---------------------------------
; Function update_slots
; ---------------------------------
_update_slots::
	add	sp, #-17
;src\nintendo.c:57: UINT8 usedSlots = 0;
	xor	a, a
	ldhl	sp,	#15
	ld	(hl), a
;src\nintendo.c:59: for (UINT8 i=0 ; i<slots_max_count ; ++i)
	xor	a, a
	inc	hl
	ld	(hl), a
00116$:
	ldhl	sp,	#16
;src\nintendo.c:61: if (slots[i*5+2]==0)
	ld	a,(hl)
	cp	a,#0x0a
	jp	NC,00114$
	ld	c, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#4
	ld	(hl), a
	inc	a
	inc	a
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_slots
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src\nintendo.c:66: slots[i*5+0] = x;
	dec	hl
	dec	hl
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
;src\nintendo.c:67: slots[i*5+1] = y;
	ld	b, (hl)
	inc	b
;src\nintendo.c:69: slots[i*5+3] = 255;
	ld	a, (hl)
	add	a, #0x03
	ldhl	sp,	#14
	ld	(hl), a
;src\nintendo.c:66: slots[i*5+0] = x;
;c
	ld	hl, #_slots
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src\nintendo.c:67: slots[i*5+1] = y;
	ld	a, b
	push	af
	rla
	sbc	a, a
	ld	d, a
	ldhl	sp,	#16
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	b, a
	pop	af
;src\nintendo.c:67: slots[i*5+1] = y;
	push	de
;c
	ld	e, a
	ld	hl, #_slots
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
;src\nintendo.c:69: slots[i*5+3] = 255;
;c
	ld	d, b
	ld	hl, #_slots
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
;src\nintendo.c:61: if (slots[i*5+2]==0)
	ld	a, c
	or	a, a
	jr	NZ, 00104$
;src\nintendo.c:64: if (get_next_tile(&x, &y, &id))
	ldhl	sp,	#2
	ld	a, l
	ld	d, h
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#1
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	push	bc
	call	_get_next_tile
	add	sp, #6
	ld	a, e
	or	a, a
	jr	Z, 00104$
;src\nintendo.c:66: slots[i*5+0] = x;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src\nintendo.c:67: slots[i*5+1] = y;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
;src\nintendo.c:68: slots[i*5+2] = id;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;src\nintendo.c:69: slots[i*5+3] = 255;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xff
;src\nintendo.c:71: UINT8 clear = 0;
	xor	a, a
	ldhl	sp,	#3
	ld	(hl), a
;src\nintendo.c:72: set_bkg_tiles(x, y, 1, 1, &clear);
	ldhl	sp,	#3
	push	hl
	ld	de, #0x0101
	push	de
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\nintendo.c:73: ++usedSlots;
	ldhl	sp,	#15
	inc	(hl)
00104$:
;src\nintendo.c:77: if (slots[i*5+2]!=0)
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	or	a, a
	jp	Z, 00117$
;src\nintendo.c:79: UINT8 x = slots[i*5+0];
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl), a
;src\nintendo.c:80: UINT8 y = slots[i*5+1];
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;src\nintendo.c:81: UINT8 id = slots[i*5+2];
	ldhl	sp,	#2
	ld	(hl), c
;src\nintendo.c:82: UINT8 previousId = slots[i*5+3];
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#3
;src\nintendo.c:83: UINT8 speed = slots[i*5+4];
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	inc	a
	inc	a
	inc	a
	inc	a
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	hl, #_slots
	add	hl, de
	ld	e, (hl)
;src\nintendo.c:85: if (previousId != 255)
	inc	c
	jr	Z, 00106$
;src\nintendo.c:87: set_bkg_tiles(x, y, 1, 1, &previousId);
	ldhl	sp,	#3
	ld	c, l
	ld	d, h
	push	de
	ld	e,c
	push	de
	ld	de, #0x0101
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#21
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
00106$:
;src\nintendo.c:90: y += speed;
	ld	a, e
	add	a, b
	ld	b, a
;src\nintendo.c:73: ++usedSlots;
	ldhl	sp,	#15
	ld	c, (hl)
	inc	c
;src\nintendo.c:91: if (y>=144/8)
	ld	a, b
	sub	a, #0x12
	jr	C, 00110$
;src\nintendo.c:93: slots[i*5+2] = 0;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src\nintendo.c:94: slots[i*5+3] = 255;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xff
;src\nintendo.c:95: ++usedSlots;
	ldhl	sp,	#15
	ld	(hl), c
	jr	00117$
00110$:
;src\nintendo.c:99: get_bkg_tiles(x, y, 1, 1, &previousId);
	ldhl	sp,	#3
	push	hl
	ld	de, #0x0101
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#19
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_tiles
	add	sp, #6
;src\nintendo.c:100: if (previousId==255)
	ldhl	sp,	#3
	ld	a, (hl)
	inc	a
	jr	NZ, 00108$
;src\nintendo.c:101: previousId = 0;
	xor	a, a
	ldhl	sp,	#3
	ld	(hl), a
00108$:
;src\nintendo.c:103: set_bkg_tiles(x, y, 1, 1, &id);
	ldhl	sp,	#2
	push	hl
	ld	de, #0x0101
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#19
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src\nintendo.c:104: slots[i*5+1] = y;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), b
;src\nintendo.c:105: slots[i*5+3] = previousId;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(de), a
;src\nintendo.c:106: ++usedSlots;
	ldhl	sp,	#15
	ld	(hl), c
00117$:
;src\nintendo.c:59: for (UINT8 i=0 ; i<slots_max_count ; ++i)
	ldhl	sp,	#16
	inc	(hl)
	jp	00116$
00114$:
;src\nintendo.c:110: return usedSlots;
	ldhl	sp,	#15
	ld	e, (hl)
;src\nintendo.c:111: }
	add	sp, #17
	ret
;src\nintendo.c:113: void Scene_Nintendo() BANKED
;	---------------------------------
; Function Scene_Nintendo
; ---------------------------------
	b_Scene_Nintendo	= 1
_Scene_Nintendo::
;src\nintendo.c:115: init_slots();
	call	_init_slots
;src\nintendo.c:117: while (1)
00104$:
;src\nintendo.c:119: if (!update_slots())
	call	_update_slots
	ld	a, e
	or	a, a
;src\nintendo.c:120: return;
	ret	Z
;src\nintendo.c:122: wait_vbl_done();
	call	_wait_vbl_done
;src\nintendo.c:124: }
	jr	00104$
	.area _CODE_1
	.area _CABS (ABS)
