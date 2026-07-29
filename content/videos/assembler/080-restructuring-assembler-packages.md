+++
title = "Restructuring Assembler Packages"
description = "I consolidate the scanner, parser, tokens and AST into a single assembler package before moving on to semantic analysis. I resolve name collisions, rename AST helpers and token types, and update the tests and imports. Along the way, I fix object spans to include alignment and attributes, organise parser test data into its own directory, and add a check that parser tests actually run."
date = "2026-10-05T03:29:49Z"
duration = 814
weight = 80
youtube_id = "hVkcIsIatgc"
collection = "compiler_toolchain"

[[chapters]]
title = "Combining the Assembler Packages"
time = "00:00:00"
start = 0

[[chapters]]
title = "Moving Source Files and Parser Test Data"
time = "00:00:41"
start = 41

[[chapters]]
title = "Updating Package Names"
time = "00:01:33"
start = 93

[[chapters]]
title = "Resolving the File Name Collision with Root"
time = "00:02:13"
start = 133

[[chapters]]
title = "Fixing Object Spans for Alignment and Attributes"
time = "00:02:53"
start = 173

[[chapters]]
title = "Renaming AST Helpers and Token Types"
time = "00:03:43"
start = 223

[[chapters]]
title = "Updating the Parser and Token References"
time = "00:05:23"
start = 323

[[chapters]]
title = "Updating Parser Test Imports and Constructors"
time = "00:06:43"
start = 403

[[chapters]]
title = "Updating the Scanner and Token Definitions"
time = "00:08:05"
start = 485

[[chapters]]
title = "Updating Scanner Tests"
time = "00:10:01"
start = 601

[[chapters]]
title = "Running Tests and Fixing Remaining References"
time = "00:10:58"
start = 658

[[chapters]]
title = "Checking Parser Test Discovery"
time = "00:11:29"
start = 689

[[chapters]]
title = "Restricting Tests to the Parser Directory"
time = "00:12:44"
start = 764
+++

I consolidate the scanner, parser, tokens and AST into a single assembler package before moving on to semantic analysis. I resolve name collisions, rename AST helpers and token types, and update the tests and imports. Along the way, I fix object spans to include alignment and attributes, organise parser test data into its own directory, and add a check that parser tests actually run.
