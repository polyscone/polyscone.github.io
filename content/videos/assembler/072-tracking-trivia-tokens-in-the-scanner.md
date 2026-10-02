+++
title = "Tracking Trivia Tokens in the Scanner"
description = "I add support for tracking comment trivia in the assembler's scanner, including leading comments, inline comments, and comments before the end-of-file token. I store trivia separately from significant tokens and associate it with source offsets so it can later be used for formatting and compact parser tests."
date = "2026-09-18T06:25:31Z"
duration = 1864
weight = 72
youtube_id = "FoYM5BRizMc"
collection = "compiler_toolchain"

[[chapters]]
title = "Why Track Trivia Tokens?"
time = "00:00:00"
start = 0

[[chapters]]
title = "Designing Trivia Tests"
time = "00:03:34"
start = 214

[[chapters]]
title = "Storing and Querying Trivia"
time = "00:11:03"
start = 663

[[chapters]]
title = "Scanning Comments as Trivia Tokens"
time = "00:17:41"
start = 1061

[[chapters]]
title = "Distinguishing Leading and Inline Trivia"
time = "00:24:30"
start = 1470

[[chapters]]
title = "Completing the Test Cases"
time = "00:29:39"
start = 1779
+++

I add support for tracking comment trivia in the assembler's scanner, including leading comments, inline comments, and comments before the end-of-file token. I store trivia separately from significant tokens and associate it with source offsets so it can later be used for formatting and compact parser tests.
