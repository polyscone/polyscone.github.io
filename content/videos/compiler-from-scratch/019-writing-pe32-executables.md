+++
title = "Writing PE32+ Executables"
description = "Write a PE32+ image generator from the Windows specification, emit headers and sections, inspect the binary, and run generated x86-64 code as a native executable."
date = "2025-09-16T07:24:23Z"
duration = 6177
weight = 19
youtube_id = "BwcPKuHLUUo"
collection = "compiler_from_scratch"

[[chapters]]
title = "Planning a Windows PE32+ image writer"
time = "00:00:00"
start = 0

[[chapters]]
title = "PE and COFF terminology"
time = "00:01:53"
start = 113

[[chapters]]
title = "The PE file layout"
time = "00:02:51"
start = 171

[[chapters]]
title = "The MS-DOS stub"
time = "00:04:19"
start = 259

[[chapters]]
title = "The PE signature"
time = "00:06:52"
start = 412

[[chapters]]
title = "The COFF file header"
time = "00:07:34"
start = 454

[[chapters]]
title = "Designing the image-writer API"
time = "00:09:45"
start = 585

[[chapters]]
title = "Emitting the DOS stub and PE offset"
time = "00:12:40"
start = 760

[[chapters]]
title = "Writing the signature and COFF fields"
time = "00:15:23"
start = 923

[[chapters]]
title = "COFF machine and characteristic flags"
time = "00:18:28"
start = 1108

[[chapters]]
title = "The PE32+ optional header"
time = "00:23:44"
start = 1424

[[chapters]]
title = "Writing optional-header standard fields"
time = "00:28:56"
start = 1736

[[chapters]]
title = "Writing Windows-specific fields"
time = "00:36:42"
start = 2202

[[chapters]]
title = "Image base and section alignment"
time = "00:36:56"
start = 2216

[[chapters]]
title = "File alignment"
time = "00:40:00"
start = 2400

[[chapters]]
title = "Implementing alignment padding"
time = "00:41:55"
start = 2515

[[chapters]]
title = "Operating-system and image versions"
time = "00:45:24"
start = 2724

[[chapters]]
title = "Choosing the console subsystem"
time = "00:47:36"
start = 2856

[[chapters]]
title = "Calculating image and header sizes"
time = "00:50:38"
start = 3038

[[chapters]]
title = "DLL characteristics and security flags"
time = "00:57:58"
start = 3478

[[chapters]]
title = "Stack and heap reserve sizes"
time = "01:00:01"
start = 3601

[[chapters]]
title = "Data-directory entries"
time = "01:02:31"
start = 3751

[[chapters]]
title = "The section table"
time = "01:07:00"
start = 4020

[[chapters]]
title = "Building section headers"
time = "01:10:00"
start = 4200

[[chapters]]
title = "Encoding section names"
time = "01:11:48"
start = 4308

[[chapters]]
title = "Virtual sizes and addresses"
time = "01:13:11"
start = 4391

[[chapters]]
title = "Raw-data sizes and file pointers"
time = "01:14:54"
start = 4494

[[chapters]]
title = "Assigning adjacent virtual addresses"
time = "01:20:13"
start = 4813

[[chapters]]
title = "Section characteristics"
time = "01:21:14"
start = 4874

[[chapters]]
title = "Writing aligned section data"
time = "01:23:54"
start = 5034

[[chapters]]
title = "Finding the code entry point"
time = "01:28:41"
start = 5321

[[chapters]]
title = "Finalizing virtual-size calculations"
time = "01:32:20"
start = 5540

[[chapters]]
title = "Building and inspecting the executable"
time = "01:34:58"
start = 5698

[[chapters]]
title = "Fixing optional-header field widths"
time = "01:37:06"
start = 5826

[[chapters]]
title = "Verifying headers and running the file"
time = "01:38:26"
start = 5906

[[chapters]]
title = "Fixing section-header field widths"
time = "01:40:34"
start = 6034

[[chapters]]
title = "Executing the generated program successfully"
time = "01:41:53"
start = 6113
+++

Write a PE32+ image generator from the Windows specification, emit headers and sections, inspect the binary, and run generated x86-64 code as a native executable.
