+++
title = "Encoding LEA, ADD, and SUB"
description = "Grow the encoder beyond MOV by implementing LEA and shared ADD/SUB forms for registers, memory, immediates, and accumulator-specific opcodes."
date = "2025-09-08T05:48:56Z"
duration = 1511
weight = 16
youtube_id = "un9mANWML2A"
collection = "compiler_from_scratch"

[[chapters]]
title = "Reading the LEA encoding"
time = "00:00:00"
start = 0

[[chapters]]
title = "Reusing memory-source test cases"
time = "00:01:22"
start = 82

[[chapters]]
title = "Generating expected LEA bytes"
time = "00:03:00"
start = 180

[[chapters]]
title = "Normalizing RIP-relative disassembly"
time = "00:04:30"
start = 270

[[chapters]]
title = "Implementing LEA constraints and encoding"
time = "00:06:00"
start = 360

[[chapters]]
title = "Fixing scaled-index test parsing"
time = "00:07:30"
start = 450

[[chapters]]
title = "Suppressing the direction bit for LEA"
time = "00:09:00"
start = 540

[[chapters]]
title = "Reading ADD opcode forms"
time = "00:09:41"
start = 581

[[chapters]]
title = "Understanding immediate-width limits"
time = "00:11:42"
start = 702

[[chapters]]
title = "Building ADD test cases"
time = "00:13:30"
start = 810

[[chapters]]
title = "Selecting byte and full-width opcodes"
time = "00:15:00"
start = 900

[[chapters]]
title = "Encoding immediate destinations"
time = "00:16:30"
start = 990

[[chapters]]
title = "Handling accumulator forms without ModR/M"
time = "00:18:00"
start = 1080

[[chapters]]
title = "Applying accumulator opcode offsets"
time = "00:20:53"
start = 1253

[[chapters]]
title = "Reusing ADD logic for SUB"
time = "00:21:22"
start = 1282

[[chapters]]
title = "Running the completed arithmetic tests"
time = "00:24:00"
start = 1440
+++

Grow the encoder beyond MOV by implementing LEA and shared ADD/SUB forms for registers, memory, immediates, and accumulator-specific opcodes.
