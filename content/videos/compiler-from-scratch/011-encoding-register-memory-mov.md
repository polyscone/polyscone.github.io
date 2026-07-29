+++
title = "Encoding Register/Memory MOV"
description = "Extend MOV encoding to register-to-memory and memory-to-register operations, including the special RSP/R12 SIB and RBP/R13 displacement forms."
date = "2025-09-02T04:22:18Z"
duration = 1803
weight = 11
youtube_id = "_Q0A6imwIaw"
collection = "compiler_from_scratch"

[[chapters]]
title = "Planning memory-address MOV encoding"
time = "00:00:00"
start = 0

[[chapters]]
title = "RSP/R12 and RBP/R13 special cases"
time = "00:00:58"
start = 58

[[chapters]]
title = "Building register-to-memory tests"
time = "00:02:42"
start = 162

[[chapters]]
title = "Marking operands as memory accesses"
time = "00:06:00"
start = 360

[[chapters]]
title = "Implementing the memory-operand helper"
time = "00:09:00"
start = 540

[[chapters]]
title = "Assigning source and destination operands"
time = "00:10:21"
start = 621

[[chapters]]
title = "Selecting direct or indirect ModR/M mode"
time = "00:11:42"
start = 702

[[chapters]]
title = "Fixing operand flag-mask checks"
time = "00:13:30"
start = 810

[[chapters]]
title = "Tagging stack- and base-pointer memory forms"
time = "00:14:53"
start = 893

[[chapters]]
title = "Marking operands that require SIB"
time = "00:16:30"
start = 990

[[chapters]]
title = "Constructing the no-index SIB byte"
time = "00:17:48"
start = 1068

[[chapters]]
title = "Encoding a zero displacement for RBP/R13"
time = "00:20:47"
start = 1247

[[chapters]]
title = "Packing displacement metadata"
time = "00:22:08"
start = 1328

[[chapters]]
title = "Emitting displacement bytes"
time = "00:23:52"
start = 1432

[[chapters]]
title = "Reversing tests for memory-to-register MOV"
time = "00:24:32"
start = 1472

[[chapters]]
title = "Comparing the two MOV opcodes"
time = "00:25:30"
start = 1530

[[chapters]]
title = "Setting the opcode direction bit"
time = "00:27:00"
start = 1620

[[chapters]]
title = "Passing register/memory tests"
time = "00:29:17"
start = 1757
+++

Extend MOV encoding to register-to-memory and memory-to-register operations, including the special RSP/R12 SIB and RBP/R13 displacement forms.
