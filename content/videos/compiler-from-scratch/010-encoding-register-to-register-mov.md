+++
title = "Encoding Register-to-Register MOV"
description = "Start the x86-64 encoder with register operands and implement tested register-to-register MOV encoding using operand-size, ModR/M, and REX fields."
date = "2025-09-01T04:57:11Z"
duration = 2167
weight = 10
youtube_id = "RcZnbwzX5-E"
collection = "compiler_from_scratch"

[[chapters]]
title = "Starting the x86-64 code generator"
time = "00:00:00"
start = 0

[[chapters]]
title = "Representing registers as operands"
time = "00:01:32"
start = 92

[[chapters]]
title = "Byte-register aliases and REX behavior"
time = "00:03:38"
start = 218

[[chapters]]
title = "Packing register and r/m fields"
time = "00:05:52"
start = 352

[[chapters]]
title = "Defining instruction sizes and encoder state"
time = "00:08:00"
start = 480

[[chapters]]
title = "Using NASM to generate expected bytes"
time = "00:09:48"
start = 588

[[chapters]]
title = "Building a size and register test matrix"
time = "00:13:35"
start = 815

[[chapters]]
title = "Importing assembled expectations"
time = "00:16:00"
start = 960

[[chapters]]
title = "Choosing the canonical MOV encoding"
time = "00:20:00"
start = 1200

[[chapters]]
title = "Understanding prefixes across operand sizes"
time = "00:21:47"
start = 1307

[[chapters]]
title = "Emitting size overrides and opcodes"
time = "00:23:42"
start = 1422

[[chapters]]
title = "Selecting address-direct ModR/M mode"
time = "00:25:54"
start = 1554

[[chapters]]
title = "Constructing the ModR/M byte"
time = "00:27:38"
start = 1658

[[chapters]]
title = "Finding missing REX prefixes"
time = "00:29:54"
start = 1794

[[chapters]]
title = "Encoding REX W, R, and B bits"
time = "00:31:16"
start = 1876

[[chapters]]
title = "Passing the register-to-register tests"
time = "00:33:45"
start = 2025
+++

Start the x86-64 encoder with register operands and implement tested register-to-register MOV encoding using operand-size, ModR/M, and REX fields.
