+++
title = "Encoding Scaled-Index Addressing"
description = "Implement SIB encoding for scaled-index effective addresses, including scale conversion, REX extensions, missing-base forms, and special stack/base registers."
date = "2025-09-05T06:11:55Z"
duration = 2541
weight = 13
youtube_id = "ArDIhTlYwIc"
collection = "compiler_from_scratch"

[[chapters]]
title = "Planning SIB and scaled-index encoding"
time = "00:00:00"
start = 0

[[chapters]]
title = "Building the scaled-index test matrix"
time = "00:01:16"
start = 76

[[chapters]]
title = "Importing assembled expectations"
time = "00:04:00"
start = 240

[[chapters]]
title = "Understanding SIB address simplifications"
time = "00:05:48"
start = 348

[[chapters]]
title = "Filling in base and index registers"
time = "00:08:00"
start = 480

[[chapters]]
title = "Testing RSP as a base"
time = "00:10:00"
start = 600

[[chapters]]
title = "Mapping scale factors to SIB bits"
time = "00:11:36"
start = 696

[[chapters]]
title = "Packing scale, index, and base metadata"
time = "00:12:48"
start = 768

[[chapters]]
title = "Integrating SIB with operand encoding"
time = "00:15:42"
start = 942

[[chapters]]
title = "Forcing the SIB selector in ModR/M"
time = "00:18:00"
start = 1080

[[chapters]]
title = "Encoding scale and index fields"
time = "00:20:00"
start = 1200

[[chapters]]
title = "Assembling the final SIB byte"
time = "00:24:00"
start = 1440

[[chapters]]
title = "Encoding no-base forms with disp32"
time = "00:26:00"
start = 1560

[[chapters]]
title = "Separating RIP-relative and scaled-index cases"
time = "00:28:00"
start = 1680

[[chapters]]
title = "Extending SIB base and index with REX"
time = "00:29:25"
start = 1765

[[chapters]]
title = "Mapping register numbers back to operands"
time = "00:31:22"
start = 1882

[[chapters]]
title = "Handling RSP, RBP, R12, and R13"
time = "00:34:29"
start = 2069

[[chapters]]
title = "Fixing scale-one special cases"
time = "00:38:00"
start = 2280

[[chapters]]
title = "Verifying reversed operands"
time = "00:40:00"
start = 2400

[[chapters]]
title = "Reviewing future immediate forms"
time = "00:42:00"
start = 2520
+++

Implement SIB encoding for scaled-index effective addresses, including scale conversion, REX extensions, missing-base forms, and special stack/base registers.
