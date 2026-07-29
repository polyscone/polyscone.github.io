+++
title = "Encoding EVEX Rounding/Broadcasts with ADD/VADD, VSUB, VMUL, and VDIV SS/SD/PS/PD"
description = "Adding scalar and packed floating-point arithmetic instructions, then extending EVEX encoding to support embedded rounding, rounding-control values, and memory broadcast operands."
date = "2026-06-24T13:18:18Z"
duration = 2689
weight = 21
youtube_id = "VawHWPuoPdw"
collection = "compiler_toolchain"

[[chapters]]
title = "ADDSS Test Cases"
time = "00:00:00"
start = 0

[[chapters]]
title = "Embedded Rounding Overview"
time = "00:01:58"
start = 118

[[chapters]]
title = "ADDSS ER Test Cases"
time = "00:04:02"
start = 242

[[chapters]]
title = "ADDSS Legacy and VEX Forms"
time = "00:08:03"
start = 483

[[chapters]]
title = "ER Helper Function"
time = "00:10:29"
start = 629

[[chapters]]
title = "ADDSS EVEX Forms"
time = "00:13:58"
start = 838

[[chapters]]
title = "Encoding Embedded Rounding"
time = "00:15:33"
start = 933

[[chapters]]
title = "RC Value Helper Function"
time = "00:17:38"
start = 1058

[[chapters]]
title = "ADDSD Tests and Implementation"
time = "00:19:43"
start = 1183

[[chapters]]
title = "ADDPS Test Cases"
time = "00:21:12"
start = 1272

[[chapters]]
title = "Broadcast Helper Function"
time = "00:30:13"
start = 1813

[[chapters]]
title = "ADDPS Forms"
time = "00:31:20"
start = 1880

[[chapters]]
title = "Encoding Memory Broadcast"
time = "00:36:49"
start = 2209

[[chapters]]
title = "ADDPD Test Cases"
time = "00:37:55"
start = 2275

[[chapters]]
title = "ADDPD Implementation"
time = "00:39:11"
start = 2351

[[chapters]]
title = "VSUB, VMUL, and VDIV Test Cases"
time = "00:40:16"
start = 2416

[[chapters]]
title = "VSUB, VMUL, and VDIV Implementation"
time = "00:42:01"
start = 2521
+++

Adding scalar and packed floating-point arithmetic instructions, then extending EVEX encoding to support embedded rounding, rounding-control values, and memory broadcast operands.

Instructions covered: ADDSS, ADDSD, ADDPS, ADDPD, VADDSS, VADDSD, VADDPS, VADDPD, VSUBSS, VSUBSD, VSUBPS, VSUBPD, VMULSS, VMULSD, VMULPS, VMULPD, VDIVSS, VDIVSD, VDIVPS, and VDIVPD.
