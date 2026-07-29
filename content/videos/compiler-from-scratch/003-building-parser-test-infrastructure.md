+++
title = "Building Parser Test Infrastructure"
description = "Create readable AST snapshots and source-embedded parser fixtures using trivia, node spans, tree walking, and automated expected-output comparisons."
date = "2025-08-15T07:25:32Z"
duration = 2984
weight = 3
youtube_id = "p8SpOSzx0-M"
collection = "compiler_from_scratch"

[[chapters]]
title = "Replacing JSON output with S-expressions"
time = "00:00:00"
start = 0

[[chapters]]
title = "Implementing the AST printer"
time = "00:00:26"
start = 26

[[chapters]]
title = "Keeping integer lexemes in the AST"
time = "00:02:59"
start = 179

[[chapters]]
title = "Planning source-embedded parser tests"
time = "00:05:32"
start = 332

[[chapters]]
title = "Preserving comments as trivia"
time = "00:07:46"
start = 466

[[chapters]]
title = "Separating trivia from parser tokens"
time = "00:10:00"
start = 600

[[chapters]]
title = "Querying leading trivia by source offset"
time = "00:12:57"
start = 777

[[chapters]]
title = "Mapping tokens to trivia ranges"
time = "00:15:00"
start = 900

[[chapters]]
title = "Distinguishing inline trivia"
time = "00:20:21"
start = 1221

[[chapters]]
title = "Emitting newline tokens"
time = "00:22:55"
start = 1375

[[chapters]]
title = "Walking the AST"
time = "00:26:27"
start = 1587

[[chapters]]
title = "Adding source spans to leaf nodes"
time = "00:29:53"
start = 1793

[[chapters]]
title = "Inspecting complete node lexemes"
time = "00:32:30"
start = 1950

[[chapters]]
title = "Avoiding duplicate nested-node comments"
time = "00:37:54"
start = 2274

[[chapters]]
title = "Parsing want directives from comments"
time = "00:40:38"
start = 2438

[[chapters]]
title = "Moving fixtures into parser tests"
time = "00:43:01"
start = 2581

[[chapters]]
title = "Running scanner, parser, and snapshot checks"
time = "00:45:00"
start = 2700

[[chapters]]
title = "Fixing the final output comparison"
time = "00:47:50"
start = 2870
+++

Create readable AST snapshots and source-embedded parser fixtures using trivia, node spans, tree walking, and automated expected-output comparisons.
