+++
title = "Resolving Array Types and Inferring Lengths"
description = "I extend the assembler's resolver to handle array types, evaluate explicit lengths and infer lengths from simple initialiser lists. I separate type resolution from symbol lookup, add size and alignment helpers, and update the annotated AST output for nested arrays while debugging a recursive size calculation. I also support forward references to imported symbols, add predefined data section mappings, evaluate grouped expressions and unary plus and minus, and reset the resolver's state between runs. Nested inferred array lengths and further validation are left for later."
date = "2026-10-09"
duration = 2257
weight = 85
youtube_id = "f78l1CnFHT4"
collection = "compiler_toolchain"

[[chapters]]
title = "Supporting Forward References to Imported Symbols"
time = "00:00:00"
start = 0

[[chapters]]
title = "Testing Array Types with Explicit Lengths"
time = "00:01:37"
start = 97

[[chapters]]
title = "Separating Type Resolution from Symbol Lookup"
time = "00:03:23"
start = 203

[[chapters]]
title = "Returning an Invalid Type Instead of Nil"
time = "00:05:41"
start = 341

[[chapters]]
title = "Resolving Array Element Types and Length Expressions"
time = "00:07:33"
start = 453

[[chapters]]
title = "Resolving Names Within Array Lengths"
time = "00:08:37"
start = 517

[[chapters]]
title = "Printing Types as S-Expressions"
time = "00:09:16"
start = 556

[[chapters]]
title = "Testing Nested Arrays and Constant Length Expressions"
time = "00:11:51"
start = 711

[[chapters]]
title = "Testing Inferred Lengths with a String Initialiser"
time = "00:12:57"
start = 777

[[chapters]]
title = "Handling Ellipsis Array Lengths"
time = "00:14:25"
start = 865

[[chapters]]
title = "Rejecting Explicit Zero-Length Arrays"
time = "00:16:40"
start = 1000

[[chapters]]
title = "Inferring Array Lengths from Initialiser Lists"
time = "00:17:37"
start = 1057

[[chapters]]
title = "Counting Number and String Initialisers"
time = "00:21:00"
start = 1260

[[chapters]]
title = "Adding Type Alignment and Size Helpers"
time = "00:22:48"
start = 1368

[[chapters]]
title = "Checking the Inferred Array Length"
time = "00:24:59"
start = 1499

[[chapters]]
title = "Including Array Sizes in the AST Output"
time = "00:26:11"
start = 1571

[[chapters]]
title = "Fixing a Recursive Size Calculation"
time = "00:27:23"
start = 1643

[[chapters]]
title = "Deferring Nested Inferred Lengths and Validation"
time = "00:27:55"
start = 1675

[[chapters]]
title = "Adding Predefined Data Section Mappings"
time = "00:28:44"
start = 1724

[[chapters]]
title = "Testing Grouped Expressions and Unary Operators"
time = "00:30:53"
start = 1853

[[chapters]]
title = "Evaluating Groups and Unary Plus and Minus"
time = "00:32:40"
start = 1960

[[chapters]]
title = "Fixing Token References and Expected AST Output"
time = "00:34:10"
start = 2050

[[chapters]]
title = "Deferring Division-by-Zero Error Tests"
time = "00:35:44"
start = 2144

[[chapters]]
title = "Resetting Resolver State Between Runs"
time = "00:36:22"
start = 2182

[[chapters]]
title = "Next Steps for Nested Inferred Array Lengths"
time = "00:37:04"
start = 2224
+++

I extend the assembler's resolver to handle array types, evaluate explicit lengths and infer lengths from simple initialiser lists. I separate type resolution from symbol lookup, add size and alignment helpers, and update the annotated AST output for nested arrays while debugging a recursive size calculation. I also support forward references to imported symbols, add predefined data section mappings, evaluate grouped expressions and unary plus and minus, and reset the resolver's state between runs. Nested inferred array lengths and further validation are left for later.
