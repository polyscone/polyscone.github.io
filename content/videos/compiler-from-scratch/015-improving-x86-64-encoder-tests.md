+++
title = "Improving x86-64 Encoder Tests"
description = "Add encoder assertions and replace repetitive hand-written cases with a compact instruction parser that derives operands, sizes, registers, immediates, and memory addresses."
date = "2025-09-08T03:06:43Z"
duration = 1800
weight = 15
youtube_id = "slEJOs0YSg4"
collection = "compiler_from_scratch"

[[chapters]]
title = "Adding encoder assertions"
time = "00:00:00"
start = 0

[[chapters]]
title = "Rejecting invalid REX and address combinations"
time = "00:01:30"
start = 90

[[chapters]]
title = "Checking signed immediate widths"
time = "00:02:48"
start = 168

[[chapters]]
title = "Preventing RSP from acting as an index"
time = "00:04:30"
start = 270

[[chapters]]
title = "Planning a parser for test instructions"
time = "00:05:52"
start = 352

[[chapters]]
title = "Normalizing instruction text"
time = "00:07:30"
start = 450

[[chapters]]
title = "Parsing mnemonics and size hints"
time = "00:08:53"
start = 533

[[chapters]]
title = "Splitting and classifying operands"
time = "00:10:30"
start = 630

[[chapters]]
title = "Inferring sizes from register names"
time = "00:12:00"
start = 720

[[chapters]]
title = "Creating operands from text"
time = "00:13:30"
start = 810

[[chapters]]
title = "Distinguishing immediates, registers, and memory"
time = "00:15:00"
start = 900

[[chapters]]
title = "Parsing numeric literals"
time = "00:16:30"
start = 990

[[chapters]]
title = "Mapping register aliases"
time = "00:18:00"
start = 1080

[[chapters]]
title = "Parsing memory expressions"
time = "00:20:53"
start = 1253

[[chapters]]
title = "Handling scaled indexes without a base"
time = "00:22:30"
start = 1350

[[chapters]]
title = "Parsing scale factors and displacements"
time = "00:24:00"
start = 1440

[[chapters]]
title = "Debugging whitespace in RIP-relative operands"
time = "00:25:30"
start = 1530

[[chapters]]
title = "Removing repetitive operand tables"
time = "00:28:30"
start = 1710

[[chapters]]
title = "Running the simplified test suite"
time = "00:29:36"
start = 1776
+++

Add encoder assertions and replace repetitive hand-written cases with a compact instruction parser that derives operands, sizes, registers, immediates, and memory addresses.
