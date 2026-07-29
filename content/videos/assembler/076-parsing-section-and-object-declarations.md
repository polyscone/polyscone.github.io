+++
title = "Parsing Section and Object Declarations"
description = "I add parsing for section and object declarations, including optional section alignment, array types with explicit or inferred lengths, and list initialisers. I extend the AST, its formatting, and traversal, add token-consumption checks and parser errors with line and column numbers, then implement string literals with newline escapes and fix multiline list parsing."
date = "2026-09-24T05:12:53Z"
duration = 2483
weight = 76
youtube_id = "mxFTuzCJ15s"
collection = "compiler_toolchain"

[[chapters]]
title = "Designing Section and Object Parser Tests"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding AST Nodes and Source Spans"
time = "00:03:37"
start = 217

[[chapters]]
title = "Formatting the New AST Nodes"
time = "00:07:40"
start = 460

[[chapters]]
title = "Adding Ellipsis Nodes and AST Traversal"
time = "00:11:06"
start = 666

[[chapters]]
title = "Checking Expected Tokens with a Consume Helper"
time = "00:14:38"
start = 878

[[chapters]]
title = "Collecting Parser Errors with Line and Column Numbers"
time = "00:18:10"
start = 1090

[[chapters]]
title = "Reporting Unexpected Tokens"
time = "00:22:07"
start = 1327

[[chapters]]
title = "Parsing Sections and Optional Alignment"
time = "00:24:39"
start = 1479

[[chapters]]
title = "Parsing Object Declarations"
time = "00:27:16"
start = 1636

[[chapters]]
title = "Parsing Types, Arrays, and Ellipses"
time = "00:28:43"
start = 1723

[[chapters]]
title = "Parsing List Initialisers"
time = "00:32:18"
start = 1938

[[chapters]]
title = "Parsing String Literals and Escape Sequences"
time = "00:35:00"
start = 2100

[[chapters]]
title = "Fixing Multiline Lists and Checking Errors"
time = "00:39:57"
start = 2397
+++

I add parsing for section and object declarations, including optional section alignment, array types with explicit or inferred lengths, and list initialisers. I extend the AST, its formatting, and traversal, add token-consumption checks and parser errors with line and column numbers, then implement string literals with newline escapes and fix multiline list parsing.
