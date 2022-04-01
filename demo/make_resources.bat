@echo off

call ..\tools\sox-14.4.2\sox.exe ..\samples\sega\Sega.wav -b 8 -c 1 --rate 8192 sega.raw
call ..\tools\xxd\Release\xxd.exe -i -w sega.raw resources\sega_wav.h
del sega.raw

call ..\tools\DeflemaskGBVGM\Debug\DeflemaskGBVGM.exe ..\music\music.vgm -bin -o tmp\music -r 60

call ..\tools\xxd\Release\xxd.exe -i -w -x ..\images\cube_header.raw resources\cube_header.h

call ..\generator\Debug\generator.exe
