/*---------------------------------------------------------------------------------

bin2s: convert a binary file to a gcc asm module
for gfx/foo.bin it'll write foo_bin (an array of char)
foo_bin_end, and foo_bin_len (an unsigned int)
for 4bit.chr it'll write _4bit_chr, _4bit_chr_end, and
_4bit_chr_len


Copyright 2003 - 2005 Damian Yerrick
Copyright 2004 - 2017 Dave (WinterMute) Murphy

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.

---------------------------------------------------------------------------------*/



/*
.align
.global SomeLabel_len
.int 1234
.global SomeLabel
.byte blah,blah,blah,blah...
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


//---------------------------------------------------------------------------------
int main(int argc, char** argv) {
	//---------------------------------------------------------------------------------
	FILE* fin;
	FILE* header_file;
	char* header_name = NULL;

	size_t filelen;
	int linelen;
	int arg;
	int alignment = 4;
	
	if (argc < 2) {
		return -1;
	}

	int c;

	for (arg = 1; arg < argc; arg++) {

		fopen_s(&fin, argv[arg], "rb");

		if (!fin) {
			fputs("bin2s: could not open ", stderr);
			perror(argv[arg]);
			return 1;
		}

		fseek(fin, 0, SEEK_END);
		filelen = ftell(fin);
		rewind(fin);

		if (filelen == 0) {
			fclose(fin);
			fprintf(stderr, "bin2s: warning: skipping empty file %s\n", argv[arg]);
			continue;
		}

		char* ptr = argv[arg];
		char chr;
		char* filename = NULL;

		while ((chr = *ptr)) {

			if (chr == '\\' || chr == '/') {

				filename = ptr;
			}

			ptr++;
		}

		if (NULL != filename) {
			filename++;
		}
		else {
			filename = argv[arg];
		}


		linelen = 0;

		int count = filelen;
		fputs(".db ", stdout);

		while (count > 0) {
			unsigned char c = fgetc(fin);

			printf("0x%02hhX", (unsigned int)c);
			count--;

			/* don't put a comma after the last item */
			if (count) {

				/* break after every 16th number */
				if (++linelen >= 16) {
					linelen = 0;
					fputs("\n.db ", stdout);
				}
				else {
					fputc(',', stdout);
				}
			}
		}

		fclose(fin);
	}

	return 0;
}

