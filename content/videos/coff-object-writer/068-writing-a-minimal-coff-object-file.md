+++
title = "Writing a Minimal COFF Object File"
description = "I implement a minimal COFF object file writer with file and section headers, aligned section data, a basic symbol table, and an empty string table. I inspect the output with dumpbin, link a small program with link.exe that returns 123, then correct the handling of .bss section sizes."
date = "2026-09-08T05:54:40Z"
duration = 2474
weight = 68
youtube_id = "9k3SoSFmH1A"
aliases = ["/videos/compiler-toolchain/068-writing-a-minimal-coff-object-file/"]
collection = "compiler_toolchain"

[[chapters]]
title = "COFF File and Section API"
time = "00:00:00"
start = 0

[[chapters]]
title = "Section and Symbol Types"
time = "00:02:41"
start = 161

[[chapters]]
title = "Refactoring the ELF Test Program"
time = "00:05:43"
start = 343

[[chapters]]
title = "Creating a Minimal COFF Test Program"
time = "00:08:26"
start = 506

[[chapters]]
title = "Adding an Entry Symbol"
time = "00:11:29"
start = 689

[[chapters]]
title = "Planning the COFF File Layout"
time = "00:13:34"
start = 814

[[chapters]]
title = "Calculating Header Sizes and Section Offsets"
time = "00:16:24"
start = 984

[[chapters]]
title = "Writing File and Section Headers"
time = "00:18:16"
start = 1096

[[chapters]]
title = "Section Data Alignment and Padding"
time = "00:21:51"
start = 1311

[[chapters]]
title = "Section Sizes and Header Fields"
time = "00:25:17"
start = 1517

[[chapters]]
title = "Writing Symbol and String Tables"
time = "00:30:34"
start = 1834

[[chapters]]
title = "Fixing Compilation Errors"
time = "00:35:05"
start = 2105

[[chapters]]
title = "Inspecting the Object with dumpbin"
time = "00:37:33"
start = 2253

[[chapters]]
title = "Linking and Running the Program"
time = "00:38:14"
start = 2294

[[chapters]]
title = "Correcting .bss Section Sizes"
time = "00:39:08"
start = 2348
+++

I implement a minimal COFF object file writer with file and section headers, aligned section data, a basic symbol table, and an empty string table. I inspect the output with dumpbin, link a small program with link.exe that returns 123, then correct the handling of .bss section sizes.
