+++
title = "Encoding EVEX Compressed Disp8 and Tuple Types"
description = "Implementing EVEX compressed disp8 encoding, where an 8-bit displacement is scaled by the instruction tuple type instead of representing a raw byte offset."
date = "2026-06-25T06:14:03Z"
duration = 2297
weight = 22
youtube_id = "8dvh-1A9G5Q"
collection = "compiler_toolchain"

[[chapters]]
title = "EVEX Compressed Disp8 Explanation & Examples"
time = "00:00:00"
start = 0

[[chapters]]
title = "EVEX Tuple Types"
time = "00:09:21"
start = 561

[[chapters]]
title = "Test Cases"
time = "00:14:51"
start = 891

[[chapters]]
title = "Implementation"
time = "00:28:19"
start = 1699

[[chapters]]
title = "Quick Fix"
time = "00:37:33"
start = 2253
+++

Implementing EVEX compressed disp8 encoding, where an 8-bit displacement is scaled by the instruction tuple type instead of representing a raw byte offset.

Encoding concepts covered include EVEX compressed disp8, tuple types, full-vector memory tuples, broadcast tuples, scalar tuples, displacement scaling, and fallback to disp32.
