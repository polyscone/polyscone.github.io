+++
title = "Resolving Nested Array Types"
description = "I extend the assembler's type resolver to support nested arrays with explicit and inferred lengths, using the largest initialiser at each dimension to infer its length. I pass initialisers through recursive type resolution, support direct string initialisers and count their UTF-8 bytes, then fix the parser to accept nested initialiser lists. I test nested strings and different element sizes, reject strings used with non-i8 arrays and initialisers that exceed explicit lengths, and turn constant division by zero into a resolver error instead of a Go panic."
date = "2026-10-09"
duration = 1758
weight = 86
youtube_id = "FwhwkUCQnVE"
collection = "compiler_toolchain"

[[chapters]]
title = "Planning Nested Arrays and Inferred Dimensions"
time = "00:00:00"
start = 0

[[chapters]]
title = "Testing a Direct String Initialiser"
time = "00:01:16"
start = 76

[[chapters]]
title = "Passing Initialisers into Type Resolution"
time = "00:01:52"
start = 112

[[chapters]]
title = "Collecting Child Initialisers for Recursive Resolution"
time = "00:03:17"
start = 197

[[chapters]]
title = "Resolving the Element Type Before Validation"
time = "00:04:10"
start = 250

[[chapters]]
title = "Separating Explicit and Inferred Lengths"
time = "00:04:57"
start = 297

[[chapters]]
title = "Counting List Elements and String Bytes"
time = "00:06:10"
start = 370

[[chapters]]
title = "Restricting String Initialisers to i8 Arrays"
time = "00:07:33"
start = 453

[[chapters]]
title = "Handling Direct Strings and Invalid Initialisers"
time = "00:10:17"
start = 617

[[chapters]]
title = "Inferring Maximum Lengths and Checking Explicit Bounds"
time = "00:11:26"
start = 686

[[chapters]]
title = "Fixing Undefined Names and Nil Initialisers"
time = "00:13:23"
start = 803

[[chapters]]
title = "Testing UTF-8 Byte Counts with Japanese Text"
time = "00:14:27"
start = 867

[[chapters]]
title = "Testing Multiple Strings in One Array"
time = "00:15:35"
start = 935

[[chapters]]
title = "Testing Explicit Outer and Inferred Inner Lengths"
time = "00:16:18"
start = 978

[[chapters]]
title = "Fixing Nested Initialiser List Parsing"
time = "00:17:49"
start = 1069

[[chapters]]
title = "Correcting the Resolver Test's Expected Array Size"
time = "00:19:56"
start = 1196

[[chapters]]
title = "Inferring Both Array Dimensions"
time = "00:20:20"
start = 1220

[[chapters]]
title = "Testing Nested String Initialisers"
time = "00:20:55"
start = 1255

[[chapters]]
title = "Checking Nested i16 Array Sizes"
time = "00:22:37"
start = 1357

[[chapters]]
title = "Testing Invalid String Element Types"
time = "00:23:56"
start = 1436

[[chapters]]
title = "Testing Initialisers That Exceed Explicit Lengths"
time = "00:25:45"
start = 1545

[[chapters]]
title = "Testing Excess Elements in Nested Arrays"
time = "00:26:49"
start = 1609

[[chapters]]
title = "Reporting Constant Division by Zero"
time = "00:27:24"
start = 1644

[[chapters]]
title = "Checking the Results and Next Steps"
time = "00:28:58"
start = 1738
+++

I extend the assembler's type resolver to support nested arrays with explicit and inferred lengths, using the largest initialiser at each dimension to infer its length. I pass initialisers through recursive type resolution, support direct string initialisers and count their UTF-8 bytes, then fix the parser to accept nested initialiser lists. I test nested strings and different element sizes, reject strings used with non-i8 arrays and initialisers that exceed explicit lengths, and turn constant division by zero into a resolver error instead of a Go panic.
