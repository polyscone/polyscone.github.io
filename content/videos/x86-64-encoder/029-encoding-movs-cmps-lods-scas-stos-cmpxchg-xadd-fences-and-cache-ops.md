+++
title = "Encoding MOVS/CMPS/LODS/SCAS/STOS, CMPXCHG/XADD, Fences, and Cache Ops"
description = "Implementing string instructions, atomic read-modify-write instructions, memory fences, pause, prefetch, and cache-line write-back/flush instructions."
date = "2026-07-05T04:47:52Z"
duration = 1475
weight = 29
youtube_id = "Fo7cfeQII2I"
collection = "compiler_toolchain"

[[chapters]]
title = "String Instruction Test Cases"
time = "00:00:00"
start = 0

[[chapters]]
title = "String Instruction Forms"
time = "00:05:25"
start = 325

[[chapters]]
title = "Atomic Instruction Test Cases"
time = "00:06:52"
start = 412

[[chapters]]
title = "Atomic Instruction Forms"
time = "00:10:39"
start = 639

[[chapters]]
title = "Memory Ordering Instruction Test Cases"
time = "00:11:39"
start = 699

[[chapters]]
title = "Memory Ordering Instruction Forms"
time = "00:14:44"
start = 884

[[chapters]]
title = "Fixed ModRM Implementation"
time = "00:15:52"
start = 952

[[chapters]]
title = "Remaining Test Cases"
time = "00:17:00"
start = 1020

[[chapters]]
title = "Remaining Forms"
time = "00:22:23"
start = 1343
+++

Implementing string instructions, atomic read-modify-write instructions, memory fences, pause, prefetch, and cache-line write-back/flush instructions.

Encoding cases covered include implicit string-operation operands, width-selected string opcodes, fixed ModRM encodings, atomic register/memory forms, memory-ordering instructions, prefetch locality variants, and cache-management instruction forms.

Instructions covered: MOVSB/W/D/Q, CMPSB/W/D/Q, LODSB/W/D/Q, SCASB/W/D/Q, STOSB/W/D/Q, CMPXCHG, XADD, L/S/MFENCE, PAUSE, PREFETCH T0/T1/T2/NTA/IT0/IT1, CLFLUSH, CLFLUSHOPT, and CLWB.
