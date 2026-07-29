+++
title = "Fixing Resolver Bugs and Adding Validation"
description = "I work through the assembler resolver's remaining fixes and validation checks before moving on to instruction lowering. I fix string initialisers in nested arrays, reject invalid scalar initialisers, and resolve identifiers inside lists, groups and unary expressions. I debug section associations for functions and labels, validate power-of-two alignments, propagate object and standalone alignments to sections, and allow sections to be reopened. I also reject missing or empty initialisers for inferred arrays and non-constant symbols in constant expressions, then prevent duplicate declarations from modifying existing symbols. BSS initialiser validation is left for later."
date = "2026-10-13"
duration = 3366
weight = 87
youtube_id = "rTL4WzL5BjY"
collection = "compiler_toolchain"

[[chapters]]
title = "Reviewing the Remaining Resolver Tasks"
time = "00:00:00"
start = 0

[[chapters]]
title = "Fixing String Initialisers in Nested Arrays"
time = "00:00:12"
start = 12

[[chapters]]
title = "Adding Invalid Initialiser Cases"
time = "00:03:31"
start = 211

[[chapters]]
title = "Improving Resolver Test Failure Messages"
time = "00:05:29"
start = 329

[[chapters]]
title = "Rejecting Strings and Lists for Scalars"
time = "00:06:14"
start = 374

[[chapters]]
title = "Passing the Parent Type Kind Through Resolution"
time = "00:07:54"
start = 474

[[chapters]]
title = "Resolving Identifiers in Groups and Unary Expressions"
time = "00:09:05"
start = 545

[[chapters]]
title = "Resolving Identifiers in Initialiser Lists"
time = "00:11:03"
start = 663

[[chapters]]
title = "Associating Functions and Labels with Sections"
time = "00:12:40"
start = 760

[[chapters]]
title = "Trying Section Tracking During Declaration"
time = "00:13:50"
start = 830

[[chapters]]
title = "Debugging Incorrect Section Associations"
time = "00:17:52"
start = 1072

[[chapters]]
title = "Tracing the Declaration and Resolution Passes"
time = "00:23:58"
start = 1438

[[chapters]]
title = "Restoring Section Resolution and Fixing Associations"
time = "00:27:07"
start = 1627

[[chapters]]
title = "Requiring an Active Section for Functions, Labels and Aligns"
time = "00:29:01"
start = 1741

[[chapters]]
title = "Fixing the Order of Section and Alignment Resolution"
time = "00:31:17"
start = 1877

[[chapters]]
title = "Validating Non-Zero Power-of-Two Alignments"
time = "00:33:16"
start = 1996

[[chapters]]
title = "Checking the Bitwise Power-of-Two Test"
time = "00:35:21"
start = 2121

[[chapters]]
title = "Trying an Invalid Alignment"
time = "00:36:53"
start = 2213

[[chapters]]
title = "Propagating Natural Object Alignment to Sections"
time = "00:37:15"
start = 2235

[[chapters]]
title = "Propagating Standalone Alignments to Sections"
time = "00:39:07"
start = 2347

[[chapters]]
title = "Considering Section Name Conflicts"
time = "00:40:14"
start = 2414

[[chapters]]
title = "Allowing Existing Sections to Be Reopened"
time = "00:41:16"
start = 2476

[[chapters]]
title = "Requiring Initialisers for Inferred Arrays"
time = "00:43:01"
start = 2581

[[chapters]]
title = "Handling Nil and Empty Initialisers"
time = "00:45:25"
start = 2725

[[chapters]]
title = "Checking Empty String Initialisers"
time = "00:47:45"
start = 2865

[[chapters]]
title = "Deferring BSS Initialiser Validation"
time = "00:49:18"
start = 2958

[[chapters]]
title = "Rejecting Non-Constant Symbols in Constant Expressions"
time = "00:49:39"
start = 2979

[[chapters]]
title = "Reviewing Symbol Kind Checks"
time = "00:52:27"
start = 3147

[[chapters]]
title = "Preserving Existing Symbols After Duplicate Declarations"
time = "00:53:00"
start = 3180

[[chapters]]
title = "Wrapping Up the Resolver Work"
time = "00:55:46"
start = 3346
+++

I work through the assembler resolver's remaining fixes and validation checks before moving on to instruction lowering. I fix string initialisers in nested arrays, reject invalid scalar initialisers, and resolve identifiers inside lists, groups and unary expressions. I debug section associations for functions and labels, validate power-of-two alignments, propagate object and standalone alignments to sections, and allow sections to be reopened. I also reject missing or empty initialisers for inferred arrays and non-constant symbols in constant expressions, then prevent duplicate declarations from modifying existing symbols. BSS initialiser validation is left for later.
