+++
title = "Symbol Resolution and Constant Expression Evaluation"
description = "I start the assembler's semantic analysis with a resolver that maps AST nodes to symbols. I add symbol and type representations, scopes with parent lookup, and annotated AST output for resolver tests. I then implement constant expression evaluation for integer literals, identifiers and binary arithmetic, cache values on symbols, and fix symbol storage and identifier resolution while keeping undefined-symbol errors in the resolution pass."
date = "2026-10-06T02:57:29Z"
duration = 2360
weight = 81
youtube_id = "nfPdNbktxDw"
collection = "compiler_toolchain"

[[chapters]]
title = "Planning the Semantic Analysis Pass"
time = "00:00:00"
start = 0

[[chapters]]
title = "Defining the Resolver and Symbol Kinds"
time = "00:00:56"
start = 56

[[chapters]]
title = "Caching Constant Values and Representing Types"
time = "00:02:56"
start = 176

[[chapters]]
title = "Initialising the Resolver and Collecting Errors"
time = "00:05:41"
start = 341

[[chapters]]
title = "Traversing Declarations with ResolveNode"
time = "00:07:57"
start = 477

[[chapters]]
title = "Setting Up Resolver Tests"
time = "00:08:56"
start = 536

[[chapters]]
title = "Adding Symbol Information to AST Printing"
time = "00:10:17"
start = 617

[[chapters]]
title = "Fixing Type Definitions and Formatting Array Types"
time = "00:13:56"
start = 836

[[chapters]]
title = "Writing the First Constant Resolution Test"
time = "00:15:38"
start = 938

[[chapters]]
title = "Adding Scopes and Symbol Definitions"
time = "00:16:23"
start = 983

[[chapters]]
title = "Looking Up Symbols Through Parent Scopes"
time = "00:19:47"
start = 1187

[[chapters]]
title = "Resolving Constants in Declaration Order"
time = "00:21:03"
start = 1263

[[chapters]]
title = "Mapping Declaration Names to Symbols"
time = "00:23:54"
start = 1434

[[chapters]]
title = "Testing a Constant That References Another Constant"
time = "00:24:19"
start = 1459

[[chapters]]
title = "Evaluating Integer Constant Expressions"
time = "00:24:52"
start = 1492

[[chapters]]
title = "Evaluating Binary Arithmetic and Unsigned Division"
time = "00:29:30"
start = 1770

[[chapters]]
title = "Looking Up Cached Constant Values"
time = "00:32:01"
start = 1921

[[chapters]]
title = "Fixing Missing Symbols in the Scope Map"
time = "00:33:48"
start = 2028

[[chapters]]
title = "Resolving Identifiers Inside Expressions"
time = "00:34:29"
start = 2069

[[chapters]]
title = "Moving Undefined-Symbol Errors into Resolution"
time = "00:36:32"
start = 2192

[[chapters]]
title = "Checking the Passing Tests and Annotated Output"
time = "00:38:25"
start = 2305
+++

I start the assembler's semantic analysis with a resolver that maps AST nodes to symbols. I add symbol and type representations, scopes with parent lookup, and annotated AST output for resolver tests. I then implement constant expression evaluation for integer literals, identifiers and binary arithmetic, cache values on symbols, and fix symbol storage and identifier resolution while keeping undefined-symbol errors in the resolution pass.
