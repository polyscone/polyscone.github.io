+++
title = "Encoding CVT/VCVT and CVTT/VCVTT Packed PS/PD/DQ Conversions"
description = "Adding packed floating-point and integer conversion instructions, including legacy SSE, VEX, and EVEX forms. This covers packed single/double precision conversions, signed doubleword integer conversions, truncating CVTT variants, EVEX SAE handling, and form fixes needed for scalar and packed conversion instructions."
date = "2026-06-30T04:38:25Z"
duration = 1754
weight = 26
youtube_id = "0drIPmApkaY"
collection = "compiler_toolchain"

[[chapters]]
title = "Form Fixes for Scalar CVTT"
time = "00:00:00"
start = 0

[[chapters]]
title = "Packed CVT/CVTT Test Cases"
time = "00:00:38"
start = 38

[[chapters]]
title = "NASM Incorrectly Allowing ER on VCVTDQ2PD"
time = "00:14:31"
start = 871

[[chapters]]
title = "First Form Implementations"
time = "00:15:39"
start = 939

[[chapters]]
title = "Ignoring EVEX.LL when SAE is Set"
time = "00:19:24"
start = 1164

[[chapters]]
title = "Remaining Form Implementations"
time = "00:21:21"
start = 1281
+++

Adding packed floating-point and integer conversion instructions, including legacy SSE, VEX, and EVEX forms. This covers packed single/double precision conversions, signed doubleword integer conversions, truncating CVTT variants, EVEX SAE handling, and form fixes needed for scalar and packed conversion instructions.

Instructions covered: CVTPS2DQ, VCVTPS2DQ, CVTTPS2DQ, VCVTTPS2DQ, CVTDQ2PS, VCVTDQ2PS, CVTPD2DQ, VCVTPD2DQ, CVTTPD2DQ, VCVTTPD2DQ, CVTDQ2PD, VCVTDQ2PD, CVTPS2PD, VCVTPS2PD, CVTPD2PS, and VCVTPD2PS.
