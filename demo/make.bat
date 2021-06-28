@echo off
del *.gb
call make_resources.bat
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o gameboy.o src\gameboy.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o demo.o src\demo.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o erase.o src\erase.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o sega.o src\sega.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o part1_music.o data\part1_music.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o lines.o src\lines.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o cube.o src\cube.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o noise.o src\noise.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o fire.o src\fire.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o axelay.o src\axelay.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o sprites_physics.o src\sprites_physics.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o squares_zoom.o src\squares_zoom.c
@echo building c files...
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o squares_race.o src\squares_race.c
..\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wl-yt27 -I..\gbdk\hUGEBuild\player-gbdk-banked -c -o rain.o src\rain.c
@echo building banks...
..\gbdk\bin\bankpack -ext=.rel -v -yt19 gameboy.o demo.o erase.o sega.o part1_music.o lines.o cube.o noise.o fire.o axelay.o sprites_physics.o squares_zoom.o squares_race.o rain.o ..\gbdk\hUGEBuild\build\hUGEDriver.obj.o
@echo linking...
..\gbdk\bin\lcc -Wl-yo16 -Wa-l -Wl-m -Wl-j -Wl-yt27 -Wl-ya4 -o demo.gb gameboy.rel demo.rel erase.rel sega.rel part1_music.rel lines.rel cube.rel noise.rel fire.rel axelay.rel sprites_physics.rel squares_zoom.rel squares_race.rel rain.rel ..\gbdk\hUGEBuild\build\hUGEDriver.obj.rel
@echo cleaning...
del *.map
del *.rel
del *.asm
del *.o
del *.sym
del *.ihx
del *.lst
del *.noi
