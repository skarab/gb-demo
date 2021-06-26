;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module cube
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_CubePhysics
	.globl _Scene_CubePhysics
	.globl _motion_blur_vbl
	.globl b_Scene_Cube
	.globl _Scene_Cube
	.globl _color
	.globl _line
	.globl _plot
	.globl _set_default_palette
	.globl _vmemset
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _add_VBL
	.globl _remove_VBL
	.globl _vbl_y
	.globl _motion_blur_enabled
	.globl _draw_color
	.globl _resources_cube_header_raw_len
	.globl _room_lines_count
	.globl _room_lines
	.globl _palettes2
	.globl _palettes
	.globl _resources_cube_header_raw
	.globl _resources_cube_data_size
	.globl _resources_cube_data
	.globl ___bank_cube
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_resources_cube_header_raw_len::
	.ds 2
_draw_color::
	.ds 1
_motion_blur_enabled::
	.ds 1
_vbl_y::
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
;src\/../resources/cube_header.h:137: unsigned int resources_cube_header_raw_len = 1600;
	ld	hl, #_resources_cube_header_raw_len
	ld	(hl), #0x40
	inc	hl
	ld	(hl), #0x06
;src\cube.c:13: UINT8 draw_color = 1;
	ld	hl, #_draw_color
	ld	(hl), #0x01
;src\cube.c:56: UINT8 motion_blur_enabled = 0;
	ld	hl, #_motion_blur_enabled
	ld	(hl), #0x00
;src\cube.c:57: UINT8 vbl_y = 0;
	ld	hl, #_vbl_y
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_4
;src\cube.c:15: void Scene_Cube() BANKED
;	---------------------------------
; Function Scene_Cube
; ---------------------------------
	b_Scene_Cube	= 4
_Scene_Cube::
	add	sp, #-8
;src\cube.c:19: unsigned int offset = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;src\cube.c:22: LCDC_REG = 0xD1;
	ld	a, #0xd1
	ldh	(_LCDC_REG+0),a
;src\cube.c:23: BGP_REG = PALETTE(CBLACK, CBLACK, CBLACK, CBLACK);
	ld	a, #0xff
	ldh	(_BGP_REG+0),a
;src\cube.c:25: while (1)
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00111$:
;src\cube.c:27: vmemset((void*)(0x8000+(draw_color-1)*1920), 0, 1920);
	ld	a, (#_draw_color)
	ldhl	sp,	#2
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#5
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
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x8000
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #0x0780
	push	hl
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_vmemset
	add	sp, #5
;src\cube.c:28: if (sync>25)
	ldhl	sp,	#6
	ld	a, #0x19
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src\cube.c:30: BGP_REG = palettes2[draw_color-1];
	ld	a, (#_draw_color)
	ldhl	sp,	#5
	ld	(hl), a
	dec	(hl)
	ld	a, (hl-)
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
;c
	ld	de, #_palettes2
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(_BGP_REG+0),a
00102$:
;src\cube.c:32: color(draw_color, 0, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_draw_color)
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src\cube.c:34: ++offset;
	pop	bc
	push	bc
	inc	bc
;src\cube.c:35: UINT8 count = resources_cube_data[offset++];
	ld	e, c
	ld	d, b
	inc	bc
	ld	hl, #_resources_cube_data
	add	hl, de
	ld	e, (hl)
;src\cube.c:36: for (UINT8 i=0 ; i<count ; ++i)
	ld	d, #0x00
00114$:
	ld	a, d
	sub	a, e
	jr	NC, 00124$
;src\cube.c:38: INT8 p0x = cube_x + resources_cube_data[offset];
	ld	hl, #_resources_cube_data
	add	hl, bc
	ld	a, (hl)
	add	a, #0x50
	ldhl	sp,	#3
	ld	(hl), a
;src\cube.c:39: INT8 p0y = cube_y + resources_cube_data[offset+1];
	ld	l, c
	ld	h, b
	inc	hl
	push	de
	ld	de, #_resources_cube_data
	add	hl, de
	pop	de
	ld	a, (hl)
	add	a, #0x48
	ldhl	sp,	#4
	ld	(hl), a
;src\cube.c:40: INT8 p1x = cube_x + resources_cube_data[offset+2];
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	push	de
	ld	de, #_resources_cube_data
	add	hl, de
	pop	de
	ld	a, (hl)
	add	a, #0x50
	ldhl	sp,	#5
	ld	(hl), a
;src\cube.c:41: INT8 p1y = cube_y + resources_cube_data[offset+3];
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	push	de
	ld	de, #_resources_cube_data
	add	hl, de
	pop	de
	ld	a, (hl)
	add	a, #0x48
;src\cube.c:42: line(p0x, p0y, p1x, p1y);
	push	bc
	push	de
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_line
	add	sp, #4
	pop	de
	pop	bc
;src\cube.c:43: offset += 4;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src\cube.c:36: for (UINT8 i=0 ; i<count ; ++i)
	inc	d
	jr	00114$
00124$:
	inc	sp
	inc	sp
	push	bc
;src\cube.c:46: ++draw_color;
	ld	hl, #_draw_color
	inc	(hl)
;src\cube.c:47: if (draw_color & 4) draw_color = 1;
	bit	2, (hl)
	jr	Z, 00105$
	ld	hl, #_draw_color
	ld	(hl), #0x01
00105$:
;src\cube.c:48: if (offset == resources_cube_data_size) offset = 0;
	ld	hl, #_resources_cube_data_size + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00107$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00107$
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
00107$:
;src\cube.c:50: ++sync;
	ldhl	sp,	#6
	inc	(hl)
	jr	NZ, 00154$
	inc	hl
	inc	(hl)
00154$:
;src\cube.c:51: if (sync==174)
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0xae
	inc	hl
	or	a, (hl)
	jp	NZ,00111$
;src\cube.c:52: break;
;src\cube.c:54: }
	add	sp, #8
	ret
___bank_cube	=	0x0004
_resources_cube_data:
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x3b	;  59
	.db #0x24	;  36
	.db #0xfe	; -2
	.db #0x0d	;  13
	.db #0xfe	; -2
	.db #0x0d	;  13
	.db #0xff	; -1
	.db #0xbd	; -67
	.db #0xff	; -1
	.db #0xbd	; -67
	.db #0x2b	;  43
	.db #0xe5	; -27
	.db #0x2b	;  43
	.db #0xe5	; -27
	.db #0x3b	;  59
	.db #0x24	;  36
	.db #0xc5	; -59
	.db #0x25	;  37
	.db #0xfe	; -2
	.db #0x0d	;  13
	.db #0xff	; -1
	.db #0xbd	; -67
	.db #0xd5	; -43
	.db #0xe5	; -27
	.db #0xd5	; -43
	.db #0xe5	; -27
	.db #0xc5	; -59
	.db #0x25	;  37
	.db #0x00	;  0
	.db #0x2e	;  46
	.db #0x3b	;  59
	.db #0x24	;  36
	.db #0xc5	; -59
	.db #0x25	;  37
	.db #0x00	;  0
	.db #0x2e	;  46
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x41	;  65	'A'
	.db #0x1a	;  26
	.db #0xf6	; -10
	.db #0x01	;  1
	.db #0xf6	; -10
	.db #0x01	;  1
	.db #0xf4	; -12
	.db #0xbf	; -65
	.db #0xf4	; -12
	.db #0xbf	; -65
	.db #0x28	;  40
	.db #0xe0	; -32
	.db #0x28	;  40
	.db #0xe0	; -32
	.db #0x41	;  65	'A'
	.db #0x1a	;  26
	.db #0xc9	; -55
	.db #0x2b	;  43
	.db #0xf6	; -10
	.db #0x01	;  1
	.db #0xf4	; -12
	.db #0xbf	; -65
	.db #0xd5	; -43
	.db #0xee	; -18
	.db #0xd5	; -43
	.db #0xee	; -18
	.db #0xc9	; -55
	.db #0x2b	;  43
	.db #0x09	;  9
	.db #0x32	;  50	'2'
	.db #0x41	;  65	'A'
	.db #0x1a	;  26
	.db #0xc9	; -55
	.db #0x2b	;  43
	.db #0x09	;  9
	.db #0x32	;  50	'2'
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x44	;  68	'D'
	.db #0x0e	;  14
	.db #0xeb	; -21
	.db #0xf6	; -10
	.db #0xeb	; -21
	.db #0xf6	; -10
	.db #0xeb	; -21
	.db #0xc3	; -61
	.db #0xeb	; -21
	.db #0xc3	; -61
	.db #0x25	;  37
	.db #0xdd	; -35
	.db #0x25	;  37
	.db #0xdd	; -35
	.db #0x44	;  68	'D'
	.db #0x0e	;  14
	.db #0xcd	; -51
	.db #0x30	;  48	'0'
	.db #0xeb	; -21
	.db #0xf6	; -10
	.db #0xeb	; -21
	.db #0xc3	; -61
	.db #0xd7	; -41
	.db #0xf7	; -9
	.db #0xd7	; -41
	.db #0xf7	; -9
	.db #0xcd	; -51
	.db #0x30	;  48	'0'
	.db #0x12	;  18
	.db #0x35	;  53	'5'
	.db #0x44	;  68	'D'
	.db #0x0e	;  14
	.db #0xcd	; -51
	.db #0x30	;  48	'0'
	.db #0x12	;  18
	.db #0x35	;  53	'5'
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x45	;  69	'E'
	.db #0x01	;  1
	.db #0xe0	; -32
	.db #0xeb	; -21
	.db #0xe0	; -32
	.db #0xeb	; -21
	.db #0xe5	; -27
	.db #0xc9	; -55
	.db #0xe5	; -27
	.db #0xc9	; -55
	.db #0x22	;  34
	.db #0xdb	; -37
	.db #0x22	;  34
	.db #0xdb	; -37
	.db #0x45	;  69	'E'
	.db #0x01	;  1
	.db #0xd0	; -48
	.db #0x34	;  52	'4'
	.db #0xe0	; -32
	.db #0xeb	; -21
	.db #0xe5	; -27
	.db #0xc9	; -55
	.db #0xda	; -38
	.db #0xff	; -1
	.db #0xda	; -38
	.db #0xff	; -1
	.db #0xd0	; -48
	.db #0x34	;  52	'4'
	.db #0x1b	;  27
	.db #0x37	;  55	'7'
	.db #0x45	;  69	'E'
	.db #0x01	;  1
	.db #0xd0	; -48
	.db #0x34	;  52	'4'
	.db #0x1b	;  27
	.db #0x37	;  55	'7'
	.db #0x09	;  9
	.db #0x07	;  7
	.db #0x41	;  65	'A'
	.db #0xf2	; -14
	.db #0xd6	; -42
	.db #0xe3	; -29
	.db #0xd6	; -42
	.db #0xe3	; -29
	.db #0xe3	; -29
	.db #0xd0	; -48
	.db #0xe3	; -29
	.db #0xd0	; -48
	.db #0x1f	;  31
	.db #0xdb	; -37
	.db #0x1f	;  31
	.db #0xdb	; -37
	.db #0x41	;  65	'A'
	.db #0xf2	; -14
	.db #0x23	;  35
	.db #0x38	;  56	'8'
	.db #0x41	;  65	'A'
	.db #0xf2	; -14
	.db #0xd6	; -42
	.db #0xe3	; -29
	.db #0xd2	; -46
	.db #0x36	;  54	'6'
	.db #0xd2	; -46
	.db #0x36	;  54	'6'
	.db #0x23	;  35
	.db #0x38	;  56	'8'
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0x3a	;  58
	.db #0xe4	; -28
	.db #0xce	; -50
	.db #0xde	; -34
	.db #0xce	; -50
	.db #0xde	; -34
	.db #0xe2	; -30
	.db #0xd8	; -40
	.db #0xe2	; -30
	.db #0xd8	; -40
	.db #0x1e	;  30
	.db #0xdb	; -37
	.db #0x1e	;  30
	.db #0xdb	; -37
	.db #0x3a	;  58
	.db #0xe4	; -28
	.db #0x29	;  41
	.db #0x38	;  56	'8'
	.db #0x3a	;  58
	.db #0xe4	; -28
	.db #0xce	; -50
	.db #0xde	; -34
	.db #0xd3	; -45
	.db #0x38	;  56	'8'
	.db #0xd3	; -45
	.db #0x38	;  56	'8'
	.db #0x29	;  41
	.db #0x38	;  56	'8'
	.db #0x07	;  7
	.db #0x04	;  4
	.db #0x2e	;  46
	.db #0x37	;  55	'7'
	.db #0x30	;  48	'0'
	.db #0xd7	; -41
	.db #0x30	;  48	'0'
	.db #0xd7	; -41
	.db #0xc8	; -56
	.db #0xdb	; -37
	.db #0xc8	; -56
	.db #0xdb	; -37
	.db #0xd2	; -46
	.db #0x38	;  56	'8'
	.db #0xd2	; -46
	.db #0x38	;  56	'8'
	.db #0x2e	;  46
	.db #0x37	;  55	'7'
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0x2f	;  47
	.db #0x34	;  52	'4'
	.db #0x24	;  36
	.db #0xcc	; -52
	.db #0x24	;  36
	.db #0xcc	; -52
	.db #0xc6	; -58
	.db #0xdb	; -37
	.db #0xc6	; -58
	.db #0xdb	; -37
	.db #0xd0	; -48
	.db #0x36	;  54	'6'
	.db #0xd0	; -48
	.db #0x36	;  54	'6'
	.db #0x2f	;  47
	.db #0x34	;  52	'4'
	.db #0x04	;  4
	.db #0x07	;  7
	.db #0x19	;  25
	.db #0xc4	; -60
	.db #0x2c	;  44
	.db #0x2e	;  46
	.db #0x2c	;  44
	.db #0x2e	;  46
	.db #0x2b	;  43
	.db #0x1a	;  26
	.db #0x2b	;  43
	.db #0x1a	;  26
	.db #0x20	;  32
	.db #0xe0	; -32
	.db #0x20	;  32
	.db #0xe0	; -32
	.db #0x19	;  25
	.db #0xc4	; -60
	.db #0x19	;  25
	.db #0xc4	; -60
	.db #0xc6	; -58
	.db #0xdd	; -35
	.db #0xc6	; -58
	.db #0xdd	; -35
	.db #0xce	; -50
	.db #0x33	;  51	'3'
	.db #0xce	; -50
	.db #0x33	;  51	'3'
	.db #0x2c	;  44
	.db #0x2e	;  46
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0x0e	;  14
	.db #0xbf	; -65
	.db #0x24	;  36
	.db #0x26	;  38
	.db #0x24	;  36
	.db #0x26	;  38
	.db #0x31	;  49	'1'
	.db #0x1d	;  29
	.db #0x31	;  49	'1'
	.db #0x1d	;  29
	.db #0x22	;  34
	.db #0xe2	; -30
	.db #0x22	;  34
	.db #0xe2	; -30
	.db #0x0e	;  14
	.db #0xbf	; -65
	.db #0x0e	;  14
	.db #0xbf	; -65
	.db #0xc9	; -55
	.db #0xdf	; -33
	.db #0xc9	; -55
	.db #0xdf	; -33
	.db #0xca	; -54
	.db #0x2f	;  47
	.db #0xca	; -54
	.db #0x2f	;  47
	.db #0x24	;  36
	.db #0x26	;  38
	.db #0x07	;  7
	.db #0x09	;  9
	.db #0x16	;  22
	.db #0x1c	;  28
	.db #0xc7	; -57
	.db #0x2b	;  43
	.db #0xc7	; -57
	.db #0x2b	;  43
	.db #0xfc	; -4
	.db #0x29	;  41
	.db #0xfc	; -4
	.db #0x29	;  41
	.db #0x36	;  54	'6'
	.db #0x20	;  32
	.db #0x36	;  54	'6'
	.db #0x20	;  32
	.db #0x16	;  22
	.db #0x1c	;  28
	.db #0x06	;  6
	.db #0xbd	; -67
	.db #0x16	;  22
	.db #0x1c	;  28
	.db #0x36	;  54	'6'
	.db #0x20	;  32
	.db #0x26	;  38
	.db #0xe3	; -29
	.db #0x26	;  38
	.db #0xe3	; -29
	.db #0x06	;  6
	.db #0xbd	; -67
	.db #0x06	;  6
	.db #0xbd	; -67
	.db #0xce	; -50
	.db #0xe2	; -30
	.db #0xce	; -50
	.db #0xe2	; -30
	.db #0xc7	; -57
	.db #0x2b	;  43
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x03	;  3
	.db #0x10	;  16
	.db #0xc5	; -59
	.db #0x26	;  38
	.db #0xc5	; -59
	.db #0x26	;  38
	.db #0x00	;  0
	.db #0x2d	;  45
	.db #0x00	;  0
	.db #0x2d	;  45
	.db #0x3a	;  58
	.db #0x24	;  36
	.db #0x3a	;  58
	.db #0x24	;  36
	.db #0x03	;  3
	.db #0x10	;  16
	.db #0x00	;  0
	.db #0xbd	; -67
	.db #0x03	;  3
	.db #0x10	;  16
	.db #0x3a	;  58
	.db #0x24	;  36
	.db #0x2a	;  42
	.db #0xe5	; -27
	.db #0x2a	;  42
	.db #0xe5	; -27
	.db #0x00	;  0
	.db #0xbd	; -67
	.db #0x00	;  0
	.db #0xbd	; -67
	.db #0xd3	; -45
	.db #0xe5	; -27
	.db #0xd3	; -45
	.db #0xe5	; -27
	.db #0xc5	; -59
	.db #0x26	;  38
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xef	; -17
	.db #0x05	;  5
	.db #0xc5	; -59
	.db #0x21	;  33
	.db #0xc5	; -59
	.db #0x21	;  33
	.db #0x02	;  2
	.db #0x31	;  49	'1'
	.db #0x02	;  2
	.db #0x31	;  49	'1'
	.db #0x3b	;  59
	.db #0x27	;  39
	.db #0x3b	;  59
	.db #0x27	;  39
	.db #0xef	; -17
	.db #0x05	;  5
	.db #0xfd	; -3
	.db #0xbd	; -67
	.db #0xef	; -17
	.db #0x05	;  5
	.db #0x3b	;  59
	.db #0x27	;  39
	.db #0x2f	;  47
	.db #0xe6	; -26
	.db #0x2f	;  47
	.db #0xe6	; -26
	.db #0xfd	; -3
	.db #0xbd	; -67
	.db #0xfd	; -3
	.db #0xbd	; -67
	.db #0xda	; -38
	.db #0xe7	; -25
	.db #0xda	; -38
	.db #0xe7	; -25
	.db #0xc5	; -59
	.db #0x21	;  33
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xdc	; -36
	.db #0xfb	; -5
	.db #0xc6	; -58
	.db #0x1c	;  28
	.db #0xc6	; -58
	.db #0x1c	;  28
	.db #0x04	;  4
	.db #0x35	;  53	'5'
	.db #0x04	;  4
	.db #0x35	;  53	'5'
	.db #0x39	;  57	'9'
	.db #0x2a	;  42
	.db #0x39	;  57	'9'
	.db #0x2a	;  42
	.db #0xdc	; -36
	.db #0xfb	; -5
	.db #0xfb	; -5
	.db #0xbe	; -66
	.db #0xdc	; -36
	.db #0xfb	; -5
	.db #0x39	;  57	'9'
	.db #0x2a	;  42
	.db #0x34	;  52	'4'
	.db #0xe7	; -25
	.db #0x34	;  52	'4'
	.db #0xe7	; -25
	.db #0xfb	; -5
	.db #0xbe	; -66
	.db #0xfb	; -5
	.db #0xbe	; -66
	.db #0xe2	; -30
	.db #0xea	; -22
	.db #0xe2	; -30
	.db #0xea	; -22
	.db #0xc6	; -58
	.db #0x1c	;  28
	.db #0x09	;  9
	.db #0x07	;  7
	.db #0xcd	; -51
	.db #0xf4	; -12
	.db #0xc9	; -55
	.db #0x18	;  24
	.db #0xc9	; -55
	.db #0x18	;  24
	.db #0x04	;  4
	.db #0x38	;  56	'8'
	.db #0x04	;  4
	.db #0x38	;  56	'8'
	.db #0x31	;  49	'1'
	.db #0x2c	;  44
	.db #0x31	;  49	'1'
	.db #0x2c	;  44
	.db #0xcd	; -51
	.db #0xf4	; -12
	.db #0xfb	; -5
	.db #0xc0	; -64
	.db #0xcd	; -51
	.db #0xf4	; -12
	.db #0x31	;  49	'1'
	.db #0x2c	;  44
	.db #0x39	;  57	'9'
	.db #0xe7	; -25
	.db #0x39	;  57	'9'
	.db #0xe7	; -25
	.db #0xfb	; -5
	.db #0xc0	; -64
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0xc4	; -60
	.db #0xef	; -17
	.db #0xcd	; -51
	.db #0x14	;  20
	.db #0xcd	; -51
	.db #0x14	;  20
	.db #0x03	;  3
	.db #0x3a	;  58
	.db #0x03	;  3
	.db #0x3a	;  58
	.db #0x23	;  35
	.db #0x2f	;  47
	.db #0x23	;  35
	.db #0x2f	;  47
	.db #0xc4	; -60
	.db #0xef	; -17
	.db #0xfc	; -4
	.db #0xc1	; -63
	.db #0xc4	; -60
	.db #0xef	; -17
	.db #0x23	;  35
	.db #0x2f	;  47
	.db #0x3d	;  61
	.db #0xe8	; -24
	.db #0x3d	;  61
	.db #0xe8	; -24
	.db #0xfc	; -4
	.db #0xc1	; -63
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0xbf	; -65
	.db #0xeb	; -21
	.db #0xd3	; -45
	.db #0x11	;  17
	.db #0xd3	; -45
	.db #0x11	;  17
	.db #0x02	;  2
	.db #0x3b	;  59
	.db #0x02	;  2
	.db #0x3b	;  59
	.db #0x11	;  17
	.db #0x30	;  48	'0'
	.db #0x11	;  17
	.db #0x30	;  48	'0'
	.db #0xbf	; -65
	.db #0xeb	; -21
	.db #0xfe	; -2
	.db #0xc2	; -62
	.db #0xbf	; -65
	.db #0xeb	; -21
	.db #0x11	;  17
	.db #0x30	;  48	'0'
	.db #0x40	;  64
	.db #0xe9	; -23
	.db #0x40	;  64
	.db #0xe9	; -23
	.db #0xfe	; -2
	.db #0xc2	; -62
	.db #0x07	;  7
	.db #0x09	;  9
	.db #0xbe	; -66
	.db #0xea	; -22
	.db #0xd9	; -39
	.db #0x0d	;  13
	.db #0xd9	; -39
	.db #0x0d	;  13
	.db #0x00	;  0
	.db #0x3b	;  59
	.db #0x00	;  0
	.db #0x3b	;  59
	.db #0xfc	; -4
	.db #0x31	;  49	'1'
	.db #0xfc	; -4
	.db #0x31	;  49	'1'
	.db #0xbe	; -66
	.db #0xea	; -22
	.db #0x00	;  0
	.db #0xc2	; -62
	.db #0xbe	; -66
	.db #0xea	; -22
	.db #0xfc	; -4
	.db #0x31	;  49	'1'
	.db #0x41	;  65	'A'
	.db #0xea	; -22
	.db #0x41	;  65	'A'
	.db #0xea	; -22
	.db #0x00	;  0
	.db #0xc2	; -62
	.db #0x41	;  65	'A'
	.db #0xea	; -22
	.db #0x2a	;  42
	.db #0x0e	;  14
	.db #0x2a	;  42
	.db #0x0e	;  14
	.db #0x00	;  0
	.db #0x3b	;  59
	.db #0x09	;  9
	.db #0x07	;  7
	.db #0x02	;  2
	.db #0xc2	; -62
	.db #0xc0	; -64
	.db #0xe9	; -23
	.db #0xc0	; -64
	.db #0xe9	; -23
	.db #0xe7	; -25
	.db #0x30	;  48	'0'
	.db #0xe7	; -25
	.db #0x30	;  48	'0'
	.db #0x3e	;  62
	.db #0xec	; -20
	.db #0x3e	;  62
	.db #0xec	; -20
	.db #0x02	;  2
	.db #0xc2	; -62
	.db #0x3e	;  62
	.db #0xec	; -20
	.db #0x2f	;  47
	.db #0x11	;  17
	.db #0x2f	;  47
	.db #0x11	;  17
	.db #0xfe	; -2
	.db #0x3b	;  59
	.db #0xfe	; -2
	.db #0x3b	;  59
	.db #0xe7	; -25
	.db #0x30	;  48	'0'
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0x03	;  3
	.db #0xc1	; -63
	.db #0xc4	; -60
	.db #0xe8	; -24
	.db #0xc4	; -60
	.db #0xe8	; -24
	.db #0xd6	; -42
	.db #0x2e	;  46
	.db #0xd6	; -42
	.db #0x2e	;  46
	.db #0x38	;  56	'8'
	.db #0xef	; -17
	.db #0x38	;  56	'8'
	.db #0xef	; -17
	.db #0x03	;  3
	.db #0xc1	; -63
	.db #0x38	;  56	'8'
	.db #0xef	; -17
	.db #0x34	;  52	'4'
	.db #0x15	;  21
	.db #0x34	;  52	'4'
	.db #0x15	;  21
	.db #0xfd	; -3
	.db #0x39	;  57	'9'
	.db #0xfd	; -3
	.db #0x39	;  57	'9'
	.db #0xd6	; -42
	.db #0x2e	;  46
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0x04	;  4
	.db #0xbf	; -65
	.db #0xc9	; -55
	.db #0xe8	; -24
	.db #0xc9	; -55
	.db #0xe8	; -24
	.db #0xcb	; -53
	.db #0x2c	;  44
	.db #0xcb	; -53
	.db #0x2c	;  44
	.db #0x2c	;  44
	.db #0xf5	; -11
	.db #0x2c	;  44
	.db #0xf5	; -11
	.db #0x04	;  4
	.db #0xbf	; -65
	.db #0x2c	;  44
	.db #0xf5	; -11
	.db #0x38	;  56	'8'
	.db #0x19	;  25
	.db #0x38	;  56	'8'
	.db #0x19	;  25
	.db #0xfc	; -4
	.db #0x37	;  55	'7'
	.db #0xfc	; -4
	.db #0x37	;  55	'7'
	.db #0xcb	; -53
	.db #0x2c	;  44
	.db #0x07	;  7
	.db #0x09	;  9
	.db #0x04	;  4
	.db #0xbe	; -66
	.db #0x21	;  33
	.db #0xe9	; -23
	.db #0x21	;  33
	.db #0xe9	; -23
	.db #0x3a	;  58
	.db #0x1d	;  29
	.db #0x3a	;  58
	.db #0x1d	;  29
	.db #0x1c	;  28
	.db #0xfd	; -3
	.db #0x1c	;  28
	.db #0xfd	; -3
	.db #0x04	;  4
	.db #0xbe	; -66
	.db #0x04	;  4
	.db #0xbe	; -66
	.db #0xce	; -50
	.db #0xe7	; -25
	.db #0xce	; -50
	.db #0xe7	; -25
	.db #0xc5	; -59
	.db #0x29	;  41
	.db #0xc5	; -59
	.db #0x29	;  41
	.db #0x1c	;  28
	.db #0xfd	; -3
	.db #0x3a	;  58
	.db #0x1d	;  29
	.db #0xfd	; -3
	.db #0x34	;  52	'4'
	.db #0xfd	; -3
	.db #0x34	;  52	'4'
	.db #0xc5	; -59
	.db #0x29	;  41
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x01	;  1
	.db #0xbd	; -67
	.db #0x28	;  40
	.db #0xe6	; -26
	.db #0x28	;  40
	.db #0xe6	; -26
	.db #0x3b	;  59
	.db #0x22	;  34
	.db #0x3b	;  59
	.db #0x22	;  34
	.db #0x08	;  8
	.db #0x08	;  8
	.db #0x08	;  8
	.db #0x08	;  8
	.db #0x01	;  1
	.db #0xbd	; -67
	.db #0x01	;  1
	.db #0xbd	; -67
	.db #0xd3	; -45
	.db #0xe6	; -26
	.db #0xd3	; -45
	.db #0xe6	; -26
	.db #0xc4	; -60
	.db #0x26	;  38
	.db #0xc4	; -60
	.db #0x26	;  38
	.db #0x08	;  8
	.db #0x08	;  8
	.db #0x3b	;  59
	.db #0x22	;  34
	.db #0xff	; -1
	.db #0x30	;  48	'0'
	.db #0xff	; -1
	.db #0x30	;  48	'0'
	.db #0xc4	; -60
	.db #0x26	;  38
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xfd	; -3
	.db #0xbd	; -67
	.db #0x2e	;  46
	.db #0xe4	; -28
	.db #0x2e	;  46
	.db #0xe4	; -28
	.db #0x3a	;  58
	.db #0x27	;  39
	.db #0x3a	;  58
	.db #0x27	;  39
	.db #0xf4	; -12
	.db #0x13	;  19
	.db #0xf4	; -12
	.db #0x13	;  19
	.db #0xfd	; -3
	.db #0xbd	; -67
	.db #0xfd	; -3
	.db #0xbd	; -67
	.db #0xd7	; -41
	.db #0xe5	; -27
	.db #0xd7	; -41
	.db #0xe5	; -27
	.db #0xc7	; -57
	.db #0x23	;  35
	.db #0xc7	; -57
	.db #0x23	;  35
	.db #0xf4	; -12
	.db #0x13	;  19
	.db #0x3a	;  58
	.db #0x27	;  39
	.db #0x02	;  2
	.db #0x2c	;  44
	.db #0x02	;  2
	.db #0x2c	;  44
	.db #0xc7	; -57
	.db #0x23	;  35
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xf6	; -10
	.db #0xbe	; -66
	.db #0x34	;  52	'4'
	.db #0xe1	; -31
	.db #0x34	;  52	'4'
	.db #0xe1	; -31
	.db #0x37	;  55	'7'
	.db #0x2c	;  44
	.db #0x37	;  55	'7'
	.db #0x2c	;  44
	.db #0xe3	; -29
	.db #0x1f	;  31
	.db #0xe3	; -29
	.db #0x1f	;  31
	.db #0xf6	; -10
	.db #0xbe	; -66
	.db #0xf6	; -10
	.db #0xbe	; -66
	.db #0xdc	; -36
	.db #0xe3	; -29
	.db #0xdc	; -36
	.db #0xe3	; -29
	.db #0xcb	; -53
	.db #0x20	;  32
	.db #0xcb	; -53
	.db #0x20	;  32
	.db #0xe3	; -29
	.db #0x1f	;  31
	.db #0x37	;  55	'7'
	.db #0x2c	;  44
	.db #0x06	;  6
	.db #0x28	;  40
	.db #0x06	;  6
	.db #0x28	;  40
	.db #0xcb	; -53
	.db #0x20	;  32
	.db #0x09	;  9
	.db #0x07	;  7
	.db #0xed	; -19
	.db #0xc1	; -63
	.db #0x37	;  55	'7'
	.db #0xde	; -34
	.db #0x37	;  55	'7'
	.db #0xde	; -34
	.db #0x34	;  52	'4'
	.db #0x30	;  48	'0'
	.db #0x34	;  52	'4'
	.db #0x30	;  48	'0'
	.db #0xd7	; -41
	.db #0x28	;  40
	.db #0xd7	; -41
	.db #0x28	;  40
	.db #0xed	; -19
	.db #0xc1	; -63
	.db #0xed	; -19
	.db #0xc1	; -63
	.db #0xdf	; -33
	.db #0xe1	; -31
	.db #0xdf	; -33
	.db #0xe1	; -31
	.db #0xd1	; -47
	.db #0x1d	;  29
	.db #0xd1	; -47
	.db #0x1d	;  29
	.db #0xd7	; -41
	.db #0x28	;  40
	.db #0x07	;  7
	.db #0x04	;  4
	.db #0xe2	; -30
	.db #0xc6	; -58
	.db #0x39	;  57	'9'
	.db #0xdc	; -36
	.db #0x39	;  57	'9'
	.db #0xdc	; -36
	.db #0x31	;  49	'1'
	.db #0x34	;  52	'4'
	.db #0x31	;  49	'1'
	.db #0x34	;  52	'4'
	.db #0xd0	; -48
	.db #0x30	;  48	'0'
	.db #0xd0	; -48
	.db #0x30	;  48	'0'
	.db #0xe2	; -30
	.db #0xc6	; -58
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0xd6	; -42
	.db #0xcf	; -49
	.db #0x38	;  56	'8'
	.db #0xdb	; -37
	.db #0x38	;  56	'8'
	.db #0xdb	; -37
	.db #0x2e	;  46
	.db #0x36	;  54	'6'
	.db #0x2e	;  46
	.db #0x36	;  54	'6'
	.db #0xcf	; -49
	.db #0x35	;  53	'5'
	.db #0xcf	; -49
	.db #0x35	;  53	'5'
	.db #0xd6	; -42
	.db #0xcf	; -49
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0xcb	; -53
	.db #0xda	; -38
	.db #0x35	;  53	'5'
	.db #0xdb	; -37
	.db #0x35	;  53	'5'
	.db #0xdb	; -37
	.db #0x2d	;  45
	.db #0x38	;  56	'8'
	.db #0x2d	;  45
	.db #0x38	;  56	'8'
	.db #0xd2	; -46
	.db #0x38	;  56	'8'
	.db #0xd2	; -46
	.db #0x38	;  56	'8'
	.db #0xcb	; -53
	.db #0xda	; -38
	.db #0x04	;  4
	.db #0x07	;  7
	.db #0xc2	; -62
	.db #0xe8	; -24
	.db #0x2e	;  46
	.db #0xde	; -34
	.db #0x2e	;  46
	.db #0xde	; -34
	.db #0x2c	;  44
	.db #0x37	;  55	'7'
	.db #0x2c	;  44
	.db #0x37	;  55	'7'
	.db #0xd8	; -40
	.db #0x39	;  57	'9'
	.db #0xd8	; -40
	.db #0x39	;  57	'9'
	.db #0xc2	; -62
	.db #0xe8	; -24
	.db #0xe3	; -29
	.db #0xdb	; -37
	.db #0xc2	; -62
	.db #0xe8	; -24
	.db #0x2e	;  46
	.db #0xde	; -34
	.db #0x1e	;  30
	.db #0xd6	; -42
	.db #0x1e	;  30
	.db #0xd6	; -42
	.db #0xe3	; -29
	.db #0xdb	; -37
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0xbc	; -68
	.db #0xf6	; -10
	.db #0x24	;  36
	.db #0xe5	; -27
	.db #0x24	;  36
	.db #0xe5	; -27
	.db #0x2e	;  46
	.db #0x36	;  54	'6'
	.db #0x2e	;  46
	.db #0x36	;  54	'6'
	.db #0xdf	; -33
	.db #0x38	;  56	'8'
	.db #0xdf	; -33
	.db #0x38	;  56	'8'
	.db #0xbc	; -68
	.db #0xf6	; -10
	.db #0xe1	; -31
	.db #0xdb	; -37
	.db #0xbc	; -68
	.db #0xf6	; -10
	.db #0x24	;  36
	.db #0xe5	; -27
	.db #0x1d	;  29
	.db #0xce	; -50
	.db #0x1d	;  29
	.db #0xce	; -50
	.db #0xe1	; -31
	.db #0xdb	; -37
	.db #0x07	;  7
	.db #0x09	;  9
	.db #0xba	; -70
	.db #0x05	;  5
	.db #0x19	;  25
	.db #0xed	; -19
	.db #0x19	;  25
	.db #0xed	; -19
	.db #0x30	;  48	'0'
	.db #0x33	;  51	'3'
	.db #0x30	;  48	'0'
	.db #0x33	;  51	'3'
	.db #0xe8	; -24
	.db #0x37	;  55	'7'
	.db #0xe8	; -24
	.db #0x37	;  55	'7'
	.db #0xba	; -70
	.db #0x05	;  5
	.db #0x19	;  25
	.db #0xc7	; -57
	.db #0x19	;  25
	.db #0xed	; -19
	.db #0x30	;  48	'0'
	.db #0x33	;  51	'3'
	.db #0x28	;  40
	.db #0xfd	; -3
	.db #0x28	;  40
	.db #0xfd	; -3
	.db #0x19	;  25
	.db #0xc7	; -57
	.db #0xde	; -34
	.db #0xdc	; -36
	.db #0xba	; -70
	.db #0x05	;  5
	.db #0x19	;  25
	.db #0xc7	; -57
	.db #0xde	; -34
	.db #0xdc	; -36
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xbb	; -69
	.db #0x12	;  18
	.db #0x0e	;  14
	.db #0xf8	; -8
	.db #0x0e	;  14
	.db #0xf8	; -8
	.db #0x33	;  51	'3'
	.db #0x2f	;  47
	.db #0x33	;  51	'3'
	.db #0x2f	;  47
	.db #0xf1	; -15
	.db #0x34	;  52	'4'
	.db #0xf1	; -15
	.db #0x34	;  52	'4'
	.db #0xbb	; -69
	.db #0x12	;  18
	.db #0x12	;  18
	.db #0xc2	; -62
	.db #0x0e	;  14
	.db #0xf8	; -8
	.db #0x33	;  51	'3'
	.db #0x2f	;  47
	.db #0x2b	;  43
	.db #0xf5	; -11
	.db #0x2b	;  43
	.db #0xf5	; -11
	.db #0x12	;  18
	.db #0xc2	; -62
	.db #0xdb	; -37
	.db #0xde	; -34
	.db #0xbb	; -69
	.db #0x12	;  18
	.db #0x12	;  18
	.db #0xc2	; -62
	.db #0xdb	; -37
	.db #0xde	; -34
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xc0	; -64
	.db #0x1d	;  29
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0x37	;  55	'7'
	.db #0x29	;  41
	.db #0x37	;  55	'7'
	.db #0x29	;  41
	.db #0xfa	; -6
	.db #0x31	;  49	'1'
	.db #0xfa	; -6
	.db #0x31	;  49	'1'
	.db #0xc0	; -64
	.db #0x1d	;  29
	.db #0x08	;  8
	.db #0xbe	; -66
	.db #0x04	;  4
	.db #0x04	;  4
	.db #0x37	;  55	'7'
	.db #0x29	;  41
	.db #0x2c	;  44
	.db #0xec	; -20
	.db #0x2c	;  44
	.db #0xec	; -20
	.db #0x08	;  8
	.db #0xbe	; -66
	.db #0xd7	; -41
	.db #0xe2	; -30
	.db #0xc0	; -64
	.db #0x1d	;  29
	.db #0x08	;  8
	.db #0xbe	; -66
	.db #0xd7	; -41
	.db #0xe2	; -30
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xc7	; -57
	.db #0x27	;  39
	.db #0xfc	; -4
	.db #0x10	;  16
	.db #0xfc	; -4
	.db #0x10	;  16
	.db #0x3c	;  60
	.db #0x23	;  35
	.db #0x3c	;  60
	.db #0x23	;  35
	.db #0x03	;  3
	.db #0x2d	;  45
	.db #0x03	;  3
	.db #0x2d	;  45
	.db #0xc7	; -57
	.db #0x27	;  39
	.db #0xfc	; -4
	.db #0xbd	; -67
	.db #0xfc	; -4
	.db #0x10	;  16
	.db #0x3c	;  60
	.db #0x23	;  35
	.db #0x2b	;  43
	.db #0xe3	; -29
	.db #0x2b	;  43
	.db #0xe3	; -29
	.db #0xfc	; -4
	.db #0xbd	; -67
	.db #0xd4	; -44
	.db #0xe7	; -25
	.db #0xc7	; -57
	.db #0x27	;  39
	.db #0xfc	; -4
	.db #0xbd	; -67
	.db #0xd4	; -44
	.db #0xe7	; -25
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xd0	; -48
	.db #0x2e	;  46
	.db #0xf8	; -8
	.db #0x1b	;  27
	.db #0xf8	; -8
	.db #0x1b	;  27
	.db #0x40	;  64
	.db #0x1b	;  27
	.db #0x40	;  64
	.db #0x1b	;  27
	.db #0x0b	;  11
	.db #0x29	;  41
	.db #0x0b	;  11
	.db #0x29	;  41
	.db #0xd0	; -48
	.db #0x2e	;  46
	.db #0xee	; -18
	.db #0xbf	; -65
	.db #0xf8	; -8
	.db #0x1b	;  27
	.db #0x40	;  64
	.db #0x1b	;  27
	.db #0x28	;  40
	.db #0xda	; -38
	.db #0x28	;  40
	.db #0xda	; -38
	.db #0xee	; -18
	.db #0xbf	; -65
	.db #0xd2	; -46
	.db #0xed	; -19
	.db #0xd0	; -48
	.db #0x2e	;  46
	.db #0xee	; -18
	.db #0xbf	; -65
	.db #0xd2	; -46
	.db #0xed	; -19
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xda	; -38
	.db #0x34	;  52	'4'
	.db #0xf6	; -10
	.db #0x24	;  36
	.db #0xf6	; -10
	.db #0x24	;  36
	.db #0x43	;  67	'C'
	.db #0x11	;  17
	.db #0x43	;  67	'C'
	.db #0x11	;  17
	.db #0x13	;  19
	.db #0x24	;  36
	.db #0x13	;  19
	.db #0x24	;  36
	.db #0xda	; -38
	.db #0x34	;  52	'4'
	.db #0xe0	; -32
	.db #0xc5	; -59
	.db #0xf6	; -10
	.db #0x24	;  36
	.db #0x43	;  67	'C'
	.db #0x11	;  17
	.db #0x22	;  34
	.db #0xd1	; -47
	.db #0x22	;  34
	.db #0xd1	; -47
	.db #0xe0	; -32
	.db #0xc5	; -59
	.db #0xd1	; -47
	.db #0xf4	; -12
	.db #0xda	; -38
	.db #0x34	;  52	'4'
	.db #0xe0	; -32
	.db #0xc5	; -59
	.db #0xd1	; -47
	.db #0xf4	; -12
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xe5	; -27
	.db #0x38	;  56	'8'
	.db #0xf7	; -9
	.db #0x2a	;  42
	.db #0xf7	; -9
	.db #0x2a	;  42
	.db #0x45	;  69	'E'
	.db #0x07	;  7
	.db #0x45	;  69	'E'
	.db #0x07	;  7
	.db #0x1b	;  27
	.db #0x1e	;  30
	.db #0x1b	;  27
	.db #0x1e	;  30
	.db #0xe5	; -27
	.db #0x38	;  56	'8'
	.db #0xd3	; -45
	.db #0xcd	; -51
	.db #0xf7	; -9
	.db #0x2a	;  42
	.db #0x45	;  69	'E'
	.db #0x07	;  7
	.db #0x1a	;  26
	.db #0xca	; -54
	.db #0x1a	;  26
	.db #0xca	; -54
	.db #0xd3	; -45
	.db #0xcd	; -51
	.db #0xd1	; -47
	.db #0xfb	; -5
	.db #0xe5	; -27
	.db #0x38	;  56	'8'
	.db #0xd3	; -45
	.db #0xcd	; -51
	.db #0xd1	; -47
	.db #0xfb	; -5
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xf0	; -16
	.db #0x3a	;  58
	.db #0xf9	; -7
	.db #0x2f	;  47
	.db #0xf9	; -7
	.db #0x2f	;  47
	.db #0x45	;  69	'E'
	.db #0xfb	; -5
	.db #0x45	;  69	'E'
	.db #0xfb	; -5
	.db #0x21	;  33
	.db #0x17	;  23
	.db #0x21	;  33
	.db #0x17	;  23
	.db #0xf0	; -16
	.db #0x3a	;  58
	.db #0xc8	; -56
	.db #0xd9	; -39
	.db #0xf9	; -7
	.db #0x2f	;  47
	.db #0x45	;  69	'E'
	.db #0xfb	; -5
	.db #0x10	;  16
	.db #0xc5	; -59
	.db #0x10	;  16
	.db #0xc5	; -59
	.db #0xc8	; -56
	.db #0xd9	; -39
	.db #0xd3	; -45
	.db #0x03	;  3
	.db #0xf0	; -16
	.db #0x3a	;  58
	.db #0xc8	; -56
	.db #0xd9	; -39
	.db #0xd3	; -45
	.db #0x03	;  3
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0xfc	; -4
	.db #0x3b	;  59
	.db #0xfd	; -3
	.db #0x31	;  49	'1'
	.db #0xfd	; -3
	.db #0x31	;  49	'1'
	.db #0x42	;  66	'B'
	.db #0xee	; -18
	.db #0x42	;  66	'B'
	.db #0xee	; -18
	.db #0x27	;  39
	.db #0x10	;  16
	.db #0x27	;  39
	.db #0x10	;  16
	.db #0xfc	; -4
	.db #0x3b	;  59
	.db #0xc0	; -64
	.db #0xe5	; -27
	.db #0xfd	; -3
	.db #0x31	;  49	'1'
	.db #0x42	;  66	'B'
	.db #0xee	; -18
	.db #0x04	;  4
	.db #0xc2	; -62
	.db #0x04	;  4
	.db #0xc2	; -62
	.db #0xc0	; -64
	.db #0xe5	; -27
	.db #0xd7	; -41
	.db #0x0b	;  11
	.db #0xfc	; -4
	.db #0x3b	;  59
	.db #0xc0	; -64
	.db #0xe5	; -27
	.db #0xd7	; -41
	.db #0x0b	;  11
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x07	;  7
	.db #0x3b	;  59
	.db #0x01	;  1
	.db #0x30	;  48	'0'
	.db #0x01	;  1
	.db #0x30	;  48	'0'
	.db #0x3d	;  61
	.db #0xe1	; -31
	.db #0x3d	;  61
	.db #0xe1	; -31
	.db #0x2b	;  43
	.db #0x09	;  9
	.db #0x2b	;  43
	.db #0x09	;  9
	.db #0x07	;  7
	.db #0x3b	;  59
	.db #0xbc	; -68
	.db #0xf2	; -14
	.db #0x01	;  1
	.db #0x30	;  48	'0'
	.db #0x3d	;  61
	.db #0xe1	; -31
	.db #0xf8	; -8
	.db #0xc3	; -61
	.db #0xf8	; -8
	.db #0xc3	; -61
	.db #0xbc	; -68
	.db #0xf2	; -14
	.db #0xdb	; -37
	.db #0x12	;  18
	.db #0x07	;  7
	.db #0x3b	;  59
	.db #0xbc	; -68
	.db #0xf2	; -14
	.db #0xdb	; -37
	.db #0x12	;  18
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x13	;  19
	.db #0x3a	;  58
	.db #0x04	;  4
	.db #0x2e	;  46
	.db #0x04	;  4
	.db #0x2e	;  46
	.db #0x34	;  52	'4'
	.db #0xd5	; -43
	.db #0x34	;  52	'4'
	.db #0xd5	; -43
	.db #0x2e	;  46
	.db #0x01	;  1
	.db #0x2e	;  46
	.db #0x01	;  1
	.db #0x13	;  19
	.db #0x3a	;  58
	.db #0xba	; -70
	.db #0xfe	; -2
	.db #0x04	;  4
	.db #0x2e	;  46
	.db #0x34	;  52	'4'
	.db #0xd5	; -43
	.db #0xed	; -19
	.db #0xc6	; -58
	.db #0xed	; -19
	.db #0xc6	; -58
	.db #0xba	; -70
	.db #0xfe	; -2
	.db #0xe1	; -31
	.db #0x19	;  25
	.db #0x13	;  19
	.db #0x3a	;  58
	.db #0xba	; -70
	.db #0xfe	; -2
	.db #0xe1	; -31
	.db #0x19	;  25
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x1e	;  30
	.db #0x37	;  55	'7'
	.db #0x06	;  6
	.db #0x29	;  41
	.db #0x06	;  6
	.db #0x29	;  41
	.db #0x29	;  41
	.db #0xca	; -54
	.db #0x29	;  41
	.db #0xca	; -54
	.db #0x30	;  48	'0'
	.db #0xf9	; -7
	.db #0x30	;  48	'0'
	.db #0xf9	; -7
	.db #0x1e	;  30
	.db #0x37	;  55	'7'
	.db #0xbb	; -69
	.db #0x0a	;  10
	.db #0x06	;  6
	.db #0x29	;  41
	.db #0x29	;  41
	.db #0xca	; -54
	.db #0xe3	; -29
	.db #0xcc	; -52
	.db #0xe3	; -29
	.db #0xcc	; -52
	.db #0xbb	; -69
	.db #0x0a	;  10
	.db #0xe8	; -24
	.db #0x20	;  32
	.db #0x1e	;  30
	.db #0x37	;  55	'7'
	.db #0xbb	; -69
	.db #0x0a	;  10
	.db #0xe8	; -24
	.db #0x20	;  32
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x29	;  41
	.db #0x32	;  50	'2'
	.db #0x06	;  6
	.db #0x22	;  34
	.db #0x06	;  6
	.db #0x22	;  34
	.db #0x1b	;  27
	.db #0xc2	; -62
	.db #0x1b	;  27
	.db #0xc2	; -62
	.db #0x2f	;  47
	.db #0xf2	; -14
	.db #0x2f	;  47
	.db #0xf2	; -14
	.db #0x29	;  41
	.db #0x32	;  50	'2'
	.db #0xbd	; -67
	.db #0x14	;  20
	.db #0x06	;  6
	.db #0x22	;  34
	.db #0x1b	;  27
	.db #0xc2	; -62
	.db #0xdc	; -36
	.db #0xd3	; -45
	.db #0xdc	; -36
	.db #0xd3	; -45
	.db #0xbd	; -67
	.db #0x14	;  20
	.db #0xf0	; -16
	.db #0x25	;  37
	.db #0x29	;  41
	.db #0x32	;  50	'2'
	.db #0xbd	; -67
	.db #0x14	;  20
	.db #0xf0	; -16
	.db #0x25	;  37
	.db #0x09	;  9
	.db #0x09	;  9
	.db #0x32	;  50	'2'
	.db #0x2c	;  44
	.db #0x03	;  3
	.db #0x18	;  24
	.db #0x03	;  3
	.db #0x18	;  24
	.db #0x0d	;  13
	.db #0xbe	; -66
	.db #0x0d	;  13
	.db #0xbe	; -66
	.db #0x2e	;  46
	.db #0xeb	; -21
	.db #0x2e	;  46
	.db #0xeb	; -21
	.db #0x32	;  50	'2'
	.db #0x2c	;  44
	.db #0xc1	; -63
	.db #0x1d	;  29
	.db #0x03	;  3
	.db #0x18	;  24
	.db #0x0d	;  13
	.db #0xbe	; -66
	.db #0xd7	; -41
	.db #0xdc	; -36
	.db #0xd7	; -41
	.db #0xdc	; -36
	.db #0xc1	; -63
	.db #0x1d	;  29
	.db #0xf8	; -8
	.db #0x2a	;  42
	.db #0x32	;  50	'2'
	.db #0x2c	;  44
	.db #0xc1	; -63
	.db #0x1d	;  29
	.db #0xf8	; -8
	.db #0x2a	;  42
_resources_cube_data_size:
	.dw #0x05e2
_resources_cube_header_raw:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0xa9	; 169
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x95	; 149
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0xa6	; 166
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xba	; 186
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xba	; 186
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xae	; 174
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x45	; 69	'E'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x56	; 86	'V'
	.db #0x55	; 85	'U'
	.db #0x15	; 21
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0x99	; 153
	.db #0xa9	; 169
	.db #0xa9	; 169
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xea	; 234
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x95	; 149
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x51	; 81	'Q'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0xa6	; 166
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xba	; 186
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xba	; 186
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x51	; 81	'Q'
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x45	; 69	'E'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xea	; 234
	.db #0x6f	; 111	'o'
	.db #0x66	; 102	'f'
	.db #0xd6	; 214
	.db #0x55	; 85	'U'
	.db #0xf5	; 245
	.db #0x17	; 23
	.db #0x91	; 145
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x6a	; 106	'j'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xde	; 222
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0xd9	; 217
	.db #0x9e	; 158
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x55	; 85	'U'
	.db #0xe4	; 228
	.db #0x46	; 70	'F'
	.db #0xc0	; 192
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x67	; 103	'g'
	.db #0x66	; 102	'f'
	.db #0xd5	; 213
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x11	; 17
	.db #0x91	; 145
	.db #0xbb	; 187
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x64	; 100	'd'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x9a	; 154
	.db #0x59	; 89	'Y'
	.db #0xd5	; 213
	.db #0x57	; 87	'W'
	.db #0xc5	; 197
	.db #0x44	; 68	'D'
	.db #0xc4	; 196
	.db #0xae	; 174
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x98	; 152
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x6b	; 107	'k'
	.db #0x66	; 102	'f'
	.db #0xd6	; 214
	.db #0x57	; 87	'W'
	.db #0xd5	; 213
	.db #0x15	; 21
	.db #0xb1	; 177
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x54	; 84	'T'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x97	; 151
	.db #0xd9	; 217
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x9a	; 154
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x56	; 86	'V'
	.db #0xc4	; 196
	.db #0x44	; 68	'D'
	.db #0xe0	; 224
	.db #0xaa	; 170
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x67	; 103	'g'
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x67	; 103	'g'
	.db #0x66	; 102	'f'
	.db #0xe6	; 230
	.db #0x57	; 87	'W'
	.db #0xd5	; 213
	.db #0x11	; 17
	.db #0xb1	; 177
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x45	; 69	'E'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x9b	; 155
	.db #0xd9	; 217
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x9b	; 155
	.db #0x59	; 89	'Y'
	.db #0xd5	; 213
	.db #0x4f	; 79	'O'
	.db #0x45	; 69	'E'
	.db #0x44	; 68	'D'
	.db #0xec	; 236
	.db #0xae	; 174
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x67	; 103	'g'
	.db #0xea	; 234
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x6b	; 107	'k'
	.db #0x66	; 102	'f'
	.db #0xd6	; 214
	.db #0x5f	; 95
	.db #0x55	; 85	'U'
	.db #0x15	; 21
	.db #0xbd	; 189
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf4	; 244
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xda	; 218
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x5e	; 94
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0xec	; 236
	.db #0xaa	; 170
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe7	; 231
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xd5	; 213
	.db #0x7f	; 127
	.db #0x55	; 85	'U'
	.db #0x11	; 17
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0xaa	; 170
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdb	; 219
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0xd5	; 213
	.db #0x6f	; 111	'o'
	.db #0x45	; 69	'E'
	.db #0x44	; 68	'D'
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xeb	; 235
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0x66	; 102	'f'
	.db #0xd6	; 214
	.db #0x7f	; 127
	.db #0x55	; 85	'U'
	.db #0x15	; 21
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xda	; 218
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0x6e	; 110	'n'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x67	; 103	'g'
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0xe5	; 229
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x91	; 145
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x45	; 69	'E'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x9b	; 155
	.db #0xd9	; 217
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x5b	; 91
	.db #0xd5	; 213
	.db #0xef	; 239
	.db #0x45	; 69	'E'
	.db #0xc4	; 196
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x67	; 103	'g'
	.db #0xea	; 234
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0x6a	; 106	'j'
	.db #0x67	; 103	'g'
	.db #0xd6	; 214
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x54	; 84	'T'
	.db #0xf4	; 244
	.db #0xff	; 255
	.db #0x97	; 151
	.db #0xd9	; 217
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x56	; 86	'V'
	.db #0xd5	; 213
	.db #0xee	; 238
	.db #0x44	; 68	'D'
	.db #0xc4	; 196
	.db #0xee	; 238
	.db #0xea	; 234
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x67	; 103	'g'
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0xd5	; 213
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x91	; 145
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x45	; 69	'E'
	.db #0xf5	; 245
	.db #0xff	; 255
	.db #0x9b	; 155
	.db #0xd9	; 217
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x5b	; 91
	.db #0xd5	; 213
	.db #0xef	; 239
	.db #0x45	; 69	'E'
	.db #0xc4	; 196
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaf	; 175
	.db #0xea	; 234
	.db #0x67	; 103	'g'
	.db #0xd6	; 214
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xde	; 222
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9e	; 158
	.db #0xd9	; 217
	.db #0x56	; 86	'V'
	.db #0xd5	; 213
	.db #0xee	; 238
	.db #0x44	; 68	'D'
	.db #0xc4	; 196
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x98	; 152
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xe6	; 230
	.db #0x67	; 103	'g'
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x91	; 145
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xef	; 239
	.db #0xae	; 174
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0x9e	; 158
	.db #0xd9	; 217
	.db #0x5b	; 91
	.db #0xd5	; 213
	.db #0xef	; 239
	.db #0x45	; 69	'E'
	.db #0xc4	; 196
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x99	; 153
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xaf	; 175
	.db #0xea	; 234
	.db #0x67	; 103	'g'
	.db #0xd6	; 214
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x6a	; 106	'j'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0xa9	; 169
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x95	; 149
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0xa6	; 166
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xba	; 186
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xae	; 174
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x45	; 69	'E'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x56	; 86	'V'
	.db #0x55	; 85	'U'
	.db #0x15	; 21
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x95	; 149
	.db #0x99	; 153
	.db #0xa9	; 169
	.db #0xa9	; 169
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x51	; 81	'Q'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0xa6	; 166
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xba	; 186
	.db #0xba	; 186
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xba	; 186
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x51	; 81	'Q'
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xef	; 239
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xae	; 174
	.db #0xae	; 174
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x9a	; 154
	.db #0x99	; 153
	.db #0x59	; 89	'Y'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x45	; 69	'E'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xbb	; 187
	.db #0xab	; 171
	.db #0xab	; 171
	.db #0xaa	; 170
	.db #0x6a	; 106	'j'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x56	; 86	'V'
	.db #0x55	; 85	'U'
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x01	; 1
_palettes:
	.dw #0x000c
	.dw #0x0030
	.dw #0x00c0
_palettes2:
	.dw #0x00f3
	.dw #0x00cf
	.dw #0x003f
;src\cube.c:59: void motion_blur_vbl()
;	---------------------------------
; Function motion_blur_vbl
; ---------------------------------
_motion_blur_vbl::
;src\cube.c:61: if (motion_blur_enabled)
	ld	a, (#_motion_blur_enabled)
	or	a, a
	jr	Z, 00107$
;src\cube.c:63: if (vbl_y==0)
	ld	a, (#_vbl_y)
	or	a, a
	jr	NZ, 00104$
;src\cube.c:64: set_default_palette();
	call	_set_default_palette
	jr	00107$
00104$:
;src\cube.c:65: else if (vbl_y==40)
	ld	a, (#_vbl_y)
	sub	a, #0x28
	jr	NZ, 00107$
;src\cube.c:66: BGP_REG = palettes[draw_color-1];
	ld	bc, #_palettes+0
	ld	a, (#_draw_color)
	dec	a
	ld	l, a
	rla
	sbc	a, a
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	a, (hl)
	ldh	(_BGP_REG+0),a
00107$:
;src\cube.c:69: ++vbl_y;
	ld	hl, #_vbl_y
	inc	(hl)
;src\cube.c:70: if (vbl_y>=144/8)
	ld	a, (hl)
	sub	a, #0x12
	ret	C
;src\cube.c:71: vbl_y=0;
	ld	(hl), #0x00
;src\cube.c:72: }
	ret
;src\cube.c:92: void Scene_CubePhysics() BANKED
;	---------------------------------
; Function Scene_CubePhysics
; ---------------------------------
	b_Scene_CubePhysics	= 4
_Scene_CubePhysics::
	add	sp, #-30
;src\cube.c:94: LCDC_REG = 0xD1;
	ld	a, #0xd1
	ldh	(_LCDC_REG+0),a
;src\cube.c:96: set_default_palette();
	call	_set_default_palette
;src\cube.c:98: unsigned int offset = 0;
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
;src\cube.c:107: int px = TOINT(0);
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl), a
;src\cube.c:108: int py = TOINT(0);
	xor	a, a
	inc	hl
	ld	(hl+), a
;src\cube.c:109: int pz = TOINT(5);
	ld	(hl+), a
	ld	(hl), #0x64
	xor	a, a
	inc	hl
;src\cube.c:110: int sx = 4;
	ld	(hl+), a
	ld	(hl), #0x04
	xor	a, a
	inc	hl
;src\cube.c:111: int sy = 4;
	ld	(hl+), a
	ld	(hl), #0x04
	xor	a, a
	inc	hl
;src\cube.c:112: int sz = 2;
	ld	(hl+), a
	ld	(hl), #0x02
	xor	a, a
	inc	hl
;src\cube.c:114: INT8 direction = 1;
	ld	(hl+), a
	ld	(hl), #0x01
;src\cube.c:118: UINT8 room_line_id = 0;
	xor	a, a
	inc	hl
	ld	(hl), a
;src\cube.c:120: disable_interrupts();
	call	_disable_interrupts
;src\cube.c:123: }
	di
;src\cube.c:122: add_VBL(motion_blur_vbl);
	ld	hl, #_motion_blur_vbl
	push	hl
	call	_add_VBL
	add	sp, #2
	ei
;src\cube.c:124: enable_interrupts();
	call	_enable_interrupts
;src\cube.c:126: vmemset((void*)0x8000, 0, 1920);
	ld	hl, #0x0780
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl, #0x8000
	push	hl
	call	_vmemset
	add	sp, #5
;src\cube.c:128: while (1)
	xor	a, a
	ldhl	sp,	#26
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl), a
00143$:
;src\cube.c:130: ++sync;
	ldhl	sp,	#27
	inc	(hl)
	jr	NZ, 00305$
	inc	hl
	inc	(hl)
00305$:
;src\cube.c:132: if (sync>100 && logo_y<80)
	ldhl	sp,	#27
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jp	NC, 00105$
	ldhl	sp,	#26
	ld	a, (hl)
	sub	a, #0x50
	jp	NC, 00105$
;src\cube.c:134: UINT8 y = logo_y/2;
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	bit	7, b
	jr	Z, 00156$
	ld	l, c
	ld	h, b
	inc	hl
00156$:
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	ldhl	sp,	#8
	ld	(hl), e
;src\cube.c:136: if (y*2==logo_y)
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sla	e
	rl	d
	ld	a, e
	sub	a, c
	jp	NZ,00103$
	ld	a, d
	sub	a, b
	jp	NZ,00103$
;src\cube.c:137: for (UINT8 x=0 ; x<40 ; ++x)
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
	ld	c, l
	ld	b, h
	ld	e, #0x00
00146$:
	ld	a, e
	sub	a, #0x28
	jp	NC, 00103$
;src\cube.c:139: UINT8 p = resources_cube_header_raw[y*40+x];
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	push	de
	ld	de, #_resources_cube_header_raw
	add	hl, de
	pop	de
	ld	a, (hl)
	ldhl	sp,	#29
	ld	(hl), a
;src\cube.c:140: plot(x * 4, y, (p & 3), SOLID);
	ldhl	sp,	#29
	ld	a, (hl)
	and	a, #0x03
	ld	d, a
	ld	a, e
	add	a, a
	add	a, a
	push	bc
	push	de
	ld	h, #0x00
	ld	l, d
	push	hl
	ldhl	sp,	#14
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_plot
	add	sp, #4
	pop	de
	pop	bc
;src\cube.c:141: plot(x * 4 + 1, y, (p >> 2) & 3, SOLID);
	ldhl	sp,	#29
	ld	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	and	a, #0x03
	ld	l, e
	push	af
	ld	a, l
	add	a, a
	add	a, a
	ldhl	sp,	#11
	ld	(hl), a
	pop	af
	ld	d, (hl)
	inc	d
	push	bc
	push	de
	ld	h, #0x00
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	push	de
	inc	sp
	call	_plot
	add	sp, #4
	pop	de
	pop	bc
;src\cube.c:142: plot(x * 4 + 2, y, (p >> 4) & 3, SOLID);
	ldhl	sp,	#29
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	and	a, #0x03
	ldhl	sp,	#9
	ld	d, (hl)
	inc	d
	inc	d
	push	bc
	push	de
	ld	h, #0x00
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	push	de
	inc	sp
	call	_plot
	add	sp, #4
	pop	de
	pop	bc
;src\cube.c:143: plot(x * 4 + 3, y, (p >> 6) & 3, SOLID);
	ldhl	sp,	#29
	ld	a, (hl)
	rlca
	rlca
	and	a, #0x03
	and	a, #0x03
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	inc	a
	inc	a
	push	bc
	push	de
	ld	h, #0x00
	push	hl
	inc	sp
	ldhl	sp,	#34
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#14
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_plot
	add	sp, #4
	pop	de
	pop	bc
;src\cube.c:137: for (UINT8 x=0 ; x<40 ; ++x)
	inc	e
	jp	00146$
00103$:
;src\cube.c:145: ++logo_y;
	ldhl	sp,	#26
	inc	(hl)
00105$:
;src\cube.c:148: if (sync>300)
	ldhl	sp,	#27
	ld	a, #0x2c
	sub	a, (hl)
	inc	hl
	ld	a, #0x01
	sbc	a, (hl)
	jr	NC, 00108$
;src\cube.c:150: motion_blur_enabled = 1;
	ld	hl, #_motion_blur_enabled
	ld	(hl), #0x01
00108$:
;src\cube.c:153: if (sync>360)
	ldhl	sp,	#27
	ld	a, #0x68
	sub	a, (hl)
	inc	hl
	ld	a, #0x01
	sbc	a, (hl)
	jp	C, 00144$
;src\cube.c:158: if (px+sx<-20 || px+sx>20)
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0xec
	inc	hl
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00309$
	bit	7, d
	jr	NZ, 00310$
	cp	a, a
	jr	00310$
00309$:
	bit	7, d
	jr	Z, 00310$
	scf
00310$:
	jr	C, 00113$
	ldhl	sp,	#8
	ld	a, #0x14
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00311$
	bit	7, d
	jr	NZ, 00312$
	cp	a, a
	jr	00312$
00311$:
	bit	7, d
	jr	Z, 00312$
	scf
00312$:
	jr	NC, 00114$
00113$:
;src\cube.c:160: sx = -sx;
	ld	de, #0x0000
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	ld	(hl), e
;src\cube.c:162: if (sync%8==0)
	ldhl	sp,	#27
	ld	a, (hl)
	and	a, #0x07
	jr	NZ, 00114$
;src\cube.c:164: direction = -direction;
	xor	a, a
	ldhl	sp,	#24
	sub	a, (hl)
	ld	(hl), a
00114$:
;src\cube.c:167: if (py+sy<-18) sy = -sy;
;c
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, c
	sub	a, #0xee
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00117$
	ld	de, #0x0000
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#21
	ld	(hl-), a
	ld	(hl), e
00117$:
;src\cube.c:168: if (py+sy>15) sy = -5;
;c
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#20
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
	jr	Z, 00315$
	bit	7, d
	jr	NZ, 00316$
	cp	a, a
	jr	00316$
00315$:
	bit	7, d
	jr	Z, 00316$
	scf
00316$:
	jr	NC, 00119$
	ldhl	sp,	#20
	ld	a, #0xfb
	ld	(hl+), a
	ld	(hl), #0xff
00119$:
;src\cube.c:169: if (pz+sz<near || pz+sz>far) sz = -sz;
;c
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
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
	jr	C, 00120$
	ld	e, b
	ld	d, #0x00
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00317$
	bit	7, d
	jr	NZ, 00318$
	cp	a, a
	jr	00318$
00317$:
	bit	7, d
	jr	Z, 00318$
	scf
00318$:
	jr	NC, 00121$
00120$:
	ld	de, #0x0000
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#23
	ld	(hl-), a
	ld	(hl), e
00121$:
;src\cube.c:171: px += sx;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
;src\cube.c:172: py += sy;
;c
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
;src\cube.c:173: pz += sz;
;c
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
;src\cube.c:175: ++sy;
	ldhl	sp,	#20
	inc	(hl)
	jr	NZ, 00319$
	inc	hl
	inc	(hl)
00319$:
;src\cube.c:177: int cube_x = 160 / 2 + px * 160 / 3 / ((pz+20)/2);
	ldhl	sp,#12
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
	ldhl	sp,	#6
	ld	(hl), e
	ldhl	sp,	#7
	ld	(hl), d
	pop	hl
;c
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	a, b
	rlca
	and	a,#0x01
	ldhl	sp,	#29
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00157$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), e
00157$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	push	bc
	push	de
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	add	a, #0x50
	ldhl	sp,	#0
	ld	(hl), a
;src\cube.c:178: int cube_y = 144 / 2 + py * 144 / 3 / ((pz+20)/2);
	ldhl	sp,#14
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
	pop	bc
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	Z, 00158$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00158$:
	sra	b
	rr	c
	push	bc
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	add	a, #0x48
	ldhl	sp,	#1
	ld	(hl), a
;src\cube.c:179: int size = size_near - (size_near - size_far) * (pz-near) / (far-near);
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	l, e
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x008c
	push	de
	push	hl
	call	__divsint
	add	sp, #4
	ld	c, e
	ld	b, d
	ld	de, #0x0050
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src\cube.c:181: if (draw_color>1)
	ld	a, #0x01
	ld	hl, #_draw_color
	sub	a, (hl)
	jr	NC, 00124$
;src\cube.c:182: vmemset((void*)(0x8000+(draw_color-1)*1920), 0, 1920);
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
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
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;c
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x8000
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ld	hl, #0x0780
	push	hl
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_vmemset
	add	sp, #5
00124$:
;src\cube.c:184: if (motion_blur_enabled==0)
	ld	a, (#_motion_blur_enabled)
	or	a, a
	jr	NZ, 00126$
;src\cube.c:185: BGP_REG = palettes[draw_color-1];
	ld	a, (#_draw_color)
	ldhl	sp,	#29
	ld	(hl), a
	dec	(hl)
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#9
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
	ld	hl, #_palettes
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(_BGP_REG+0),a
00126$:
;src\cube.c:187: color(draw_color, 0, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_draw_color)
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src\cube.c:188: unsigned int previousOffset = offset;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), e
;src\cube.c:189: UINT8 previousCount = resources_cube_data[offset++];
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #_resources_cube_data
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
;src\cube.c:190: UINT8 count = resources_cube_data[offset++];
	ld	e, c
	ld	d, b
	inc	bc
	ld	hl, #_resources_cube_data
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
;src\cube.c:191: for (UINT8 i=0 ; i<count ; ++i)
	xor	a, a
	ldhl	sp,	#29
	ld	(hl), a
00149$:
	ldhl	sp,	#29
	ld	a, (hl)
	ldhl	sp,	#7
	sub	a, (hl)
	jp	NC, 00188$
;src\cube.c:193: INT8 p0x = (INT8)(cube_x + (int)resources_cube_data[offset] * size / 160);
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #_resources_cube_data
	add	hl, bc
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	push	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__mulint
	add	sp, #4
	ld	hl, #0x00a0
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#11
	add	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;src\cube.c:194: INT8 p0y = (INT8)(cube_y + (int)resources_cube_data[offset+1] * size / 160);
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ld	e, c
	ld	d, b
	inc	de
	ld	hl, #_resources_cube_data
	add	hl, de
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	push	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__mulint
	add	sp, #4
	ld	hl, #0x00a0
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#9
	add	a, (hl)
	inc	hl
	ld	(hl), a
;src\cube.c:195: INT8 p1x = (INT8)(cube_x + (int)resources_cube_data[offset+2] * size / 160);
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	hl, #_resources_cube_data
	add	hl, de
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	push	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__mulint
	add	sp, #4
	ld	hl, #0x00a0
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#11
	add	a, (hl)
	ld	(hl), a
;src\cube.c:196: INT8 p1y = (INT8)(cube_y + (int)resources_cube_data[offset+3] * size / 160);
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ld	hl, #_resources_cube_data
	add	hl, de
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	push	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__mulint
	add	sp, #4
	ld	hl, #0x00a0
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#9
	add	a, (hl)
;src\cube.c:197: line(p0x, p0y, p1x, p1y);
	push	bc
	push	af
	inc	sp
	inc	hl
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_line
	add	sp, #4
	pop	bc
;src\cube.c:198: offset += 4;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src\cube.c:191: for (UINT8 i=0 ; i<count ; ++i)
	ldhl	sp,	#29
	inc	(hl)
	jp	00149$
00188$:
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\cube.c:201: if (sync>180)
	ldhl	sp,	#27
	ld	a, #0xb4
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jp	NC, 00132$
;src\cube.c:203: for (UINT8 r=0 ; r<3 ; ++r)
	xor	a, a
	ldhl	sp,	#29
	ld	(hl), a
00152$:
	ldhl	sp,	#29
	ld	a, (hl)
	sub	a, #0x03
	jp	NC, 00132$
;src\cube.c:205: const UINT8* room = room_lines + room_line_id * 4;
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, #0x02
00321$:
	ldhl	sp,	#2
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00321$
;c
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_room_lines
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
;src\cube.c:206: line(room[0], room[1], room[2], room[3]);
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#3
;c
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	dec	hl
	ld	(hl), a
;c
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#8
	ld	h, (hl)
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_line
	add	sp, #4
;src\cube.c:207: ++room_line_id;
	ldhl	sp,	#25
	inc	(hl)
;src\cube.c:208: if (room_line_id==room_lines_count) room_line_id = 0;
	ld	hl, #_room_lines_count
	ld	c, (hl)
	ldhl	sp,	#25
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00153$
	xor	a, a
	ldhl	sp,	#25
	ld	(hl), a
00153$:
;src\cube.c:203: for (UINT8 r=0 ; r<3 ; ++r)
	ldhl	sp,	#29
	inc	(hl)
	jp	00152$
00132$:
;src\cube.c:214: if (previousOffset==0) previousOffset = resources_cube_data_size;
	ld	hl, #_resources_cube_data_size
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), e
;src\cube.c:212: if (direction==-1)
	ldhl	sp,	#24
	ld	a, (hl)
	inc	a
	jr	NZ, 00138$
;src\cube.c:214: if (previousOffset==0) previousOffset = resources_cube_data_size;
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00134$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), e
00134$:
;src\cube.c:215: offset = previousOffset-previousCount*4-2;
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	a, #0x02
00326$:
	ldhl	sp,	#10
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00326$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	jr	00139$
00138$:
;src\cube.c:217: else if (offset == resources_cube_data_size)
	ldhl	sp,	#8
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	NZ, 00139$
	dec	hl
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	NZ, 00139$
;src\cube.c:219: offset = 0;
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
00139$:
;src\cube.c:222: ++draw_color;
	ld	hl, #_draw_color
	inc	(hl)
;src\cube.c:223: if (draw_color & 4) draw_color = 1;
	bit	2, (hl)
	jp	Z,00143$
	ld	hl, #_draw_color
	ld	(hl), #0x01
	jp	00143$
00144$:
;src\cube.c:226: disable_interrupts();
	call	_disable_interrupts
;src\cube.c:229: }
	di
;src\cube.c:228: remove_VBL(motion_blur_vbl);
	ld	hl, #_motion_blur_vbl
	push	hl
	call	_remove_VBL
	add	sp, #2
	ei
;src\cube.c:230: enable_interrupts();
	call	_enable_interrupts
;src\cube.c:231: }
	add	sp, #30
	ret
_room_lines:
	.db #0x00	; 0
	.db #0x71	; 113	'q'
	.db #0x46	; 70	'F'
	.db #0x4e	; 78	'N'
	.db #0x46	; 70	'F'
	.db #0x27	; 39
	.db #0x46	; 70	'F'
	.db #0x4e	; 78	'N'
	.db #0x46	; 70	'F'
	.db #0x4e	; 78	'N'
	.db #0x5a	; 90	'Z'
	.db #0x4e	; 78	'N'
	.db #0x5a	; 90	'Z'
	.db #0x4e	; 78	'N'
	.db #0x9f	; 159
	.db #0x71	; 113	'q'
	.db #0x5a	; 90	'Z'
	.db #0x27	; 39
	.db #0x5a	; 90	'Z'
	.db #0x4e	; 78	'N'
	.db #0x46	; 70	'F'
	.db #0x27	; 39
	.db #0x5a	; 90	'Z'
	.db #0x27	; 39
_room_lines_count:
	.db #0x05	; 5
	.area _CODE_4
	.area _CABS (ABS)
