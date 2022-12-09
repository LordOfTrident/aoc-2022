const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const part1exe = b.addExecutable("part1", "part1.zig");
    part1exe.setTarget(target);
    part1exe.setBuildMode(mode);
    part1exe.install();
    part1exe.setOutputDir("./");

    const part2exe = b.addExecutable("part2", "part2.zig");
    part2exe.setTarget(target);
    part2exe.setBuildMode(mode);
    part2exe.install();
    part2exe.setOutputDir("./");
}
