+++
title = "Encoding Memory Displacements"
description = "Encode base-plus-displacement and RIP-relative MOV operands while selecting compact disp8 forms and handling base-pointer exceptions."
date = "2025-09-03T04:51:16Z"
duration = 1040
weight = 12
youtube_id = "SkYzSXls1F0"
collection = "compiler_from_scratch"

[[chapters]]
title = "Planning displacement addressing"
time = "00:00:00"
start = 0

[[chapters]]
title = "Building disp8 and disp32 test cases"
time = "00:00:53"
start = 53

[[chapters]]
title = "Adding RIP-relative cases"
time = "00:01:15"
start = 75

[[chapters]]
title = "Generating expected machine code"
time = "00:02:30"
start = 150

[[chapters]]
title = "Normalizing disassembler-relative syntax"
time = "00:03:45"
start = 225

[[chapters]]
title = "Expanding the register and size matrix"
time = "00:04:43"
start = 283

[[chapters]]
title = "Adding displacement operands to tests"
time = "00:06:15"
start = 375

[[chapters]]
title = "Reversing register and memory operands"
time = "00:07:30"
start = 450

[[chapters]]
title = "Selecting the Mod field"
time = "00:08:45"
start = 525

[[chapters]]
title = "Choosing between disp8 and disp32"
time = "00:10:00"
start = 600

[[chapters]]
title = "Handling RBP and R13 without a displacement"
time = "00:11:15"
start = 675

[[chapters]]
title = "Emitting little-endian displacement bytes"
time = "00:12:30"
start = 750

[[chapters]]
title = "Debugging the RIP-relative ModR/M form"
time = "00:13:45"
start = 825

[[chapters]]
title = "Measuring RIP displacement from the next instruction"
time = "00:15:00"
start = 900

[[chapters]]
title = "Accounting for the disp32 field length"
time = "00:16:15"
start = 975
+++

Encode base-plus-displacement and RIP-relative MOV operands while selecting compact disp8 forms and handling base-pointer exceptions.
