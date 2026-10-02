+++
title = "Encoding ADC/SBB, INC/DEC, SHLD/SHRD, BSWAP, MOVBE, and CRC32"
description = "Adding more integer and utility instruction encodings to the x86_64 encoder, including carry-aware arithmetic, increment/decrement forms, double-precision shifts, byte-swap operations, endian-swapping memory moves, and CRC32 checksum instructions."
date = "2026-07-07T05:32:44Z"
duration = 1986
weight = 31
youtube_id = "-ZlTGBzthf8"
collection = "compiler_toolchain"

[[chapters]]
title = "Fixing the ENTER Forms"
time = "00:00:00"
start = 0

[[chapters]]
title = "Renaming Op to Mnemonic"
time = "00:01:55"
start = 115

[[chapters]]
title = "ADC and SBB Test Cases"
time = "00:03:53"
start = 233

[[chapters]]
title = "ADC and SBB Forms"
time = "00:05:53"
start = 353

[[chapters]]
title = "INC and DEC Test Cases"
time = "00:06:55"
start = 415

[[chapters]]
title = "INC and DEC Forms"
time = "00:09:32"
start = 572

[[chapters]]
title = "SHLD and SHRD Test Cases"
time = "00:10:38"
start = 638

[[chapters]]
title = "SHLD and SHRD Forms"
time = "00:14:21"
start = 861

[[chapters]]
title = "BSWAP Test Cases"
time = "00:16:30"
start = 990

[[chapters]]
title = "BSWAP Form"
time = "00:17:54"
start = 1074

[[chapters]]
title = "MOVBE Test Cases"
time = "00:18:38"
start = 1118

[[chapters]]
title = "MOVBE Forms"
time = "00:21:00"
start = 1260

[[chapters]]
title = "CRC32 Short Forms"
time = "00:22:42"
start = 1362

[[chapters]]
title = "CRC32 Test Cases"
time = "00:25:27"
start = 1527

[[chapters]]
title = "CRC32 Forms"
time = "00:30:39"
start = 1839
+++

Adding more integer and utility instruction encodings to the x86_64 encoder, including carry-aware arithmetic, increment/decrement forms, double-precision shifts, byte-swap operations, endian-swapping memory moves, and CRC32 checksum instructions.

This covers a few encoding edge cases, including ENTER form fixes, renaming Op to Mnemonic, SHLD/SHRD operand forms, BSWAP +r encoding, MOVBE load/store forms, and CRC32 short-form selection for byte-source operands.

Instructions covered: ADC, SBB, INC, DEC, SHLD, SHRD, BSWAP, MOVBE, and CRC32.
