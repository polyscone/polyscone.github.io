+++
title = "Encoding Legacy SSE/VEX/EVEX Prefixes with MOVAPS and VMOVAP"
description = "Using MOVAPS as the first vector instruction to introduce SSE register operands, legacy SSE encoding, VEX prefix encoding, EVEX prefix encoding, and the rules for choosing between VEX and EVEX forms."
date = "2026-06-23T00:59:29Z"
duration = 3587
weight = 18
youtube_id = "blaCwZGXafY"
collection = "compiler_toolchain"

[[chapters]]
title = "MOVAPS Form Overview"
time = "00:00:00"
start = 0

[[chapters]]
title = "Vector Register Operands"
time = "00:01:05"
start = 65

[[chapters]]
title = "MOVAPS Test Cases"
time = "00:03:03"
start = 183

[[chapters]]
title = "Implementing Legacy SSE MOVAPS"
time = "00:07:20"
start = 440

[[chapters]]
title = "VEX and EVEX Table Notation"
time = "00:08:31"
start = 511

[[chapters]]
title = "VEX Prefix Layout"
time = "00:09:42"
start = 582

[[chapters]]
title = "VMOVAPS VEX Test Cases"
time = "00:14:39"
start = 879

[[chapters]]
title = "VMOVAPS VEX Forms"
time = "00:15:53"
start = 953

[[chapters]]
title = "Emitting VEX Prefixes"
time = "00:17:10"
start = 1030

[[chapters]]
title = "Emitting 2-Byte VEX"
time = "00:25:21"
start = 1521

[[chapters]]
title = "Emitting 3-Byte VEX"
time = "00:28:01"
start = 1681

[[chapters]]
title = "EVEX Prefix Layout"
time = "00:33:52"
start = 2032

[[chapters]]
title = "VMOVAPS EVEX Test Cases"
time = "00:35:22"
start = 2122

[[chapters]]
title = "When to Use VEX vs EVEX"
time = "00:35:48"
start = 2148

[[chapters]]
title = "Forcing EVEX Test Cases"
time = "00:36:57"
start = 2217

[[chapters]]
title = "Unexpected ZWORD Match"
time = "00:39:23"
start = 2363

[[chapters]]
title = "VMOVAPS EVEX Forms"
time = "00:40:28"
start = 2428

[[chapters]]
title = "Rejecting Invalid VEX Forms"
time = "00:40:55"
start = 2455

[[chapters]]
title = "Emitting EVEX Prefixes"
time = "00:44:39"
start = 2679
+++

Using MOVAPS as the first vector instruction to introduce SSE register operands, legacy SSE encoding, VEX prefix encoding, EVEX prefix encoding, and the rules for choosing between VEX and EVEX forms.

Instructions and forms covered: MOVAPS and VMOVAPS across legacy SSE, VEX, and EVEX encodings.
