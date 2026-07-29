+++
title = "Parsing Import and Function Declarations"
description = "I add parsing for import and function declarations, including namespaced attributes, instruction blocks, labels, alignment statements, and memory operands. I extend the AST, its traversal, and s-expression formatting, handle typed nil pointers during traversal, then fix duplicate newline consumption and add optional width suffixes to identifiers, numbers, and memory expressions."
date = "2026-09-29T05:02:50Z"
duration = 3041
weight = 77
youtube_id = "BIlow-HSUqY"
collection = "compiler_toolchain"

[[chapters]]
title = "Adding Import Declarations"
time = "00:00:00"
start = 0

[[chapters]]
title = "Designing Function and Instruction Parser Tests"
time = "00:03:45"
start = 225

[[chapters]]
title = "Function Attributes and Object Format Namespaces"
time = "00:05:31"
start = 331

[[chapters]]
title = "Adding Function, Block, Label, and Instruction AST Nodes"
time = "00:11:02"
start = 662

[[chapters]]
title = "Handling Typed Nil Pointers in AST Traversal"
time = "00:15:40"
start = 940

[[chapters]]
title = "Formatting the New AST Nodes"
time = "00:19:29"
start = 1169

[[chapters]]
title = "Adding Sized Expression Nodes"
time = "00:21:08"
start = 1268

[[chapters]]
title = "Parsing Function Declarations and Attributes"
time = "00:26:26"
start = 1586

[[chapters]]
title = "Parsing Blocks and Alignment Statements"
time = "00:29:32"
start = 1772

[[chapters]]
title = "Parsing Instructions, Labels, and Arguments"
time = "00:33:24"
start = 2004

[[chapters]]
title = "Parsing Memory Operands"
time = "00:37:12"
start = 2232

[[chapters]]
title = "Fixing Compilation Errors and Debugging the Parser"
time = "00:39:29"
start = 2369

[[chapters]]
title = "Correcting Function Attribute Formatting"
time = "00:44:15"
start = 2655

[[chapters]]
title = "Fixing Duplicate Newline Consumption"
time = "00:45:02"
start = 2702

[[chapters]]
title = "Parsing Width Suffixes on Expressions"
time = "00:47:01"
start = 2821

[[chapters]]
title = "Passing the Tests and Next Steps"
time = "00:50:16"
start = 3016
+++

I add parsing for import and function declarations, including namespaced attributes, instruction blocks, labels, alignment statements, and memory operands. I extend the AST, its traversal, and s-expression formatting, handle typed nil pointers during traversal, then fix duplicate newline consumption and add optional width suffixes to identifiers, numbers, and memory expressions.
