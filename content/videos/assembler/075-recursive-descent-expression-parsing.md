+++
title = "Recursive Descent Expression Parsing"
description = "I add recursive descent parsing for assembler expressions, using separate expression, term, and factor parsers to handle operator precedence, left associativity, and parentheses. I extend the AST with number, group, and binary nodes, then refine parser recovery and the comment-driven test runner to handle newlines, file nodes, and overlapping source offsets."
date = "2026-09-22T03:31:31Z"
duration = 2082
weight = 75
youtube_id = "fOSfFC3Vvsg"
collection = "compiler_toolchain"

[[chapters]]
title = "Testing Expression Precedence and Associativity"
time = "00:00:00"
start = 0

[[chapters]]
title = "Updating Number Tokens and AST Nodes"
time = "00:05:28"
start = 328

[[chapters]]
title = "Designing the Recursive Descent Grammar"
time = "00:07:28"
start = 448

[[chapters]]
title = "Parsing Binary Expressions and Terms"
time = "00:09:50"
start = 590

[[chapters]]
title = "Parsing Factors and Parenthesised Expressions"
time = "00:12:00"
start = 720

[[chapters]]
title = "Adding Group and Binary AST Nodes"
time = "00:16:44"
start = 1004

[[chapters]]
title = "Walking and Formatting Expression Nodes"
time = "00:17:55"
start = 1075

[[chapters]]
title = "Fixing AST Spans and Passing Expression Tests"
time = "00:19:52"
start = 1192

[[chapters]]
title = "Examining Overlapping Parser Test Offsets"
time = "00:21:23"
start = 1283

[[chapters]]
title = "Fixing Parser Token Advancement"
time = "00:24:27"
start = 1467

[[chapters]]
title = "Recovering at Newlines and Skipping Them Between Declarations"
time = "00:25:46"
start = 1546

[[chapters]]
title = "Skipping File Nodes and Duplicate Test Offsets"
time = "00:30:04"
start = 1804
+++

I add recursive descent parsing for assembler expressions, using separate expression, term, and factor parsers to handle operator precedence, left associativity, and parentheses. I extend the AST with number, group, and binary nodes, then refine parser recovery and the comment-driven test runner to handle newlines, file nodes, and overlapping source offsets.
