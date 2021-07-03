#include "stdio.h"
#include "stdlib.h"
#include <string>
using namespace std;

void main(int argc, char** argv)
{
	if (argc != 3)
		return;

	FILE* rom;
	if (fopen_s(&rom, argv[2], "rb+") != 0)
		return;

	long i = 0;
	while (1)
	{
		string music_path = argv[1];
		music_path += to_string(i);
		music_path += ".bin";

		FILE* music;
		if (fopen_s(&music, music_path.c_str(), "rb") != 0)
			break;

		fseek(rom, 0x4000 * (i + 1), SEEK_SET);

		int byte;
		while ((byte = fgetc(music)) != EOF)
		{
			fputc(byte, rom);
		}

		fclose(music);
		++i;
	}

	fclose(rom);
	printf("injected: %i banks\n", i);
}