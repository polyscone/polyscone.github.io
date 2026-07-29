+++
title = "Fixing Destructive Fixups"
description = "Before I can reliably create ELF relocations I need to fix my encoder fixups, which are destroying important data required for encoding the correct instruction bytes."
date = "2026-08-20T05:27:06Z"
duration = 507
weight = 62
youtube_id = "qoKpP0xA1O0"
collection = "compiler_toolchain"

[[chapters]]
title = "Bug Explanation"
time = "00:00:00"
start = 0

[[chapters]]
title = "Fix Implementation"
time = "00:02:54"
start = 174

[[chapters]]
title = "Performance Regression"
time = "00:07:07"
start = 427
+++

Before I can reliably create ELF relocations I need to fix my encoder fixups, which are destroying important data required for encoding the correct instruction bytes.
