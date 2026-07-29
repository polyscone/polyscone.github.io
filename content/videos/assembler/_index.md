+++
title = "Assembler"
description = "Building an assembly-language frontend in Go: scanning, comment trivia, expression parsing, declarations, memory operands and diagnostics."
weight = 3
index_id = "assembler"
parent_series = "/videos/compiler-toolchain"
playlist = "https://www.youtube.com/playlist?list=PLQE7BMSLFGHE"
+++

Building an assembler frontend in Go without AI assistance, as part of [Compiler Toolchain Development](/videos/compiler-toolchain/). The project covers a language for describing sections, data, functions and instructions, with a scanner and recursive descent parser. Topics include source locations, comment trivia, expression precedence, syntax trees, memory operands, width suffixes, alignment and declaration attributes.

The recordings also cover comment-driven parser fixtures, syntax-tree traversal and formatting, diagnostics, error recovery and scanner bugs. Concrete examples show how source text becomes tokens and structured declarations, and how the parser handles malformed input.
