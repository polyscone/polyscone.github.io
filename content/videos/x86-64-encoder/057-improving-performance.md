+++
title = "Improving Performance"
description = "Code cleanup and performance improvements."
date = "2026-07-28T04:26:52Z"
duration = 4424
weight = 57
youtube_id = "LhcW-OqLdQM"
collection = "compiler_toolchain"

[[chapters]]
title = "Odin rexcode Reference Numbers"
time = "00:00:00"
start = 0

[[chapters]]
title = "Odin Benchmark Changes"
time = "00:05:10"
start = 310

[[chapters]]
title = "Copying the Odin Benchmark"
time = "00:06:28"
start = 388

[[chapters]]
title = "Bit Position Constants"
time = "00:16:45"
start = 1005

[[chapters]]
title = "Segment Checks"
time = "00:18:54"
start = 1134

[[chapters]]
title = "Remove Form Scoring"
time = "00:19:43"
start = 1183

[[chapters]]
title = "Improve Operand Match Checks"
time = "00:27:49"
start = 1669

[[chapters]]
title = "Remove Form Copies"
time = "00:34:06"
start = 2046

[[chapters]]
title = "Merge Rex and W"
time = "00:34:58"
start = 2098

[[chapters]]
title = "Simplify REX Byte Creation"
time = "00:35:58"
start = 2158

[[chapters]]
title = "Remove Operands Immediate Loop"
time = "00:37:24"
start = 2244

[[chapters]]
title = "Simplify Disp Output"
time = "00:45:09"
start = 2709

[[chapters]]
title = "Simplify ModRM Output"
time = "00:45:54"
start = 2754

[[chapters]]
title = "Simplify Op/En O/OI Opcode Bytes"
time = "00:49:24"
start = 2964

[[chapters]]
title = "Avoid More Form Copies"
time = "00:53:44"
start = 3224

[[chapters]]
title = "Improve Opcode Extension"
time = "00:55:14"
start = 3314

[[chapters]]
title = "Add a PP Lookup Table"
time = "01:00:40"
start = 3640

[[chapters]]
title = "Improve HasModRM Function"
time = "01:01:29"
start = 3689

[[chapters]]
title = "Cached Form Benchmarks"
time = "01:03:25"
start = 3805

[[chapters]]
title = "Checking Impact of OBS"
time = "01:08:18"
start = 4098

[[chapters]]
title = "Add Missing immfi"
time = "01:09:28"
start = 4168

[[chapters]]
title = "Restore Segment Checks"
time = "01:10:14"
start = 4214

[[chapters]]
title = "Final OBS Impact Check"
time = "01:13:08"
start = 4388
+++

Code cleanup and performance improvements.

I start with a reference number of instructions per second using Odin and the benchmarks in its rexcode package. The numbers from that benchmark are purely used as a throughput target for my own encoder and are not in any way a language benchmark.

I take my encoder from ~26M insts/s to ~100M insts/s on the generic path, and up to ~180M insts/s on the cached instruction form path.
