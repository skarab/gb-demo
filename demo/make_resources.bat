@echo off

call "C:\Program Files (x86)\sox-14-4-2\sox.exe" D:\prog\gameboy\samples\sega\Sega.wav -b 8 -c 1 --rate 8192 sega.raw
call ..\tools\xxd\Release\xxd.exe -i -w sega.raw resources\sega_wav.h
del sega.raw

call ..\tools\xxd\Release\xxd.exe -i -w -x ..\images\cube_header.raw resources\cube_header.h

call ..\generator\Debug\generator.exe
