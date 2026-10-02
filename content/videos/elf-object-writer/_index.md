+++
title = "ELF Object Writer"
description = "Packaging generated code into ELF relocatable objects, with sections, string tables, symbols, relocations and .bss support."
weight = 4
index_id = "elf-object-file-writer"
parent_series = "/videos/compiler-toolchain"
playlist = "https://www.youtube.com/playlist?list=PLQhDnqkMbbjw"
+++

Building an ELF relocatable object writer from scratch in Go without AI assistance, as part of [Compiler Toolchain Development](/videos/compiler-toolchain/). The writer packages generated machine code and data into object files that an external linker such as `ld` can turn into an executable. The series covers ELF headers, sections, alignment, string tables, symbols, relocations and uninitialised storage in `.bss`.

The recordings include inspecting files with `readelf`, linking external function calls and RIP-relative data references, and a program that calls `printf`. They also show how the [x86-64 encoder's](/videos/x86-64-encoder/) fixups connect to linker-visible symbols and relocations.
