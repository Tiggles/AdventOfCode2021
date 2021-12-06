const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day03.txt");

const BIT_COUNT = 12;

pub fn main() !void {
    var lines = tokenize(u8, data, "\n");
    var totalLineCount: u64 = 0;
    var gammaRate: u64 = 0;

    var bitCount: [BIT_COUNT]u32 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    while (lines.next()) |line| {
        var bitIndex: u8 = 0;
        for (line) |num| {
            bitCount[bitIndex] += toSortaBinary(num);
            bitIndex = (bitIndex + 1) % 12;
        }
        totalLineCount += 1;
    }

    const cutOff = totalLineCount / 2;
    for (bitCount) |indexValue, index| {
        if (indexValue > cutOff) {
            gammaRate += std.math.pow(u64, 2, BIT_COUNT - index - 1);
        }
    }

    const epsilonRate = ~@intCast(u12, gammaRate);

    print("{}\n", .{gammaRate * epsilonRate});
}

// 5208 * 2982 

fn toSortaBinary(num: u8) u8 {
    return num - 48;
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
