+++
title = "Resolving Forward References for Labels, Functions, and Objects"
description = "I add a declaration pass to the assembler's resolver so labels, functions and objects can be referenced before they appear in the source. I fix constant expression evaluation to run before declaring the constant's symbol, pre-declare symbols in global and block scopes, and debug a recursive call and missing AST symbol associations. I then resolve names inside memory and sized operands and add support for labels attached to align statements."
date = "2026-10-08"
duration = 1306
weight = 84
youtube_id = "0Ob4116rCjU"
collection = "compiler_toolchain"

[[chapters]]
title = "Evaluating Constants Before Declaring Their Symbols"
time = "00:00:00"
start = 0

[[chapters]]
title = "Renaming Scope Define to Declare"
time = "00:01:03"
start = 63

[[chapters]]
title = "Planning Labels and Forward References"
time = "00:01:47"
start = 107

[[chapters]]
title = "Writing a Forward Label Reference Test"
time = "00:02:45"
start = 165

[[chapters]]
title = "Splitting Declaration and Resolution into Two Passes"
time = "00:03:44"
start = 224

[[chapters]]
title = "Pre-Declaring Functions in the Global Scope"
time = "00:05:23"
start = 323

[[chapters]]
title = "Looking Up Functions During Resolution"
time = "00:06:23"
start = 383

[[chapters]]
title = "Pre-Declaring Objects"
time = "00:07:07"
start = 427

[[chapters]]
title = "Declaring Labels Within Block Scopes"
time = "00:08:21"
start = 501

[[chapters]]
title = "Fixing Unused Symbols and Object Type Assignment"
time = "00:09:47"
start = 587

[[chapters]]
title = "Debugging a Stack Overflow in Block Resolution"
time = "00:10:51"
start = 651

[[chapters]]
title = "Fixing Missing Label Symbol Information"
time = "00:11:27"
start = 687

[[chapters]]
title = "Moving AST Symbol Associations into the Declaration Pass"
time = "00:12:37"
start = 757

[[chapters]]
title = "Testing Forward References to Objects and Functions"
time = "00:14:14"
start = 854

[[chapters]]
title = "Testing Memory and Sized Operand Expressions"
time = "00:15:13"
start = 913

[[chapters]]
title = "Using a Constant to Check Nested Name Resolution"
time = "00:17:14"
start = 1034

[[chapters]]
title = "Recursing into Memory and Sized Nodes"
time = "00:17:59"
start = 1079

[[chapters]]
title = "Handling Labels Attached to Align Statements"
time = "00:19:09"
start = 1149

[[chapters]]
title = "Declaring an Align Node's Label"
time = "00:20:21"
start = 1221

[[chapters]]
title = "Checking the Results and Next Steps"
time = "00:21:04"
start = 1264
+++

I add a declaration pass to the assembler's resolver so labels, functions and objects can be referenced before they appear in the source. I fix constant expression evaluation to run before declaring the constant's symbol, pre-declare symbols in global and block scopes, and debug a recursive call and missing AST symbol associations. I then resolve names inside memory and sized operands and add support for labels attached to align statements.
