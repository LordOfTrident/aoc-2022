/+ dub.sdl:
    name "part2"
+/

import std.stdio, std.string;

int getScenicScore(int treeX, int treeY, ref string[] map) {
	int height = map[treeY][treeX];

	int a = 0;
	for (int y = treeY - 1; y >= 0; -- y) {
		if (map[y][treeX] >= height) {
			++ a;

			break;
		}

		++ a;
	}

	int b = 0;
	for (int y = treeY + 1; y < map.length; ++ y) {
		if (map[y][treeX] >= height) {
			++ b;

			break;
		}

		++ b;
	}

	int c = 0;
	for (int x = treeX - 1; x >= 0; -- x) {
		if (map[treeY][x] >= height) {
			++ c;

			break;
		}

		++ c;
	}

	int d = 0;
	for (int x = treeX + 1; x < map[treeY].length; ++ x) {
		if (map[treeY][x] >= height) {
			++ d;

			break;
		}

		++ d;
	}

	return a * b * c * d;
}

void main() {
	auto file  = File("input.txt");
	auto lines = file.byLine();
	string[] map;

	foreach (line; lines) {
		foreach (ref ch; line)
			ch -= '0';

		map ~= line.idup;
	}

	int highest = 0;
	for (int y = 1; y < map.length - 1; ++ y) {
		for (int x = 1; x < map[y].length - 1; ++ x) {
			int score = getScenicScore(x, y, map);
			if (score > highest)
				highest = score;
		}
	}

	writeln(highest);
}
