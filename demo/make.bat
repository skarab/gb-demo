@echo off
del *.gb
call make_resources.bat
@echo building asm files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o vgmplayer.o src\vgmplayer.s
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o sample.o src\sample.s
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o gameboy.o src\gameboy.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o demo.o src\demo.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o erase.o src\erase.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o shake.o src\shake.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o sega.o src\sega.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o lines.o src\lines.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o cube.o src\cube.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o fire.o src\fire.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o axelay.o src\axelay.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o sprites_physics.o src\sprites_physics.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o squares_zoom.o src\squares_zoom.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o squares_race.o src\squares_race.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o rain.o src\rain.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o vbarrels.o src\vbarrels.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o kiss.o src\kiss.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o funky_girl.o src\funky_girl.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o senses.o src\senses.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o logo.o src\logo.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o landscape.o src\landscape.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o scroller.o src\scroller.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o title.o src\title.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o tunnel.o src\tunnel.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt26 -c -o cube_video.o src\cube_video.c
@echo building banks...
..\gbdk\bin\bankpack -ext=.rel -v -yt19 vgmplayer.o sample.o gameboy.o demo.o shake.o erase.o sega.o lines.o cube.o fire.o axelay.o sprites_physics.o squares_zoom.o squares_race.o rain.o vbarrels.o kiss.o funky_girl.o senses.o logo.o landscape.o scroller.o title.o tunnel.o cube_video.o
@echo linking...
..\gbdk\bin\lcc -Wl-yo256 -Wl-ya1 -Wa-l -Wl-m -Wl-j -Wl-yt26 -o demo.gb vgmplayer.rel sample.rel gameboy.rel demo.rel shake.rel erase.rel sega.rel lines.rel cube.rel fire.rel axelay.rel sprites_physics.rel squares_zoom.rel squares_race.rel rain.rel vbarrels.rel kiss.rel funky_girl.rel senses.rel logo.rel landscape.rel scroller.rel title.rel tunnel.rel cube_video.rel
@echo inject music...
..\tools\inject\Debug\inject.exe tmp\music demo.gb
@echo fix checksum...
..\tools\rgbds\rgbfix.exe -f g demo.gb
@echo cleaning...
del *.map
del *.rel
del *.asm
del *.o
del *.sym
del *.ihx
del *.lst
del *.noi
