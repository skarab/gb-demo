@echo off
call clean.bat
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o gameboy.o src\gameboy.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o demo.o src\demo.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o nintendo.o src\nintendo.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o sega.o src\sega.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o part1_music.o resources\part1_music.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o title.o src\title.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o lines.o src\lines.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o cube.o src\cube.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o noise.o src\noise.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o fire.o src\fire.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o blittest.o src\blittest.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o axelay.o src\axelay.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o sprites_physics.o src\sprites_physics.c
@echo building banks...
..\gbdk\bin\bankpack -ext=.rel -v -yt19 gameboy.o demo.o nintendo.o sega.o part1_music.o title.o lines.o cube.o noise.o fire.o blittest.o axelay.o sprites_physics.o ..\gbdk\hUGEBuild\build\hUGEDriver.obj.o
@echo linking...
..\gbdk\bin\lcc -Wl-yo16 -Wa-l -Wl-m -Wl-j -Wl-yt27 -Wl-ya4 -o demo.gb gameboy.rel demo.rel nintendo.rel sega.rel part1_music.rel title.rel lines.rel cube.rel noise.rel fire.rel blittest.rel axelay.rel sprites_physics.rel ..\gbdk\hUGEBuild\build\hUGEDriver.obj.rel
