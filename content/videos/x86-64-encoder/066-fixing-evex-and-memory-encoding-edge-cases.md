+++
title = "Fixing EVEX and Memory Encoding Edge Cases"
description = "I fix an incorrect LOCK prefix byte and displacement-selection bugs affecting byte-width and EVEX no-base memory operands, then update accumulator instruction forms to select shorter sign-extended immediate encodings."
date = "2026-08-24T04:46:59Z"
duration = 1209
weight = 66
youtube_id = "4-uF-K_r778"
collection = "compiler_toolchain"

[[chapters]]
title = "Fixing the LOCK Prefix Byte"
time = "00:00:00"
start = 0

[[chapters]]
title = "Fixing Byte-Width Memory Displacements"
time = "00:00:41"
start = 41

[[chapters]]
title = "Testing No-Base Memory Addressing"
time = "00:04:47"
start = 287

[[chapters]]
title = "Fixing EVEX No-Base Displacements"
time = "00:07:27"
start = 447

[[chapters]]
title = "Finding Longer Accumulator Encodings"
time = "00:11:12"
start = 672

[[chapters]]
title = "Adding Short-Form Test Cases"
time = "00:12:18"
start = 738

[[chapters]]
title = "Selecting Shorter Immediate Forms"
time = "00:17:31"
start = 1051
+++

I fix an incorrect LOCK prefix byte and displacement-selection bugs affecting byte-width and EVEX no-base memory operands, then update accumulator instruction forms to select shorter sign-extended immediate encodings.
