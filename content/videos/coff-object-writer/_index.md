+++
title = "COFF Object Writer"
description = "Writing Windows COFF object files, with section headers, symbols, relocations, long names and relocation overflow support."
weight = 5
index_id = "coff-object-file-writer"
parent_series = "/videos/compiler-toolchain"
playlist = "https://www.youtube.com/playlist?list=PLSCWttVpvRvQ"
+++

Building a COFF object writer from scratch in Go without AI assistance, as part of [Compiler Toolchain Development](/videos/compiler-toolchain/). The writer packages generated code and data into Windows object files for Microsoft's `link.exe`. The series covers COFF types and constants, file and section headers, symbols, string tables and AMD64 relocations.

The recordings show how the [x86-64 encoder's](/videos/x86-64-encoder/) fixups connect to COFF relocations, how long symbol and section names are stored, and how relocation overflow is handled. Examples include constructing a minimal object file and checking its output with an external linker.
