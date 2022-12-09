const std    = @import("std");
const stdout = std.io.getStdOut().writer();
const fs     = std.fs;
const io     = std.io;

const Vec2 = struct {
	x: i32,
	y: i32,
};

var nodes: [10]Vec2 = undefined;

var visited = std.ArrayList(Vec2).init(std.heap.page_allocator);

fn savePos(idx: usize) anyerror!void {
	var found: bool  = false;
	var i:     usize = 0;
	while (i < visited.items.len) : (i += 1) {
		if ((visited.items[i].x == nodes[idx].x) and (visited.items[i].y == nodes[idx].y)) {
			found = true;
		}
	}

	if (!found) {
		try visited.append(Vec2{.x = nodes[idx].x, .y = nodes[idx].y});
	}
}

fn moveTowards1D(towards: i32, pos: *i32) void {
	if (towards > pos.*) {
		pos.* += 1;
	} else if (towards < pos.*) {
		pos.* -= 1;
	}
}

fn bringNodeBack(idx: usize) void {
	if ((nodes[idx - 1].x >= nodes[idx].x - 1) and (nodes[idx - 1].x <= nodes[idx].x + 1) and
	    (nodes[idx - 1].y >= nodes[idx].y - 1) and (nodes[idx - 1].y <= nodes[idx].y + 1))
		return;

	moveTowards1D(nodes[idx - 1].x, &nodes[idx].x);
	moveTowards1D(nodes[idx - 1].y, &nodes[idx].y);
}

pub fn main() anyerror!void {
	var file = try fs.cwd().openFile("input.txt", .{});
	defer file.close();

	var reader = io.bufferedReader(file.reader());
	var stream = reader.reader();
	var buf: [16]u8 = undefined;

	var i: usize = 0;
	while (i < nodes.len) : (i += 1) {
		nodes[i].x = 0;
		nodes[i].y = 0;
	}

	defer visited.deinit();
	try   visited.append(Vec2{.x = 0, .y = 0});

	while (try stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
		var dir: u8 = line[0];
		var by:  u8 = 0;

		i = 2;
		while (i < line.len) : (i += 1) {
			by *= 10;
			by += line[i] - '0';
		}

		i = 0;
		while (i < by) : (i += 1) {
			switch (dir) {
				'R' => nodes[0].x += 1,
				'L' => nodes[0].x -= 1,
				'U' => nodes[0].y -= 1,
				'D' => nodes[0].y += 1,

				else => {}
			}

			var j: usize = 1;
			while (j < nodes.len) : (j += 1) {
				bringNodeBack(j);
			}

			try savePos(9);
		}
	}

	try stdout.print("{d}\n", .{visited.items.len});
}
