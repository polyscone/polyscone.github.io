+++
title = "Encoding CVT/VCVT and CVTT/VCVTT Scalar SS/SD Conversions"
description = "Adding scalar x86-64 conversion instructions for moving between floating-point values and signed integers, including both rounded CVT forms and truncating CVTT forms."
date = "2026-06-29T04:25:06Z"
duration = 1828
weight = 25
youtube_id = "NN6pQSRh514"
collection = "compiler_toolchain"

[[chapters]]
title = "Similar CVT/CVTT Instruction Forms"
time = "00:00:00"
start = 0

[[chapters]]
title = "Scalar CVT/CVTT Test Cases"
time = "00:00:55"
start = 55

[[chapters]]
title = "Allowing SAE/ER on Register Operands"
time = "00:17:01"
start = 1021

[[chapters]]
title = "Form Implementations"
time = "00:18:02"
start = 1082
+++

Adding scalar x86-64 conversion instructions for moving between floating-point values and signed integers, including both rounded CVT forms and truncating CVTT forms.

This video covers scalar single-precision and double-precision conversion forms, VEX-encoded conversion forms, register and memory operands, 32-bit and 64-bit integer operands, and allowing SAE/ER decorators on register operands where the encoding permits it.

Instructions covered: CVTSS2SI, VCVTSS2SI, CVTSD2SI, VCVTSD2SI, CVTTSS2SI, VCVTTSS2SI, CVTTSD2SI, VCVTTSD2SI, CVTSS2SD, VCVTSS2SD, CVTSD2SS, VCVTSD2SS, CVTSI2SS, VCVTSI2SS, CVTSI2SD, and VCVTSI2SD.
