+++
title = "Building a Scanner"
description = "Start the Fyn compiler in Go by defining source files and tokens, then scanning keywords, identifiers, integers, punctuation, and source locations."
date = "2025-08-14T14:23:32Z"
duration = 2072
weight = 1
youtube_id = "yFV8zv6bluU"
collection = "compiler_from_scratch"

[[chapters]]
title = "Introducing Fyn and its token representation"
time = "00:00:00"
start = 0

[[chapters]]
title = "Defining token kinds"
time = "00:01:32"
start = 92

[[chapters]]
title = "Printing and serializing tokens"
time = "00:02:41"
start = 161

[[chapters]]
title = "Storing source text in a token file"
time = "00:04:17"
start = 257

[[chapters]]
title = "Designing the scanner state"
time = "00:05:35"
start = 335

[[chapters]]
title = "Reading and peeking at source bytes"
time = "00:07:14"
start = 434

[[chapters]]
title = "Scanning one token at a time"
time = "00:08:02"
start = 482

[[chapters]]
title = "Consuming the complete token stream"
time = "00:09:31"
start = 571

[[chapters]]
title = "Building table-driven scanner tests"
time = "00:10:28"
start = 628

[[chapters]]
title = "Comparing expected and actual tokens"
time = "00:12:00"
start = 720

[[chapters]]
title = "Skipping whitespace with readWhile"
time = "00:15:21"
start = 921

[[chapters]]
title = "Defining character predicates"
time = "00:18:00"
start = 1080

[[chapters]]
title = "Recognizing punctuation with a lookup table"
time = "00:19:30"
start = 1170

[[chapters]]
title = "Scanning integer literals"
time = "00:21:48"
start = 1308

[[chapters]]
title = "Scanning identifiers"
time = "00:22:59"
start = 1379

[[chapters]]
title = "Distinguishing keywords from identifiers"
time = "00:24:00"
start = 1440

[[chapters]]
title = "Testing token lexemes"
time = "00:25:38"
start = 1538

[[chapters]]
title = "Testing line and column locations"
time = "00:27:10"
start = 1630

[[chapters]]
title = "Indexing the start of every source line"
time = "00:31:18"
start = 1878

[[chapters]]
title = "Verifying the finished scanner"
time = "00:33:47"
start = 2027
+++

Start the Fyn compiler in Go by defining source files and tokens, then scanning keywords, identifiers, integers, punctuation, and source locations.
