+++
title = "Fixing Scanner and Parser Bugs"
description = "I work through scanner and parser bugs before moving on to semantic analysis. I switch source storage to a byte slice, fix EOF handling and empty-file trivia, and support escaped quotes and backslashes in strings. I then improve parser recovery with synthetic tokens and configurable stopping points, extract a helper for width suffixes, require newlines after declarations, and fix an infinite loop when parsing invalid function attributes."
date = "2026-10-01T05:41:20Z"
duration = 3285
weight = 78
youtube_id = "MjJDSqJay18"
collection = "compiler_toolchain"

[[chapters]]
title = "Reviewing Scanner and Parser Fixes"
time = "00:00:00"
start = 0

[[chapters]]
title = "Storing Source as a Byte Slice"
time = "00:00:38"
start = 38

[[chapters]]
title = "Replacing the Scanner's EOF Sentinel"
time = "00:02:14"
start = 134

[[chapters]]
title = "Returning Early When Reading at EOF"
time = "00:04:02"
start = 242

[[chapters]]
title = "Fixing Empty-File Trivia Ranges"
time = "00:04:34"
start = 274

[[chapters]]
title = "Scanning Escaped Quotes and Backslashes"
time = "00:06:33"
start = 393

[[chapters]]
title = "Parsing String Escape Sequences"
time = "00:12:23"
start = 743

[[chapters]]
title = "Fixing Parser Advancement at EOF"
time = "00:13:33"
start = 813

[[chapters]]
title = "Recovering Without Consuming Unexpected Tokens"
time = "00:18:53"
start = 1133

[[chapters]]
title = "Testing Parser Errors and Missing-Comma Recovery"
time = "00:26:50"
start = 1610

[[chapters]]
title = "Extracting a Sized Expression Helper"
time = "00:34:32"
start = 2072

[[chapters]]
title = "Adding Configurable Parser Recovery Points"
time = "00:36:14"
start = 2174

[[chapters]]
title = "Stopping Function Attributes at Newlines"
time = "00:39:28"
start = 2368

[[chapters]]
title = "Requiring Newlines After Declarations"
time = "00:40:54"
start = 2454

[[chapters]]
title = "Checking Statement Newline Handling"
time = "00:45:28"
start = 2728

[[chapters]]
title = "Checking Directory-Walk Errors in Tests"
time = "00:48:46"
start = 2926

[[chapters]]
title = "Reproducing an Infinite Loop in Attribute Parsing"
time = "00:49:39"
start = 2979

[[chapters]]
title = "Ensuring Parser Progress"
time = "00:53:09"
start = 3189
+++

I work through scanner and parser bugs before moving on to semantic analysis. I switch source storage to a byte slice, fix EOF handling and empty-file trivia, and support escaped quotes and backslashes in strings. I then improve parser recovery with synthetic tokens and configurable stopping points, extract a helper for width suffixes, require newlines after declarations, and fix an infinite loop when parsing invalid function attributes.
