+++
title = "Section and Object Symbol Resolution"
description = "I extend the assembler's resolver to handle section and object declarations. I add section attributes and constant alignment evaluation, associate objects with their section and type, and introduce an architecture scope for built-in symbols that cannot be shadowed. I update the annotated AST output, check that objects are declared within a section, and switch source storage back to a string to avoid repeated substring conversions."
date = "2026-10-07"
duration = 2525
weight = 82
youtube_id = "txD5wf8TUDc"
collection = "compiler_toolchain"

[[chapters]]
title = "Planning Section Resolution and Alignment Tests"
time = "00:00:00"
start = 0

[[chapters]]
title = "Adding Symbol Kinds and Section Information"
time = "00:03:03"
start = 183

[[chapters]]
title = "Defining Section Attributes"
time = "00:04:03"
start = 243

[[chapters]]
title = "Resolving Sections and Fixing the Align AST Field"
time = "00:06:00"
start = 360

[[chapters]]
title = "Resolving and Evaluating Section Alignment"
time = "00:07:29"
start = 449

[[chapters]]
title = "Defining Section Symbols and Discussing Duplicate Names"
time = "00:09:33"
start = 573

[[chapters]]
title = "Mapping Section Names to Predefined Attributes"
time = "00:11:12"
start = 672

[[chapters]]
title = "Printing Section Information in the AST"
time = "00:14:19"
start = 859

[[chapters]]
title = "Fixing Symbol Associations and Attribute Names"
time = "00:17:37"
start = 1057

[[chapters]]
title = "Planning Object Resolution Tests"
time = "00:19:08"
start = 1148

[[chapters]]
title = "Resolving Object Declarations"
time = "00:20:51"
start = 1251

[[chapters]]
title = "Adding Architecture-Specific Built-in Symbols"
time = "00:23:07"
start = 1387

[[chapters]]
title = "Defining the Built-in Integer Types"
time = "00:25:30"
start = 1530

[[chapters]]
title = "Preventing Built-in Symbols from Being Redefined"
time = "00:27:46"
start = 1666

[[chapters]]
title = "Looking Up Architecture Symbols First"
time = "00:29:17"
start = 1757

[[chapters]]
title = "Fixing Type Symbol Output"
time = "00:30:45"
start = 1845

[[chapters]]
title = "Returning Symbols from ResolveNode for Object Types"
time = "00:31:27"
start = 1887

[[chapters]]
title = "Tracking the Current Section for Objects"
time = "00:36:15"
start = 2175

[[chapters]]
title = "Printing Section Names for Object Symbols"
time = "00:37:52"
start = 2272

[[chapters]]
title = "Checking Objects Declared Outside a Section"
time = "00:39:13"
start = 2353

[[chapters]]
title = "Revisiting Source Storage and Substring Allocations"
time = "00:39:53"
start = 2393

[[chapters]]
title = "Running Tests and Next Steps"
time = "00:41:40"
start = 2500
+++

I extend the assembler's resolver to handle section and object declarations. I add section attributes and constant alignment evaluation, associate objects with their section and type, and introduce an architecture scope for built-in symbols that cannot be shadowed. I update the annotated AST output, check that objects are declared within a section, and switch source storage back to a string to avoid repeated substring conversions.
