;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module fire
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_Scene_Fire
	.globl _Scene_Fire
	.globl _fire_lcd
	.globl _rand
	.globl _set_palette
	.globl _set_bkg_data
	.globl _get_bkg_xy_addr
	.globl _display_off
	.globl _fire_wind
	.globl _fire_scanline_offsets
	.globl _fire_scanline_offsets_tbl
	.globl _fire_tiles_tilemap
	.globl _fire_tiles_tiledata
	.globl ___bank_fire
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_fire_scanline_offsets::
	.ds 2
_fire_wind::
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
;src\fire.c:9: const INT8 * fire_scanline_offsets = fire_scanline_offsets_tbl;
	ld	hl, #_fire_scanline_offsets
	ld	(hl), #<(_fire_scanline_offsets_tbl)
	inc	hl
	ld	(hl), #>(_fire_scanline_offsets_tbl)
;src\fire.c:10: UINT8 fire_wind = 0;
	ld	hl, #_fire_wind
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
;src\fire.c:12: void fire_lcd()
;	---------------------------------
; Function fire_lcd
; ---------------------------------
_fire_lcd::
;src\fire.c:14: UINT8 y = LY_REG;
	ldh	a, (_LY_REG+0)
;src\fire.c:15: INT8 offset = (fire_scanline_offsets[y & (UBYTE)7]+1)*2;
	ld	c, a
	and	a, #0x07
	ld	b, a
	ld	hl, #_fire_scanline_offsets
	ld	a, (hl)
	add	a, b
	ld	e, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	inc	a
	add	a, a
	ld	e, a
;src\fire.c:17: if (y<=40)
	ld	a, #0x28
	sub	a, c
	jr	C, 00102$
;src\fire.c:19: SCX_REG = 0;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
	ret
00102$:
;src\fire.c:23: SCX_REG = offset * (123-y)/(12+fire_wind);
	ld	b, #0x00
	ld	a, #0x7b
	sub	a, c
	ld	c, a
	ld	a, #0x00
	sbc	a, b
	ld	b, a
	ld	a, e
	rla
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	call	__mulint
	add	sp, #4
	ld	hl, #_fire_wind
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x000c
	add	hl, bc
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	ldh	(_SCX_REG+0),a
;src\fire.c:25: }
	ret
___bank_fire	=	0x0004
_fire_tiles_tiledata:
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
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xfd	; 253
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
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x11	; 17
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0xee	; 238
	.db #0x11	; 17
	.db #0xdd	; 221
	.db #0x22	; 34
	.db #0xee	; 238
	.db #0x11	; 17
	.db #0x5f	; 95
	.db #0xa0	; 160
	.db #0xeb	; 235
	.db #0x14	; 20
	.db #0xf5	; 245
	.db #0x0a	; 10
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x0a	; 10
	.db #0xf5	; 245
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x20	; 32
	.db #0xdf	; 223
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
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x22	; 34
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x8a	; 138
	.db #0xff	; 255
	.db #0x45	; 69	'E'
	.db #0xff	; 255
	.db #0x22	; 34
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xff	; 255
	.db #0x22	; 34
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x6d	; 109	'm'
	.db #0xff	; 255
	.db #0x92	; 146
	.db #0xff	; 255
	.db #0x6d	; 109	'm'
	.db #0xff	; 255
	.db #0x92	; 146
	.db #0xff	; 255
	.db #0x6d	; 109	'm'
	.db #0xff	; 255
	.db #0x92	; 146
	.db #0xff	; 255
	.db #0x6d	; 109	'm'
	.db #0xff	; 255
	.db #0x92	; 146
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
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0x75	; 117	'u'
	.db #0x75	; 117	'u'
	.db #0x20	; 32
	.db #0xad	; 173
	.db #0x20	; 32
	.db #0x24	; 36
	.db #0x89	; 137
	.db #0x8c	; 140
	.db #0x89	; 137
	.db #0xdd	; 221
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xed	; 237
	.db #0x16	; 22
	.db #0x76	; 118	'v'
	.db #0x04	; 4
	.db #0x36	; 54	'6'
	.db #0x64	; 100	'd'
	.db #0x36	; 54	'6'
	.db #0x04	; 4
	.db #0xd6	; 214
	.db #0x84	; 132
	.db #0x21	; 33
	.db #0x10	; 16
	.db #0x3b	; 59
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xeb	; 235
	.db #0xdd	; 221
	.db #0xcd	; 205
	.db #0x89	; 137
	.db #0xad	; 173
	.db #0x89	; 137
	.db #0x0d	; 13
	.db #0xa1	; 161
	.db #0x85	; 133
	.db #0x01	; 1
	.db #0x74	; 116	't'
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xf1	; 241
	.db #0xf3	; 243
	.db #0xe0	; 224
	.db #0xf1	; 241
	.db #0xe6	; 230
	.db #0xf3	; 243
	.db #0xe0	; 224
	.db #0xf7	; 247
	.db #0xe6	; 230
	.db #0x71	; 113	'q'
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x68	; 104	'h'
	.db #0x6c	; 108	'l'
	.db #0x20	; 32
	.db #0x0e	; 14
	.db #0x24	; 36
	.db #0x4e	; 78	'N'
	.db #0x04	; 4
	.db #0x4e	; 78	'N'
	.db #0x44	; 68	'D'
	.db #0x6e	; 110	'n'
	.db #0x44	; 68	'D'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x04	; 4
	.db #0x4c	; 76	'L'
	.db #0x00	; 0
	.db #0xc4	; 196
	.db #0x99	; 153
	.db #0xcc	; 204
	.db #0x80	; 128
	.db #0xdd	; 221
	.db #0x98	; 152
	.db #0xc5	; 197
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7d	; 125
	.db #0xc3	; 195
	.db #0x61	; 97	'a'
	.db #0x02	; 2
	.db #0x76	; 118	'v'
	.db #0x26	; 38
	.db #0xf4	; 244
	.db #0x66	; 102	'f'
	.db #0x36	; 54	'6'
	.db #0x64	; 100	'd'
	.db #0x35	; 53	'5'
	.db #0x24	; 36
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0x75	; 117	'u'
	.db #0x35	; 53	'5'
	.db #0x20	; 32
	.db #0xb4	; 180
	.db #0x20	; 32
	.db #0x35	; 53	'5'
	.db #0x80	; 128
	.db #0x15	; 21
	.db #0x01	; 1
	.db #0xd5	; 213
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xcb	; 203
	.db #0xb7	; 183
	.db #0xb7	; 183
	.db #0x82	; 130
	.db #0x32	; 50	'2'
	.db #0x82	; 130
	.db #0x32	; 50	'2'
	.db #0x00	; 0
	.db #0x35	; 53	'5'
	.db #0x00	; 0
	.db #0xb1	; 177
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdd	; 221
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x62	; 98	'b'
	.db #0x0c	; 12
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x0c	; 12
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xd0	; 208
	.db #0xd8	; 216
	.db #0x40	; 64
	.db #0x1d	; 29
	.db #0x49	; 73	'I'
	.db #0x9d	; 157
	.db #0x09	; 9
	.db #0x9d	; 157
	.db #0x89	; 137
	.db #0xdd	; 221
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7a	; 122	'z'
	.db #0xf7	; 247
	.db #0x73	; 115	's'
	.db #0xe2	; 226
	.db #0xeb	; 235
	.db #0xe2	; 226
	.db #0xc3	; 195
	.db #0xe8	; 232
	.db #0xe1	; 225
	.db #0xc0	; 192
	.db #0xdd	; 221
	.db #0xc8	; 200
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xde	; 222
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x47	; 71	'G'
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x4e	; 78	'N'
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xed	; 237
	.db #0x13	; 19
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x71	; 113	'q'
	.db #0x64	; 100	'd'
	.db #0x33	; 51	'3'
	.db #0x01	; 1
	.db #0x74	; 116	't'
	.db #0x61	; 97	'a'
	.db #0x74	; 116	't'
	.db #0x64	; 100	'd'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x33	; 51	'3'
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x33	; 51	'3'
	.db #0x88	; 136
	.db #0x00	; 0
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
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xf5	; 245
	.db #0xf5	; 245
	.db #0xe0	; 224
	.db #0xf4	; 244
	.db #0xe0	; 224
	.db #0xf4	; 244
	.db #0xe0	; 224
	.db #0xf5	; 245
	.db #0xe0	; 224
	.db #0xf4	; 244
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0xdf	; 223
	.db #0x8e	; 142
	.db #0x9e	; 158
	.db #0x8e	; 142
	.db #0xbc	; 188
	.db #0x0e	; 14
	.db #0x7e	; 126
	.db #0x0c	; 12
	.db #0x7d	; 125
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0x38	; 56	'8'
	.db #0xbd	; 189
	.db #0x39	; 57	'9'
	.db #0x3d	; 61
	.db #0x99	; 153
	.db #0x1d	; 29
	.db #0x19	; 25
	.db #0xcc	; 204
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x76	; 118	'v'
	.db #0xed	; 237
	.db #0x2c	; 44
	.db #0x24	; 36
	.db #0x14	; 20
	.db #0xa0	; 160
	.db #0xb6	; 182
	.db #0x80	; 128
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0x73	; 115	's'
	.db #0x32	; 50	'2'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdd	; 221
	.db #0xbb	; 187
	.db #0xb9	; 185
	.db #0x91	; 145
	.db #0x15	; 21
	.db #0xb1	; 177
	.db #0xa1	; 161
	.db #0x34	; 52	'4'
	.db #0x70	; 112	'p'
	.db #0x20	; 32
	.db #0x6e	; 110	'n'
	.db #0x24	; 36
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x6b	; 107	'k'
	.db #0x9c	; 156
	.db #0x8c	; 140
	.db #0x00	; 0
	.db #0x8d	; 141
	.db #0x21	; 33
	.db #0x9c	; 156
	.db #0x08	; 8
	.db #0xa5	; 165
	.db #0x09	; 9
	.db #0xa5	; 165
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0x7b	; 123
	.db #0xf9	; 249
	.db #0x71	; 113	'q'
	.db #0xf5	; 245
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0x74	; 116	't'
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xee	; 238
	.db #0xe4	; 228
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x79	; 121	'y'
	.db #0xb6	; 182
	.db #0xb6	; 182
	.db #0x10	; 16
	.db #0x86	; 134
	.db #0x10	; 16
	.db #0xa6	; 166
	.db #0x00	; 0
	.db #0xa6	; 166
	.db #0x20	; 32
	.db #0xb6	; 182
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0x7e	; 126
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x8e	; 142
	.db #0xdc	; 220
	.db #0xde	; 222
	.db #0xcc	; 204
	.db #0xce	; 206
	.db #0x9c	; 156
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xda	; 218
	.db #0xe7	; 231
	.db #0xe1	; 225
	.db #0xc2	; 194
	.db #0xe9	; 233
	.db #0xc2	; 194
	.db #0xe1	; 225
	.db #0xc2	; 194
	.db #0xeb	; 235
	.db #0xc8	; 200
	.db #0xe0	; 224
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xd6	; 214
	.db #0x69	; 105	'i'
	.db #0x68	; 104	'h'
	.db #0x40	; 64
	.db #0x68	; 104	'h'
	.db #0x42	; 66	'B'
	.db #0x69	; 105	'i'
	.db #0x40	; 64
	.db #0x6a	; 106	'j'
	.db #0x40	; 64
	.db #0x1a	; 26
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xdb	; 219
	.db #0xdb	; 219
	.db #0x09	; 9
	.db #0xc3	; 195
	.db #0x09	; 9
	.db #0xd3	; 211
	.db #0x81	; 129
	.db #0x53	; 83	'S'
	.db #0x91	; 145
	.db #0x5b	; 91
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xef	; 239
	.db #0xe7	; 231
	.db #0xc7	; 199
	.db #0xd7	; 215
	.db #0xc7	; 199
	.db #0x87	; 135
	.db #0xd3	; 211
	.db #0xc3	; 195
	.db #0x83	; 131
	.db #0xb9	; 185
	.db #0x93	; 147
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7a	; 122	'z'
	.db #0xb7	; 183
	.db #0xb0	; 176
	.db #0x36	; 54	'6'
	.db #0x82	; 130
	.db #0x34	; 52	'4'
	.db #0x81	; 129
	.db #0x04	; 4
	.db #0xb2	; 178
	.db #0x34	; 52	'4'
	.db #0xb0	; 176
	.db #0x36	; 54	'6'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x3b	; 59
	.db #0x1b	; 27
	.db #0x13	; 19
	.db #0xdb	; 219
	.db #0xc3	; 195
	.db #0xdb	; 219
	.db #0xc3	; 195
	.db #0x1b	; 27
	.db #0xc3	; 195
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x8f	; 143
	.db #0x9f	; 159
	.db #0x0f	; 15
	.db #0x8f	; 143
	.db #0x3f	; 63
	.db #0x9f	; 159
	.db #0x0f	; 15
	.db #0xbf	; 191
	.db #0x3f	; 63
	.db #0x8f	; 143
	.db #0x0f	; 15
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
_fire_tiles_tilemap:
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
_fire_scanline_offsets_tbl:
	.db #0x00	;  0
	.db #0x01	;  1
	.db #0x02	;  2
	.db #0x03	;  3
	.db #0x03	;  3
	.db #0x02	;  2
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0xff	; -1
	.db #0xfe	; -2
	.db #0xfd	; -3
	.db #0xfd	; -3
	.db #0xfe	; -2
	.db #0xff	; -1
	.db #0x00	;  0
;src\fire.c:27: void Scene_Fire() BANKED
;	---------------------------------
; Function Scene_Fire
; ---------------------------------
	b_Scene_Fire	= 4
_Scene_Fire::
	ld	hl, #-1108
	add	hl, sp
	ld	sp, hl
;src\fire.c:33: set_palette(PALETTE(CBLACK, CGRAY, CSILVER, CWHITE));
	ld	hl, #0x001b
	push	hl
	call	_set_palette
	add	sp, #2
;src\fire.c:34: set_bkg_data(0, 48, fire_tiles_tiledata);
	ld	hl, #_fire_tiles_tiledata
	push	hl
	ld	a, #0x30
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src\fire.c:36: DISPLAY_OFF;
	call	_display_off
;src\fire.c:38: for (y=0 ; y<18 ; ++y)
	ldhl	sp,	#2
	ld	a, l
	ld	d, h
	ld	hl, #1082
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ld	hl, #722
	add	hl, sp
	ld	a, l
	ld	d, h
	ld	hl, #1084
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	xor	a, a
	ld	hl, #1104
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src\fire.c:40: for (x=0 ; x<20 ; ++x)
00133$:
	ld	hl, #1104
	add	hl, sp
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
;c
	ld	e, a
	ld	hl, #1082
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1095
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1094
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
;c
	ld	hl, #1085
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1104
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1099
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1098
	add	hl, sp
	ld	(hl), a
	ld	hl, #1106
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00213$
	xor	a, a
00213$:
	ld	hl, #1099
	add	hl, sp
	ld	(hl), a
	xor	a, a
	ld	hl, #1107
	add	hl, sp
	ld	(hl), a
00118$:
;src\fire.c:42: *(fire_output+oy+x) = get_bkg_xy_addr(x, y);
	ld	hl, #1107
	add	hl, sp
	ld	a, (hl)
	ld	c, #0x00
	add	a, a
	rl	c
	ld	hl, #1100
	add	hl, sp
	ld	(hl+), a
;c
	ld	a, c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1095
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1104
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1103
	add	hl, sp
	ld	(hl), a
	ld	hl, #1106
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_xy_addr
	add	sp, #2
	ld	c, e
	ld	b, d
	ld	hl, #1102
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\fire.c:43: *(fire_buffer+oy+x) = 0;
;c
	ld	hl, #1098
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1107
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src\fire.c:45: if (y==2 && x>=2 && x<18)
	ld	hl, #1099
	add	hl, sp
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	hl, #1107
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00102$
	ld	a, (hl)
	sub	a, #0x12
	jr	NC, 00102$
;src\fire.c:47: **(fire_output+oy+x) = 32+x-2;
	ld	hl, #1103
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #1107
	add	hl, sp
	ld	a, (hl)
	add	a, #0x1e
	ld	(bc), a
	jr	00119$
00102$:
;src\fire.c:51: **(fire_output+oy+x) = 0;
;c
	ld	hl, #1094
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1100
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	ld	(bc), a
00119$:
;src\fire.c:40: for (x=0 ; x<20 ; ++x)
	ld	hl, #1107
	add	hl, sp
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jp	C, 00118$
;src\fire.c:54: oy += 20;
;c
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1106
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1105
	add	hl, sp
;src\fire.c:38: for (y=0 ; y<18 ; ++y)
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x12
	jp	C, 00133$
;src\fire.c:56: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src\fire.c:60: while (1)
;c
	ld	hl, #1085
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0154
	add	hl, de
	ld	c, l
	ld	b, h
;c
	ld	hl, #1083
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x02a8
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1088
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1087
	add	hl, sp
	ld	(hl), a
	xor	a, a
	ld	hl, #1102
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
00116$:
;src\fire.c:62: fire_scanline_offsets = &fire_scanline_offsets_tbl[(UBYTE)(sys_time >> 2) & 0x07u];
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
	ld	hl, #_fire_scanline_offsets_tbl
	add	hl, de
	ld	a, l
	ld	(_fire_scanline_offsets), a
	ld	a, h
	ld	(_fire_scanline_offsets + 1), a
;src\fire.c:64: for (x=6 ; x<14 ; ++x)
	ld	hl, #1107
	add	hl, sp
	ld	(hl), #0x06
00122$:
;src\fire.c:66: *(fire_buffer+17*20+x) = ((UINT8)rand())%21+40;
	ld	hl, #1107
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	push	hl
	ld	a, l
	ld	hl, #1102
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1101
	add	hl, sp
	ld	(hl), a
	push	bc
	call	_rand
	pop	bc
	ld	d, #0x00
	push	bc
	ld	hl, #0x0015
	push	hl
	push	de
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, e
	add	a, #0x28
	ld	hl, #1100
	add	hl, sp
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;src\fire.c:67: **(fire_output+17*20+x) = (*(fire_buffer+17*20+x))>>2;
	ld	hl, #1107
	add	hl, sp
	ld	a, (hl)
	ld	d, #0x00
	add	a, a
	rl	d
;c
	ld	e, a
	ld	hl, #1086
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1107
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1106
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #1101
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	rrca
	rrca
	and	a, #0x3f
	ld	hl, #1105
	add	hl, sp
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;src\fire.c:68: fire_lcd();
	push	bc
	call	_fire_lcd
	pop	bc
;src\fire.c:64: for (x=6 ; x<14 ; ++x)
	ld	hl, #1107
	add	hl, sp
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0e
	jp	C, 00122$
;src\fire.c:72: for (y=6 ; y<17 ; ++y)
	ld	hl, #1104
	add	hl, sp
	ld	(hl), #0x78
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl), #0x06
;src\fire.c:74: for (x=3 ; x<17 ; ++x)
00140$:
;c
	ld	hl, #1105
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1084
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1090
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1089
	add	hl, sp
	ld	(hl), a
	ld	hl, #1104
	add	hl, sp
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
;c
	ld	e, a
	ld	hl, #1082
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1092
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1091
	add	hl, sp
	ld	(hl), a
	ld	hl, #1088
	add	hl, sp
	ld	a, (hl+)
	ld	e, (hl)
	ld	hl, #1092
	add	hl, sp
	ld	(hl+), a
	ld	(hl), e
;c
	ld	hl, #1089
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1096
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1095
	add	hl, sp
	ld	(hl), a
	ld	hl, #1107
	add	hl, sp
	ld	(hl), #0x03
00124$:
;src\fire.c:76: UINT8 left = *(fire_buffer+oy+20+(UINT16)(x-1));
	ld	hl, #1107
	add	hl, sp
	ld	a, (hl)
	ld	hl, #1096
	add	hl, sp
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
	ld	hl, #1101
	add	hl, sp
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;c
	ld	hl, #1094
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #1101
	add	hl, sp
	ld	(hl), a
;src\fire.c:77: UINT8 middle = *(fire_buffer+oy+20+x);
;c
	ld	hl, #1095
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1107
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #1098
	add	hl, sp
	ld	(hl), a
;src\fire.c:78: UINT8 right = *(fire_buffer+oy+20+x+1);
	ld	hl, #1107
	add	hl, sp
	ld	a, (hl)
	add	a, #0x15
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
;c
	ld	hl, #1092
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #1099
	add	hl, sp
;src\fire.c:79: UINT8 value = (left+middle+right)/3;
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	hl, #1098
	add	hl, sp
	ld	e, (hl)
	ld	d, #0x00
;c
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #1099
	add	hl, sp
	ld	e, (hl)
	ld	d, #0x00
;c
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	hl, #1101
	add	hl, sp
	ld	(hl), e
;src\fire.c:81: if (value>=6)
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00110$
;src\fire.c:82: value -= 6;
	ld	a, (hl)
	add	a, #0xfa
	ld	(hl), a
00110$:
;src\fire.c:84: *(fire_buffer+oy+x) = value;
;c
	ld	hl, #1089
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #1107
	add	hl, sp
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #1101
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
;src\fire.c:85: **(fire_output+oy+x) = value>>2;
	ld	hl, #1096
	add	hl, sp
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
;c
	ld	e, a
	ld	hl, #1090
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1101
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1100
	add	hl, sp
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	dec	hl
	dec	hl
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;src\fire.c:86: fire_lcd();
	push	bc
	call	_fire_lcd
	pop	bc
;src\fire.c:74: for (x=3 ; x<17 ; ++x)
	ld	hl, #1107
	add	hl, sp
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x11
	jp	C, 00124$
;src\fire.c:88: oy += 20;
;c
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	a, l
	ld	hl, #1106
	add	hl, sp
	ld	(hl), a
	pop	hl
	ld	a, h
	ld	hl, #1105
	add	hl, sp
;src\fire.c:72: for (y=6 ; y<17 ; ++y)
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x11
	jp	C, 00140$
;src\fire.c:91: ++sync;
	ld	hl, #1102
	add	hl, sp
	inc	(hl)
	jr	NZ, 00218$
	inc	hl
	inc	(hl)
00218$:
;src\fire.c:92: fire_wind = fire_scanline_offsets_tbl[(sync%32)*3/5]*60;
	push	bc
	ld	hl, #0x0020
	push	hl
	ld	hl, #1106
	add	hl, sp
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__modsint
	add	sp, #4
	push	hl
	ld	hl, #1110
	add	hl, sp
	ld	(hl), e
	ld	hl, #1111
	add	hl, sp
	ld	(hl), d
	pop	hl
	pop	bc
	ld	hl, #1107
	add	hl, sp
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0005
	push	de
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	hl, #_fire_scanline_offsets_tbl
	add	hl, de
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	ld	(#_fire_wind),a
;src\fire.c:94: if (sync>100)
	ld	hl, #1102
	add	hl, sp
	ld	a, #0x64
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00219$
	bit	7, d
	jr	NZ, 00220$
	cp	a, a
	jr	00220$
00219$:
	bit	7, d
	jr	Z, 00220$
	scf
00220$:
	jp	NC, 00116$
;src\fire.c:95: break;
;src\fire.c:97: }
	ld	hl, #1108
	add	hl, sp
	ld	sp, hl
	ret
	.area _CODE_4
	.area _CABS (ABS)
