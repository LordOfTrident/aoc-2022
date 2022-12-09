const std    = @import("std");
const stdout = std.io.getStdOut().writer();
const fs     = std.fs;
const io     = std.io;

const Vec2 = struct {
	x: i32,
	y: i32,
};

var tail = Vec2{.x = 0, .y = 0};
var head = Vec2{.x = 0, .y = 0};

var visited = std.ArrayList(Vec2).init(std.heap.page_allocator);

fn savePos() anyerror!void {
	var found: bool  = false;
	var i:     usize = 0;
	while (i < visited.items.len) : (i += 1) {
		if ((visited.items[i].x == tail.x) and (visited.items[i].y == tail.y)) {
			found = true;
		}
	}

	if (!found) {
		try visited.append(Vec2{.x = tail.x, .y = tail.y});
	}
}

fn moveTowards1D(towards: i32, pos: *i32) void {
	if (towards > pos.*) {
		pos.* += 1;
	} else if (towards < pos.*) {
		pos.* -= 1;
	}
}

fn bringTailBack() void {
	if ((head.x >= tail.x - 1) and (head.x <= tail.x + 1) and
	    (head.y >= tail.y - 1) and (head.y <= tail.y + 1))
		return;

	moveTowards1D(head.x, &tail.x);
	moveTowards1D(head.y, &tail.y);
}

pub fn main() anyerror!void {
	var file = try fs.cwd().openFile("input.txt", .{});
	defer file.close();

	var reader = io.bufferedReader(file.reader());
	var stream = reader.reader();
	var buf: [16]u8 = undefined;

	defer visited.deinit();
	try   visited.append(Vec2{.x = 0, .y = 0});

	while (try stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
		var dir: u8 = line[0];
		var by:  u8 = 0;

		var i: usize = 2;
		while (i < line.len) : (i += 1) {
			by *= 10;
			by += line[i] - '0';
		}

		i = 0;
		while (i < by) : (i += 1) {
			switch (dir) {
				'R' => head.x += 1,
				'L' => head.x -= 1,
				'U' => head.y -= 1,
				'D' => head.y += 1,

				else => {}
			}

			bringTailBack();
			try savePos();
		}
	}

	try stdout.print("{d}\n", .{visited.items.len});
}
