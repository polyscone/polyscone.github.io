+++
title = "Building a Type Checker"
description = "Parse function return types and return statements, then build an interned type system and annotate expression nodes with checked types."
date = "2025-08-19T06:06:37Z"
duration = 2618
weight = 5
youtube_id = "24_SQQfbHpI"
collection = "compiler_from_scratch"

[[chapters]]
title = "Planning returns and type checking"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding return-statement fixtures"
time = "00:02:00"
start = 120

[[chapters]]
title = "Suppressing duplicate diagnostics per line"
time = "00:03:42"
start = 222

[[chapters]]
title = "Parsing function return types"
time = "00:06:00"
start = 360

[[chapters]]
title = "Parsing type hints"
time = "00:09:22"
start = 562

[[chapters]]
title = "Accepting return statements in expression positions"
time = "00:11:44"
start = 704

[[chapters]]
title = "Creating the return-statement AST node"
time = "00:13:44"
start = 824

[[chapters]]
title = "Parsing comma-separated return expressions"
time = "00:15:54"
start = 954

[[chapters]]
title = "Printing and walking return statements"
time = "00:18:16"
start = 1096

[[chapters]]
title = "Designing interned compiler types"
time = "00:19:45"
start = 1185

[[chapters]]
title = "Building the thread-safe type cache"
time = "00:21:43"
start = 1303

[[chapters]]
title = "Defining basic integer types"
time = "00:24:00"
start = 1440

[[chapters]]
title = "Scaffolding the checker"
time = "00:26:00"
start = 1560

[[chapters]]
title = "Designing typed AST snapshots"
time = "00:28:00"
start = 1680

[[chapters]]
title = "Recursively checking nodes"
time = "00:30:00"
start = 1800

[[chapters]]
title = "Caching a type for each AST node"
time = "00:31:46"
start = 1906

[[chapters]]
title = "Handling non-expression nodes"
time = "00:35:48"
start = 2148

[[chapters]]
title = "Checking binary operand types"
time = "00:39:11"
start = 2351

[[chapters]]
title = "Propagating default integer types"
time = "00:42:00"
start = 2520
+++

Parse function return types and return statements, then build an interned type system and annotate expression nodes with checked types.
