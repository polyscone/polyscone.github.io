+++
title = "Resolving Imports, Functions, and Aligns"
description = "I extend the assembler's resolver to handle object alignment, standalone align statements, imports and function bodies. I cache evaluated alignments and add parser support for top-level align statements. I then mark imported function and object symbols, resolve instruction arguments within block scopes, and add built-in register symbols before updating the annotated AST output and resolver tests."
date = "2026-10-08"
duration = 1609
weight = 83
youtube_id = "nhwFxvYKOSs"
collection = "compiler_toolchain"

[[chapters]]
title = "Reviewing the Resolver To-Do List"
time = "00:00:00"
start = 0

[[chapters]]
title = "Testing Object and Section Alignment"
time = "00:01:18"
start = 78

[[chapters]]
title = "Resolving Object Alignment and Updating the Section"
time = "00:03:01"
start = 181

[[chapters]]
title = "Caching Evaluated Alignments on the Resolver"
time = "00:04:19"
start = 259

[[chapters]]
title = "Printing Alignment Values in the AST"
time = "00:05:31"
start = 331

[[chapters]]
title = "Parsing Top-Level Align Statements"
time = "00:06:55"
start = 415

[[chapters]]
title = "Testing Standalone Alignment Resolution"
time = "00:07:58"
start = 478

[[chapters]]
title = "Moving Alignment Evaluation into ResolveNode"
time = "00:08:25"
start = 505

[[chapters]]
title = "Fixing Align Node References"
time = "00:10:12"
start = 612

[[chapters]]
title = "Planning Function and Object Imports"
time = "00:11:02"
start = 662

[[chapters]]
title = "Writing Import and Instruction Resolution Tests"
time = "00:11:46"
start = 706

[[chapters]]
title = "Defining Imported Symbols"
time = "00:15:40"
start = 940

[[chapters]]
title = "Adding the Imported Flag"
time = "00:18:26"
start = 1106

[[chapters]]
title = "Resolving Instruction Arguments"
time = "00:18:52"
start = 1132

[[chapters]]
title = "Resolving Function Names and Bodies"
time = "00:19:53"
start = 1193

[[chapters]]
title = "Creating Scopes for Blocks"
time = "00:21:02"
start = 1262

[[chapters]]
title = "Adding Built-in Register Symbols"
time = "00:21:46"
start = 1306

[[chapters]]
title = "Defining the Register Symbol Kind"
time = "00:23:51"
start = 1431

[[chapters]]
title = "Updating Section and Import Information in Tests"
time = "00:24:14"
start = 1454

[[chapters]]
title = "Printing the Imported Flag in the AST"
time = "00:24:47"
start = 1487
+++

I extend the assembler's resolver to handle object alignment, standalone align statements, imports and function bodies. I cache evaluated alignments and add parser support for top-level align statements. I then mark imported function and object symbols, resolve instruction arguments within block scopes, and add built-in register symbols before updating the annotated AST output and resolver tests.
