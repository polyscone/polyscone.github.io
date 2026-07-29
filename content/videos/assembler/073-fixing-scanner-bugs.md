+++
title = "Fixing Scanner Bugs"
description = "I clean up the scanner API, then add regression tests and fix bugs in ellipsis detection, comment trivia at the end of a file, and unterminated string literals. I correct how EOF handles leading and inline trivia, prevent the scanner cursor from moving beyond the source, and return invalid tokens for strings that reach a newline or EOF without a closing delimiter."
date = "2026-09-19T05:48:54Z"
duration = 684
weight = 73
youtube_id = "9ptPtAgB1FQ"
collection = "compiler_toolchain"

[[chapters]]
title = "Cleaning Up the Scanner API"
time = "00:00:00"
start = 0

[[chapters]]
title = "Fixing Ellipsis Detection"
time = "00:02:04"
start = 124

[[chapters]]
title = "Testing Comment Trivia at EOF"
time = "00:03:56"
start = 236

[[chapters]]
title = "Fixing Leading and Inline Trivia at EOF"
time = "00:07:15"
start = 435

[[chapters]]
title = "Testing Unterminated String Literals"
time = "00:08:47"
start = 527

[[chapters]]
title = "Preventing Out-of-Bounds Cursor Positions"
time = "00:09:38"
start = 578

[[chapters]]
title = "Returning Invalid Tokens for Unterminated Strings"
time = "00:10:17"
start = 617
+++

I clean up the scanner API, then add regression tests and fix bugs in ellipsis detection, comment trivia at the end of a file, and unterminated string literals. I correct how EOF handles leading and inline trivia, prevent the scanner cursor from moving beyond the source, and return invalid tokens for strings that reach a newline or EOF without a closing delimiter.
