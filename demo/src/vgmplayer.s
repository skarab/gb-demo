;DMGBVGM player ported to GBDK by Alexandre Chambriat aka Skarab
;src: https://github.com/Pegmode/-DeflemaskGBVGM-

;SoundStatus			0xCC00	0xCC00 ;play,stop,pause state
;CurrentSoundBank					   ;current song data bank
;CurrentSoundBankHigh	0xCC02  0xCC02
;CurrentSoundBankLow	0xCC03  0xCC03
;VgmLookupPointer 		0xCC04	0xCC04 ;current frame pointer
;VgmLookupPointerHigh	0xCC04  0xCC04
;VgmLookupPointerLow	0xCC05  0xCC05
;SoundWaitFrames 		0xCC06	0xCC06 ;number of frames to currently wait

.area _Functions (ABS)
	.org	0x03F00

_VGMPlayerInit::
    ld a,#1
    ld (0xCC03),a
    ld a,#0x40 ;load 0x4000 in pointer
    ld (0xCC04),a

    ld a,#1
    ld (0xCC06),a ;set to not waiting any frames
    xor a
    ld (0xCC00),a ;set engine to not playing status
    ld (0xCC05),a
    ld (0xCC02),a
    ld (0xCC01),a ;clear
    ld (0xCC07),a ;clear
	ld a,#1
    ld (0xCC00),a ;set engine to playing status
    ret

_VGMPlayerUpdate::
checkEngineStatus: ;check if the engine is currently playing a song
    ld a,(0xCC00)
    cp #1
    jr z,checkIsWaitFrame
    ret
checkIsWaitFrame: ;check if the engine is currently in a wait state
    ld a,(0xCC06)
    cp #1
    jr z,loadCurrentBank
    dec a
    ld (0xCC06),a
    ret
loadCurrentBank:
    ld a,(0xCC02)
    ld b,a
    ld a,(0xCC03)
    ld (0x2000),a ;rROMB0
    ld a,b
    ld (0x3000),a ;rROMB1
    
commandCheckInit:
    ld hl,#0xCC04 ;load data pointer
	ld b,(hl)
    inc hl
    ld c,(hl)
    ld h,b
    ld l,c
commandCheck:
    ld a,(hl) ;load data at data pointer, dont inc hl here because it may not be needed for current command
checkWriteCmd:
    bit 7,a
    jr z,checkWaitCmd
    inc hl
    ld a, (hl+)
    ld b, #0xFF
    ld c, a
    ld a, (hl+)
    ld (bc), a
    jr commandCheck
checkWaitCmd:
    bit 6,a
    jr z,checkNextBank
    inc hl
    ld a,(hl+)
    ld (0xCC06),a
    jr endFrame
checkNextBank:
    bit 5,a
    jr z,checkLoop
    ld bc, #0x4000
    ld hl,#0xCC04 ;load data pointer
	ld (hl), b
    inc hl
    ld (hl), c
    ld a,(0xCC02)
    ld b,a
    ld a,(0xCC03)
    ld c, a
    inc bc
    ld a, b
    ld (0xCC02),a
    ld a, c
    ld (0xCC03),a
    ret ;DO NOT END FRAME NORMALLY
checkLoop: ;unimplemented
    bit 4,a
    jr z,checkEndSong
    ;load new bank
    ld hl, #1
    ld a, (hl+)
    ld (0xCC03),a
    ld a, (hl)
    ld (0xCC02),a
    ;load new Address
    ld hl, #0x4000
    ld a, (hl+)
    ld (0xCC05),a
    ld a, (hl)
    ld (0xCC04),a
    ret
checkEndSong:
    bit 3,a
    jr z,errorInCheck
    ;No need to set up registers for quiet status. should be done in tracker via envelopes, OFF or ECxx
    xor a
    ld (0xCC00),a
    ;call resetSound
    ;jr endFrame
	call resetSound
	call _VGMPlayerInit
	ret
errorInCheck:
    ;handle stuff
    ld b,b;debug breakpoint
endFrame:
    ld a, h
    ld (0xCC04),a
    ld a, l
    ld (0xCC05),a
    ret

resetSound:
    xor a
    ldh (0x10), a
    ldh (0x12), a
    ldh (0x17), a
    ldh (0x22), a
    ldh (0x11), a
    ldh (0x11), a
    ldh (0x16), a
    ldh (0x1A), a
    ldh (0x21), a
    ld a, #0x8f
    ldh (0x26), a
    ld a, #0xFF
    ldh (0x25), a
    ld a, #0x77
    ldh (0x24), a
    ld a, #0x20
    ldh (0x1C), a
    ld a, #0xF7
    ldh (0x21), a
    ret