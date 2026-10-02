+++
title = "Encoding GPR/XMM Transfers with MOVD/Q and VMOVD/Q"
description = "Adding MOVD, MOVQ, VMOVD, and VMOVQ to the x86-64 encoder, covering transfers between general-purpose registers, memory operands, and XMM/vector registers."
date = "2026-06-29T03:24:28Z"
duration = 1172
weight = 24
youtube_id = "tc69PslRYlE"
collection = "compiler_toolchain"

[[chapters]]
title = "MOVD/MOVQ Forms and Short Encodings"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding Test Cases"
time = "00:01:04"
start = 64

[[chapters]]
title = "Implementing Forms"
time = "00:05:18"
start = 318

[[chapters]]
title = "Encoding VEX.W"
time = "00:08:56"
start = 536

[[chapters]]
title = "Encoding MOVQ for Vector Operands"
time = "00:11:22"
start = 682

[[chapters]]
title = "Shorter MOVQ Encodings"
time = "00:13:18"
start = 798

[[chapters]]
title = "Encoding VMOVQ for Vector Operands"
time = "00:16:58"
start = 1018
+++

Adding MOVD, MOVQ, VMOVD, and VMOVQ to the x86-64 encoder, covering transfers between general-purpose registers, memory operands, and XMM/vector registers.

This video covers legacy SSE forms, VEX forms, VEX.W encoding, short MOVQ encodings, and the distinction between 32-bit MOVD transfers and 64-bit MOVQ transfers.

Instructions covered: MOVD, MOVQ, VMOVD, and VMOVQ.
