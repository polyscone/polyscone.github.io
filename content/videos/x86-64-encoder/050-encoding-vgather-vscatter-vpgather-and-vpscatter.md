+++
title = "Encoding VGATHER, VSCATTER, VPGATHER, and VPSCATTER"
description = "Adding floating-point and packed-integer gather and scatter instructions, together with VSIB addressing, vector index registers, high-16 EVEX indices, and no-base address encoding."
date = "2026-07-20T07:04:58Z"
duration = 3033
weight = 50
youtube_id = "1Fqz5ZAV960"
collection = "compiler_toolchain"

[[chapters]]
title = "VSIB Explanation"
time = "00:00:00"
start = 0

[[chapters]]
title = "Instruction Test Cases"
time = "00:02:12"
start = 132

[[chapters]]
title = "Adding a VSIB Attribute"
time = "00:23:36"
start = 1416

[[chapters]]
title = "Skipping GPR Index Optimizations"
time = "00:26:19"
start = 1579

[[chapters]]
title = "Instruction Forms"
time = "00:27:42"
start = 1662

[[chapters]]
title = "Encoding High-16 Index Registers"
time = "00:36:09"
start = 2169

[[chapters]]
title = "Fixing ModRM for No Base VSIB"
time = "00:40:03"
start = 2403

[[chapters]]
title = "Remaining Instruction Forms"
time = "00:42:57"
start = 2577
+++

Adding floating-point and packed-integer gather and scatter instructions, together with VSIB addressing, vector index registers, high-16 EVEX indices, and no-base address encoding.

Instructions covered: VGATHERDPS/DPD, VGATHERQPS/QPD, VPGATHERDD/DQ/QD/QQ, VPSCATTERDD/DQ/QD/QQ, VSCATTERDPS/DPD, and VSCATTERQPS/QPD.
