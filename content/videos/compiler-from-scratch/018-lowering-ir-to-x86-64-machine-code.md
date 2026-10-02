+++
title = "Lowering IR to x86-64 Machine Code"
description = "Connect the IR and x86-64 encoder with naive virtual-register allocation, operand conversion, instruction dispatch, and end-to-end disassembly."
date = "2025-09-11T05:35:25Z"
duration = 1786
weight = 18
youtube_id = "x-bIeQ-qlz4"
collection = "compiler_from_scratch"

[[chapters]]
title = "Planning the IR-to-machine-code mapping"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding disassembler output"
time = "00:01:30"
start = 90

[[chapters]]
title = "Creating the x86-64 generator entry point"
time = "00:03:00"
start = 180

[[chapters]]
title = "Traversing functions, blocks, and instructions"
time = "00:03:42"
start = 222

[[chapters]]
title = "Mapping IR constants to MOV"
time = "00:06:00"
start = 360

[[chapters]]
title = "Converting IR types to operand sizes"
time = "00:07:30"
start = 450

[[chapters]]
title = "Converting IR values to encoder operands"
time = "00:09:00"
start = 540

[[chapters]]
title = "Allocating virtual registers"
time = "00:10:11"
start = 611

[[chapters]]
title = "Assigning registers sequentially"
time = "00:10:47"
start = 647

[[chapters]]
title = "Resetting allocation for each function"
time = "00:12:00"
start = 720

[[chapters]]
title = "Lowering constants"
time = "00:13:30"
start = 810

[[chapters]]
title = "Lowering binary arithmetic"
time = "00:15:00"
start = 900

[[chapters]]
title = "Preparing RDX:RAX for division"
time = "00:16:30"
start = 990

[[chapters]]
title = "Emitting DIV and collecting its result"
time = "00:18:00"
start = 1080

[[chapters]]
title = "Running the first complete sample"
time = "00:19:30"
start = 1170

[[chapters]]
title = "Lowering return values"
time = "00:21:00"
start = 1260

[[chapters]]
title = "Debugging duplicated register assignments"
time = "00:22:30"
start = 1350

[[chapters]]
title = "Fixing the virtual-register map"
time = "00:24:00"
start = 1440

[[chapters]]
title = "Verifying the generated instruction stream"
time = "00:25:30"
start = 1530

[[chapters]]
title = "Comparing output with NASM"
time = "00:27:00"
start = 1620

[[chapters]]
title = "Reviewing the naive allocator's limitations"
time = "00:28:30"
start = 1710
+++

Connect the IR and x86-64 encoder with naive virtual-register allocation, operand conversion, instruction dispatch, and end-to-end disassembly.
