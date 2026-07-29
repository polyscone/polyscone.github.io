+++
title = "Encoding SIB Addressing and Displacements with MOV"
description = "Adding SIB byte support for scaled-index addressing, displacement encoding, no-base addressing, and canonicalization of some addressing forms."
date = "2026-06-22T05:55:23Z"
duration = 1305
weight = 5
youtube_id = "6KdiUu73QUo"
collection = "compiler_toolchain"

[[chapters]]
title = "Memory Access with Displacement Test Cases"
time = "00:00:00"
start = 0

[[chapters]]
title = "Memory Access with SIB Byte Test Cases"
time = "00:01:23"
start = 83

[[chapters]]
title = "Implementing SIB Bytes"
time = "00:06:26"
start = 386

[[chapters]]
title = "No Base Special Case"
time = "00:16:37"
start = 997

[[chapters]]
title = "Canonicalizing No Base with Scales 1 and 2"
time = "00:18:21"
start = 1101
+++

Adding SIB byte support for scaled-index addressing, displacement encoding, no-base addressing, and canonicalization of some addressing forms.

Addressing cases covered include base + displacement, base + index * scale, no-base SIB forms, SP/R12 SIB requirements, and BP/R13 displacement requirements.
