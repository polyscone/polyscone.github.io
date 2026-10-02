+++
title = "Compiler From Scratch (2025 Archive)"
description = "A 19-hour Go compiler project, from scanning and Pratt parsing through type checking and IR to x86-64 code and a PE32+ executable."
weight = 5
archived = true
index_id = "compiler-from-scratch"
playlist = "https://www.youtube.com/playlist?list=PLfwYKZej86PpEFsy6HQB9WQIlIGmfOy_s"
+++

A 2025 project building a compiler from scratch in Go without AI assistance, over roughly nineteen hours of unedited programming sessions. It follows source text through scanning, Pratt parsing, type checking and a simple intermediate representation, then lowers that representation to native x86-64 machine code. The compiler writes a PE32+ Windows executable directly, without relying on LLVM.

The backend sessions cover MOV, register and memory operands, ModR/M, SIB, displacements and a small set of arithmetic instructions. The frontend sessions cover operator precedence, syntax trees, parser diagnostics and checking function returns. This implementation is separate from [Compiler Toolchain Development](/videos/compiler-toolchain/).
