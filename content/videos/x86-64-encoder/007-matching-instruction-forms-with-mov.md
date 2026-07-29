+++
title = "Matching Instruction Forms with MOV"
description = "Introducing instruction form metadata so the encoder can choose the correct encoding form based on operation, operand widths, and operand kinds."
date = "2026-06-23T00:54:47Z"
duration = 895
weight = 7
youtube_id = "xtfKuE9pvUw"
collection = "compiler_toolchain"

[[chapters]]
title = "The Form Type and Helper Functions"
time = "00:00:00"
start = 0

[[chapters]]
title = "Matching a Form to Emit"
time = "00:07:40"
start = 460

[[chapters]]
title = "Using the Matched Form to Emit Bytes"
time = "00:09:56"
start = 596

[[chapters]]
title = "Adding a NoModRM Flag"
time = "00:10:56"
start = 656

[[chapters]]
title = "Switching on Opcode Maps"
time = "00:11:53"
start = 713

[[chapters]]
title = "Matching MOV Register/Memory Forms"
time = "00:12:28"
start = 748
+++

Introducing instruction form metadata so the encoder can choose the correct encoding form based on operation, operand widths, and operand kinds.

Instructions and concepts covered include MOV register/memory forms, form matching, opcode map selection, ModRM/no-ModRM handling, and using matched forms to drive byte emission.
