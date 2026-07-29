+++
title = "x86-64 Encoder"
description = "Turning instructions into bytes: operand matching, ModR/M and SIB addressing, legacy/REX, VEX and EVEX encodings, validation and fixups."
weight = 2
index_id = "x86-64-encoder"
parent_series = "/videos/compiler-toolchain"
playlist = "https://www.youtube.com/playlist?list=PLfwYKZej86PrERg1ho6r17PyXmFUD5CZ_"
+++

Building an x86-64 machine-code encoder from scratch in Go without AI assistance, as part of [Compiler Toolchain Development](/videos/compiler-toolchain/). The encoder takes operations and structured operands, matches instruction forms, and emits bytes for use by an assembler or compiler backend. The recordings cover register and memory operands, ModR/M and SIB addressing, displacements, immediates, and legacy, REX, VEX and EVEX encodings.

Instruction coverage includes integer and vector operations, EVEX masks, broadcasts, rounding and compressed displacements. NASM listings provide reference bytes for validation. The series also covers performance, labels, fixups and encoding bugs, with an overview of the instruction format and worked encoding examples.
