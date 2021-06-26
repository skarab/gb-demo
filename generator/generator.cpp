#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string>
#include <fstream>
#include <iostream>
using namespace std;

void PackToTiles(const vector<vector<unsigned char>>& data, vector<unsigned int>& tiles_ids, vector<vector<unsigned char>>& tiles_data)
{
	// Create tiles
	vector<vector<unsigned char>> tiles;
	unsigned int width = data[0].size() / 8 + (data[0].size() % 8 != 0 ? 1 : 0);
	unsigned int height = data.size() / 8 + (data.size() % 8 != 0 ? 1 : 0);
	tiles.resize(width * height);

	for (unsigned int y = 0; y < height; ++y)
	{
		for (unsigned int x = 0; x < width; ++x)
		{
			vector<unsigned char>& tile = tiles[y * width + x];
			tile.resize(2 * 8);

			// Pack tile
			for (unsigned int j = 0; j < 8; ++j)
			{
				for (unsigned int i = 0; i < 2; ++i)
				{
					unsigned char c0 = (y * 8 + j) < data.size() && (x * 8 + 0) < data[0].size() ? (data[y * 8 + j][x * 8 + 0] >> i & 1) : 0;
					unsigned char c1 = (y * 8 + j) < data.size() && (x * 8 + 1) < data[0].size() ? (data[y * 8 + j][x * 8 + 1] >> i & 1) : 0;
					unsigned char c2 = (y * 8 + j) < data.size() && (x * 8 + 2) < data[0].size() ? (data[y * 8 + j][x * 8 + 2] >> i & 1) : 0;
					unsigned char c3 = (y * 8 + j) < data.size() && (x * 8 + 3) < data[0].size() ? (data[y * 8 + j][x * 8 + 3] >> i & 1) : 0;
					unsigned char c4 = (y * 8 + j) < data.size() && (x * 8 + 4) < data[0].size() ? (data[y * 8 + j][x * 8 + 4] >> i & 1) : 0;
					unsigned char c5 = (y * 8 + j) < data.size() && (x * 8 + 5) < data[0].size() ? (data[y * 8 + j][x * 8 + 5] >> i & 1) : 0;
					unsigned char c6 = (y * 8 + j) < data.size() && (x * 8 + 6) < data[0].size() ? (data[y * 8 + j][x * 8 + 6] >> i & 1) : 0;
					unsigned char c7 = (y * 8 + j) < data.size() && (x * 8 + 7) < data[0].size() ? (data[y * 8 + j][x * 8 + 7] >> i & 1) : 0;
					tile[j * 2 + i] = (c0 << 7) | (c1 << 6) | (c2 << 5) | (c3 << 4) | (c4 << 3) | (c5 << 2) | (c6 << 1) | (c7 << 0);
				}
			}
		}
	}

	// Build tilemap
	tiles_ids.resize(width * height);
	for (unsigned int id = 0; id < tiles.size(); ++id)
	{
		bool exist = false;

		for (unsigned int i = 0; i < tiles_data.size(); ++i)
		{
			bool equal = true;
			for (unsigned int j = 0; j < tiles_data[i].size(); ++j)
			{
				if (tiles[id][j] != tiles_data[i][j])
				{
					equal = false;
					break;
				}
			}

			if (equal)
			{
				exist = true;
				tiles_ids[id] = i;
				break;
			}
		}

		if (!exist)
		{
			if (tiles_data.size() == 256)
			{
				cout << "TO MUCH TILES !";
				tiles_ids[id] = 255;
			}
			else
			{
				tiles_ids[id] = tiles_data.size();
				tiles_data.push_back(tiles[id]);
			}
		}
	}
}

void ExportTiles(const vector<unsigned int>& tiles_ids, const vector<vector<unsigned char>>& tiles_data, string name)
{
	string file_path = "../demo/resources/" + name + ".h";
	string file_data;

	file_data += "const unsigned int " + name + "_tiledata_count = " + to_string(tiles_data.size()) + ";\n";
	file_data += "const unsigned char " + name + "_tiledata[] = {";
	for (unsigned int i = 0; i < tiles_data.size(); ++i)
	{
		file_data += "\n    ";
		for (unsigned int j = 0; j < tiles_data[i].size(); ++j)
		{
			file_data += to_string(tiles_data[i][j]) + (!(i == tiles_data.size() - 1 && j == tiles_data[i].size() - 1) ? ", " : "\n");
		}
	}
	file_data += "};\n\n";

	unsigned int id = 0;
	unsigned int offset = 0;
	while (offset < tiles_ids.size())
	{
		unsigned int count = tiles_ids.size() - offset;
		if (count > 256)
			count = 256;

		file_data += "const unsigned int " + name + "_tilemap" + to_string(id) + "_count = " + to_string(count) + ";\n";
		file_data += "const unsigned char " + name + "_tilemap" + to_string(id) + "[] = { \n";
		for (unsigned int i = offset; i < offset + count; ++i)
		{
			file_data += to_string(tiles_ids[i]) + (i < offset + count - 1 ? ", " : "\n");
		}
		file_data += "};\n\n";

		++id;
		offset += count;
	}

	ofstream output(file_path);
	output << file_data;
}

void ExportPrecalculatedAnim(string name)
{
	string file_path = "../demo/resources/" + name + ".h";
	string file_data;

	file_data += "const unsigned char " + name + "[][41] = {\n";  //200, 41 144+16+40

	for (unsigned char y = 0; y < 200; ++y)
	{
		file_data += "    { ";

		for (unsigned char x = 0; x < 41; ++x)
		{
			unsigned char h = y;
			if (h >= 200) // 144+16+40
				h = 200;

			unsigned char value = ((h / (16 + x)) & 1) * (16 + x);

			file_data += to_string(value);

			if (x < 40)
			{
				file_data += ", ";
			}
		}

		file_data += "}";

		if (y < 199)
		{
			file_data += ",\n";
		}
	}

	file_data += "\n};";

	ofstream output(file_path);
	output << file_data;
}

int main()
{
	vector<vector<unsigned char>> data;

	for (int y = 0; y < 170; ++y) // 160+4+.. (remove artifacts)
	{
		int square_size = 16 + y / 4;
		vector<unsigned char> line;
		line.reserve(32 * 8);
		for (int x = 0; x < 32 * 8; ++x)
		{
			unsigned char color = ((x / square_size) % 2) * 2;
			if (color == 0)
			{
				color = (((x + square_size / 8) / square_size) % 2) * 3;

				if (color == 0)
				{
					int fx = (x + x * (y / 4)) / (1 + (y / 6) * 16);
					int col = (abs(fx + (y & 1)) / 10) % 3;
					
					if (y > 80 && x >= 9 * 22)
						col = (y&1)+2;
					else if (y > 80 && x >= 8 * 22)
						col = 2;
					else if (y > 80 && x >= 7 * 22)
						col = (y & 1) + 1;

					color = col;
				}

			}
			else
			{
				color = 3;

				int fx = (x + x * (y / 16)) / (1 + (y / 6) * 16);
				int col = (abs(fx + (y & 1)) / 10) % 3;

				color = 3-col/2;
			}

			line.push_back(color);
		}
		data.push_back(line);
	}

	vector<unsigned int> tiles_ids;
	vector<vector<unsigned char>> tiles_data;
	PackToTiles(data, tiles_ids, tiles_data);

	ExportTiles(tiles_ids, tiles_data, "squares_zoom");
	ExportPrecalculatedAnim("squares_zoom_precalc");
}
