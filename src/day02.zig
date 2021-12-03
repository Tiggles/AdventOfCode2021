const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day02.txt");

fn task1() i64 {
    var lines = tokenize(u8, data, "\n");
    var x: i64 = 0;
    var y: i64 = 0;

    while (lines.next()) |line| {
        var commandAndValue = tokenize(u8, line, " ");
        var command = commandAndValue.next();
        var value = commandAndValue.next();
        var parsedValue = parseInt(i64, value.?, 10) catch unreachable;

        if (std.mem.eql(u8, command.?, "up")) {
            y -= parsedValue;
        } else if (std.mem.eql(u8, command.?, "down")) {
            y += parsedValue;
        } else if (std.mem.eql(u8, command.?, "forward")) {
            x += parsedValue;
        } else {
            std.debug.print("Unknown {s}", .{command});
        }
    }
    return x * y;
}

fn task2() i64 {
    // down X increases your aim by X units.
    // up X decreases your aim by X units.
    // forward X does two things:
    //     It increases your horizontal position by X units.
    //     It increases your depth by your aim multiplied by X.

    var horizontalPosition: i64 = 0;
    var aim: i64 = 0;
    var depth: i64 = 0;
    var lines = tokenize(u8, data, "\n");

    while (lines.next()) |line| {
        var commandAndValue = tokenize(u8, line, " ");
        var command = commandAndValue.next();
        var value = commandAndValue.next();
        var parsedValue = parseInt(i64, value.?, 10) catch unreachable;

        if (std.mem.eql(u8, command.?, "up")) {
            aim -= parsedValue;
        } else if (std.mem.eql(u8, command.?, "down")) {
            aim += parsedValue;
        } else if (std.mem.eql(u8, command.?, "forward")) {
            horizontalPosition += parsedValue;
            depth += aim * parsedValue;
        } else {
            std.debug.print("Unknown {s}", .{command});
        }
    }
    // multiply your final horizontal position by your final depth
    return horizontalPosition * depth;
}

pub fn main() !void {
    print("{}\n", .{task1()});
    print("{}\n", .{task2()});
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;
