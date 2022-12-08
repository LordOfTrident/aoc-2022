/+ dub.sdl:
    name "part1"
+/

import std.stdio, std.string;

bool isVisible(int treeX, int treeY, ref string[] map) {
	int height = map[treeY][treeX];

	bool[4] sides = [true, true, true, true];
	for (int y = 0; y < treeY; ++ y) {
		if (map[y][treeX] >= height) {
			sides[0] = false;

			break;
		}
	}

	for (int y = treeY + 1; y < map.length; ++ y) {
		if (map[y][treeX] >= height) {
			sides[1] = false;

			break;
		}
	}

	for (int x = 0; x < treeX; ++ x) {
		if (map[treeY][x] >= height) {
			sides[2] = false;

			break;
		}
	}

	for (int x = treeX + 1; x < map[treeY].length; ++ x) {
		if (map[treeY][x] >= height) {
			sides[3] = false;

			break;
		}
	}

	foreach (visible; sides) {
		if (visible)
			return true;
	}

	return false;
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

	ulong sum = (map.length + map[0].length - 2) * 2;
	for (int y = 1; y < map.length - 1; ++ y) {
		for (int x = 1; x < map[y].length - 1; ++ x) {
			if (isVisible(x, y, map))
				++ sum;
		}
	}

	writeln(sum);
}
