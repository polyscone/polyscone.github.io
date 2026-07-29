+++
title = "COFF Object File Types and Data Structures"
description = "I gather COFF data structures and constants from Microsoft's PE format documentation in preparation for writing Windows object files for link.exe. I cover file and section headers, AMD64 relocations, symbols, and the string table, including differences from ELF and how COFF handles long names and relocation addends."
date = "2026-09-07T06:01:39Z"
duration = 2245
weight = 67
youtube_id = "fEyJLfbJNX4"
aliases = ["/videos/compiler-toolchain/067-coff-object-file-types-and-data-structures/"]
collection = "compiler_toolchain"

[[chapters]]
title = "Intro and PE/COFF Overview"
time = "00:00:00"
start = 0

[[chapters]]
title = "COFF File Header"
time = "00:02:27"
start = 147

[[chapters]]
title = "Machine Type Constants"
time = "00:06:18"
start = 378

[[chapters]]
title = "File Characteristics and Image-Only Headers"
time = "00:07:55"
start = 475

[[chapters]]
title = "Section Headers and Long Names"
time = "00:09:15"
start = 555

[[chapters]]
title = "Section Data Alignment and .bss"
time = "00:13:47"
start = 827

[[chapters]]
title = "Section Characteristics"
time = "00:15:18"
start = 918

[[chapters]]
title = "Relocation Structure and AMD64 Types"
time = "00:18:39"
start = 1119

[[chapters]]
title = "Relative Relocations and Implicit Addends"
time = "00:20:47"
start = 1247

[[chapters]]
title = "Symbol Table and Long Names"
time = "00:24:00"
start = 1440

[[chapters]]
title = "Symbol Type Constants"
time = "00:28:13"
start = 1693

[[chapters]]
title = "Storage Classes"
time = "00:31:05"
start = 1865

[[chapters]]
title = "String Table Helper"
time = "00:33:17"
start = 1997

[[chapters]]
title = "Checking Signed Section Numbers"
time = "00:34:35"
start = 2075
+++

I gather COFF data structures and constants from Microsoft's PE format documentation in preparation for writing Windows object files for link.exe. I cover file and section headers, AMD64 relocations, symbols, and the string table, including differences from ELF and how COFF handles long names and relocation addends.
