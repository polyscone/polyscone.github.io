+++
title = "Encoding Op/En Metadata for MOV Forms"
description = "Replacing operand-role guessing with explicit Op/En metadata, so each instruction form can describe which operand is encoded in ModRM.reg, ModRM.r/m, immediates, opcode bits, or fixed implicit locations."
date = "2026-06-23T00:56:21Z"
duration = 564
weight = 9
youtube_id = "gnq_J2sKstA"
collection = "compiler_toolchain"

[[chapters]]
title = "Why Operand Encoding Guessing Breaks"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding Op/En to Forms"
time = "00:02:34"
start = 154

[[chapters]]
title = "Using Op/En to Choose Operand Roles"
time = "00:07:40"
start = 460

[[chapters]]
title = "Choosing Op/En for Each Form"
time = "00:08:43"
start = 523
+++

Replacing operand-role guessing with explicit Op/En metadata, so each instruction form can describe which operand is encoded in ModRM.reg, ModRM.r/m, immediates, opcode bits, or fixed implicit locations.

Encoding concepts covered include Intel Op/En notation, MR/RM/OI/MI-style forms, operand role selection, and mapping instruction forms to encoder behavior.
