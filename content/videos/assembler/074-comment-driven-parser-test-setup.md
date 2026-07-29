+++
title = "Comment-Driven Parser Test Setup"
description = "I set up parser tests that put expected AST output as s-expression comments beside assembler source. I build a test runner that scans source files, matches leading comment trivia to AST nodes, and compares the expected text with formatted nodes. I then add initial AST types and traversal, implement a simple parser for const declarations and integer expressions, and get the first two tests passing."
date = "2026-09-21T06:20:03Z"
duration = 2270
weight = 74
youtube_id = "Ek7DFi6tnqo"
collection = "compiler_toolchain"

[[chapters]]
title = "Designing Comment-Driven Parser Tests"
time = "00:00:00"
start = 0

[[chapters]]
title = "Walking Test Data Files and Scanning Source"
time = "00:02:44"
start = 164

[[chapters]]
title = "Matching Leading Trivia to AST Nodes"
time = "00:04:46"
start = 286

[[chapters]]
title = "Reading Expected S-Expressions from Comments"
time = "00:06:27"
start = 387

[[chapters]]
title = "Comparing AST Output and Counting Test Cases"
time = "00:09:42"
start = 582

[[chapters]]
title = "Defining AST Nodes and Source Spans"
time = "00:12:37"
start = 757

[[chapters]]
title = "Walking and Formatting the AST"
time = "00:17:55"
start = 1075

[[chapters]]
title = "Building the Parser and Token Cursor"
time = "00:23:52"
start = 1432

[[chapters]]
title = "Parsing Const Declarations and Integer Expressions"
time = "00:30:28"
start = 1828

[[chapters]]
title = "Fixing Parser Initialisation and Passing the Tests"
time = "00:35:26"
start = 2126
+++

I set up parser tests that put expected AST output as s-expression comments beside assembler source. I build a test runner that scans source files, matches leading comment trivia to AST nodes, and compares the expected text with formatted nodes. I then add initial AST types and traversal, implement a simple parser for const declarations and integer expressions, and get the first two tests passing.
