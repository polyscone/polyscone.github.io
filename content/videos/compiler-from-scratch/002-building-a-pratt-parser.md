+++
title = "Building a Pratt Parser"
description = "Build a precedence-aware Pratt parser that turns Fyn expressions into an AST while supporting prefix, infix, and postfix operators with configurable associativity."
date = "2025-08-14T14:23:41Z"
duration = 3717
weight = 2
youtube_id = "dcigPW9F__w"
collection = "compiler_from_scratch"

[[chapters]]
title = "Creating the expression AST"
time = "00:00:00"
start = 0

[[chapters]]
title = "Setting up parser state and token advancement"
time = "00:01:21"
start = 81

[[chapters]]
title = "Parsing beyond the first integer"
time = "00:05:00"
start = 300

[[chapters]]
title = "Building a left-leaning expression tree"
time = "00:07:30"
start = 450

[[chapters]]
title = "Extending the tree with binary nodes"
time = "00:10:00"
start = 600

[[chapters]]
title = "Building a right-leaning tree recursively"
time = "00:14:51"
start = 891

[[chapters]]
title = "Unifying the two tree-building functions"
time = "00:17:30"
start = 1050

[[chapters]]
title = "Choosing the tree direction"
time = "00:20:00"
start = 1200

[[chapters]]
title = "Understanding operator binding"
time = "00:21:48"
start = 1308

[[chapters]]
title = "Passing previous and next binding powers"
time = "00:24:41"
start = 1481

[[chapters]]
title = "Assigning powers to precedence groups"
time = "00:27:30"
start = 1650

[[chapters]]
title = "Updating power across recursive calls"
time = "00:30:00"
start = 1800

[[chapters]]
title = "Controlling recursion with the Pratt loop"
time = "00:32:30"
start = 1950

[[chapters]]
title = "Refactoring into parseExpression"
time = "00:35:00"
start = 2100

[[chapters]]
title = "Parsing identifiers as prefix expressions"
time = "00:37:30"
start = 2250

[[chapters]]
title = "Replacing switches with parse-function tables"
time = "00:40:00"
start = 2400

[[chapters]]
title = "Adding unary postfix nodes"
time = "00:42:30"
start = 2550

[[chapters]]
title = "Giving postfix operators higher precedence"
time = "00:45:00"
start = 2700

[[chapters]]
title = "Naming precedence levels"
time = "00:47:30"
start = 2850

[[chapters]]
title = "Grouping parse functions and powers into rules"
time = "00:49:03"
start = 2943

[[chapters]]
title = "Adding unary prefix operators"
time = "00:52:30"
start = 3150

[[chapters]]
title = "Reusing a token in prefix and infix positions"
time = "00:55:00"
start = 3300

[[chapters]]
title = "Understanding equal powers and associativity"
time = "00:56:52"
start = 3412

[[chapters]]
title = "Supporting explicitly right-associative rules"
time = "01:00:00"
start = 3600
+++

Build a precedence-aware Pratt parser that turns Fyn expressions into an AST while supporting prefix, infix, and postfix operators with configurable associativity.
