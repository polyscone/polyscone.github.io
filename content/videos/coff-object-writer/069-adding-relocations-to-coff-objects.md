+++
title = "Adding Relocations to COFF Objects"
description = "I connect encoder fixups to COFF relocations, write relocation tables after each section's data, and clear fixup bytes to avoid unwanted implicit addends. I inspect the output with dumpbin, then link against libcmt and run a program that calls printf and returns 123."
date = "2026-09-10T02:57:31Z"
duration = 1492
weight = 69
youtube_id = "3yt5g3AptXE"
aliases = ["/videos/compiler-toolchain/069-adding-relocations-to-coff-objects/"]
collection = "compiler_toolchain"

[[chapters]]
title = "Adapting the Test Program for Windows x64"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding Read-Only Data and Symbols"
time = "00:01:59"
start = 119

[[chapters]]
title = "COFF REL32 Relocations and ELF Addends"
time = "00:04:45"
start = 285

[[chapters]]
title = "Connecting Encoder Fixups to Relocations"
time = "00:08:30"
start = 510

[[chapters]]
title = "Adding Strings and Handling Undefined Symbols"
time = "00:10:53"
start = 653

[[chapters]]
title = "Simplifying the String Table"
time = "00:12:32"
start = 752

[[chapters]]
title = "Relocation Table Layout and Section Offsets"
time = "00:13:17"
start = 797

[[chapters]]
title = "Building and Writing Relocation Entries"
time = "00:15:57"
start = 957

[[chapters]]
title = "Inspecting the Object with dumpbin"
time = "00:19:35"
start = 1175

[[chapters]]
title = "Clearing Fixup Bytes for Implicit Addends"
time = "00:20:47"
start = 1247

[[chapters]]
title = "Linking Against libcmt and Running the Program"
time = "00:23:05"
start = 1385

[[chapters]]
title = "Long Symbol and Section Names Still to Support"
time = "00:24:07"
start = 1447
+++

I connect encoder fixups to COFF relocations, write relocation tables after each section's data, and clear fixup bytes to avoid unwanted implicit addends. I inspect the output with dumpbin, then link against libcmt and run a program that calls printf and returns 123.
