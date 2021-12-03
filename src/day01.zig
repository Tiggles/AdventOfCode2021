const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day01.txt");

pub fn main() !void {
    print("{}\n", .{task1()});
    print("{}\n", .{task2()});
}

fn task1() i64 {
    var largerCount: i64 = -1;
    var lines = tokenize(u8, data, "\r\n");
    var current: i64 = 0;
    var previous: i64 = 0;
    while (lines.next()) |line| {
        current = parseInt(i64, line, 10) catch unreachable;
        if (current > previous) {
            largerCount += 1;
        }
        previous = current;
    }
    return largerCount;
}

fn task2() i64 {
    var largerCount: i64 = 0;
    var lines = tokenize(u8, data, "\r\n");

    var indexCounter: u64 = 0;
    const WINDOW_SIZE = 4;
    var window: [WINDOW_SIZE]i64 = .{ 0, 0, 0, 0 };

    while (lines.next()) |line| {
        window[indexCounter % WINDOW_SIZE] = parseInt(i64, line, 10) catch unreachable;
        var i: u8 = 0;
        var a: i64 = 0;
        var b: i64 = 0;
        while (i < 4) : (i += 1) {
            if (indexCounter < 3) break;
            if (i == 0) {
                b += window[(indexCounter - i) % WINDOW_SIZE];
            } else if (i == 1 or i == 2) {
                a += window[(indexCounter - i) % WINDOW_SIZE];
                b += window[(indexCounter - i) % WINDOW_SIZE];
            } else if (i == 3) {
                a += window[(indexCounter - i) % WINDOW_SIZE];
            }
        }
        if (a < b) {
            largerCount += 1;
        }
        indexCounter += 1;
    }
    return largerCount;
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
