+++
title = "Long COFF Symbol and Section Names and Relocation Overflow"
description = "I add string-table support for COFF symbol and section names longer than eight bytes, then implement relocation overflow handling with a section flag and a dummy relocation record. I inspect the long names with dumpbin, link and run a program that calls GetStdHandle and printf and returns 123, then fix the overflow flag output and relocation count."
date = "2026-09-10T05:20:39Z"
duration = 1124
weight = 70
youtube_id = "4wkJam7o7xw"
aliases = ["/videos/compiler-toolchain/070-long-coff-symbol-and-section-names-and-relocation-overflow/"]
collection = "compiler_toolchain"

[[chapters]]
title = "Long Names and Relocation Count Limits"
time = "00:00:00"
start = 0

[[chapters]]
title = "Demonstrating Truncated Symbol and Section Names"
time = "00:01:31"
start = 91

[[chapters]]
title = "Supporting Long Symbol Names"
time = "00:03:28"
start = 208

[[chapters]]
title = "Inspecting the Symbol Name and String Table"
time = "00:06:08"
start = 368

[[chapters]]
title = "Supporting Long Section Names"
time = "00:07:05"
start = 425

[[chapters]]
title = "Relocation Overflow Format"
time = "00:10:38"
start = 638

[[chapters]]
title = "Implementing Relocation Overflow Handling"
time = "00:12:16"
start = 736

[[chapters]]
title = "Linking and Running with GetStdHandle"
time = "00:16:27"
start = 987

[[chapters]]
title = "Fixing the Overflow Flag and Dummy Relocation Count"
time = "00:17:49"
start = 1069
+++

I add string-table support for COFF symbol and section names longer than eight bytes, then implement relocation overflow handling with a section flag and a dummy relocation record. I inspect the long names with dumpbin, link and run a program that calls GetStdHandle and printf and returns 123, then fix the overflow flag output and relocation count.
