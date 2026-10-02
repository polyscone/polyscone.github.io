+++
title = "Encoding EVEX Masks with MOVAPS/PD, VMOVAPS/PD, MOVUPS/PD, and VMOVUPS/PD"
description = "Adding EVEX opmask and zeroing-mask support, then extending the vector move implementation across aligned and unaligned single/double-precision move instructions."
date = "2026-06-23T04:48:13Z"
duration = 1651
weight = 19
youtube_id = "TF1bhofjewM"
collection = "compiler_toolchain"

[[chapters]]
title = "Opmask and Zeroing Mask Notation"
time = "00:00:00"
start = 0

[[chapters]]
title = "MOVAPS {k} and {z} Test Cases"
time = "00:03:03"
start = 183

[[chapters]]
title = "Adding K() and Z() Helpers"
time = "00:05:59"
start = 359

[[chapters]]
title = "Adding K0-K7 Operands"
time = "00:10:18"
start = 618

[[chapters]]
title = "Rejecting Forms Without Opmask Support"
time = "00:11:00"
start = 660

[[chapters]]
title = "MOVAPS Opmask Forms"
time = "00:14:33"
start = 873

[[chapters]]
title = "Encoding Opmasks and Zeroing"
time = "00:15:00"
start = 900

[[chapters]]
title = "MOVAPD Test Cases"
time = "00:17:26"
start = 1046

[[chapters]]
title = "MOVAPD Implementation"
time = "00:20:28"
start = 1228

[[chapters]]
title = "Encoding EVEX.W1"
time = "00:21:19"
start = 1279

[[chapters]]
title = "MOVUPS and MOVUPD Test Cases"
time = "00:23:36"
start = 1416

[[chapters]]
title = "MOVUPS and MOVUPD Implementations"
time = "00:25:07"
start = 1507
+++

Adding EVEX opmask and zeroing-mask support, then extending the vector move implementation across aligned and unaligned single/double-precision move instructions.

Instructions covered: MOVAPS, VMOVAPS, MOVAPD, VMOVAPD, MOVUPS, VMOVUPS, MOVUPD, and VMOVUPD, including EVEX {k} and {z} decorators.
