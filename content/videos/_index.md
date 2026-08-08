+++
title = "Videos"
description = "Recordings of my programming projects."

[[series]]
title = "Compiler Toolchain Development"
description = "A detailed build of a compiler toolchain in Go working up through each layer from the bottom, starting with an x86-64 encoder and continuing through object files, an assembler, MIR, IR, scanner, parser, and type checker."
data = "compiler_toolchain"

[[series.video_groups]]
id = "compiler-toolchain"
title = "All Videos"
url = "https://www.youtube.com/playlist?list=PLfwYKZej86Po9QdiPknTLbtWyeUD7rKlP"
link_text = "YouTube playlist"

[[series.video_groups]]
id = "x86-64-encoder"
title = "x86-64 Encoder"
url = "https://www.youtube.com/playlist?list=PLfwYKZej86PrERg1ho6r17PyXmFUD5CZ_"
subseries = "x86_64_encoder"
link_text = "YouTube playlist"

[[series]]
title = "Compiler From Scratch (2025 Archive)"
description = "An earlier compiler implementation that spans 19 hours implementing a scanner, parser, type checker, simple IR, and finally generates x64 machine code and a PE32+ executable on Windows."
data = "compiler_from_scratch"

[[series.video_groups]]
id = "compiler-from-scratch"
title = "All Videos"
url = "https://www.youtube.com/playlist?list=PLfwYKZej86PpEFsy6HQB9WQIlIGmfOy_s"
link_text = "YouTube playlist"

[[series]]
title = "Tree-Walk Interpreter in JavaScript (2025 Archive)"
description = "This is an old series of videos that spans 2 hours implementing a very simple tree-walk interpreter written in JavaScript."
data = "js_treewalk_interpreter"

[[series.video_groups]]
id = "tree-walk-interpreter"
title = "All Videos"
url = "https://www.youtube.com/playlist?list=PLTrjUW-dLpeY"
link_text = "YouTube playlist"

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "x86_64 Instruction Encoding Overview"
url = "https://www.youtube.com/watch?v=8RlQXKfhcL4"
tags = ["encoding_overview"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding SYSCALL and RET with NASM Listing Tests"
url = "https://www.youtube.com/watch?v=th7CxsGH1mQ"
tags = ["test_harness"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding Register Operands with ModRM and MOV"
url = "https://www.youtube.com/watch?v=iP987vd0MVw"
tags = ["modrm", "register_operands"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding Memory Operands with ModRM and MOV"
url = "https://www.youtube.com/watch?v=y0deHiZQ5d0"
tags = ["modrm", "memory_operands"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding SIB Addressing and Displacements with MOV"
url = "https://www.youtube.com/watch?v=6KdiUu73QUo"
tags = ["sib"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding RIP-Relative and Explicit Displacements with MOV"
url = "https://www.youtube.com/watch?v=PEATp-H1c4c"
tags = ["rip_relative"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Matching Instruction Forms with MOV"
url = "https://www.youtube.com/watch?v=xtfKuE9pvUw"
tags = ["form_matching"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding MOV Immediates, +r, and /digit Forms"
url = "https://www.youtube.com/watch?v=-IDHFhZ-dV4"
tags = ["immediates", "form_scoring"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding Op/En Metadata for MOV Forms"
url = "https://www.youtube.com/watch?v=gnq_J2sKstA"
tags = ["op_en"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding ADD/SUB, MUL/DIV, and IMUL/IDIV"
url = "https://www.youtube.com/watch?v=Hq9JXR09qqU"
tags = ["immediate_widths"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding AND/OR/XOR, TEST, NOT, and NEG"
url = "https://www.youtube.com/watch?v=VQcDFEbvZ_A"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding SAL/SHL/SHR/SAR and RCL/RCR/ROL/ROR"
url = "https://www.youtube.com/watch?v=yaWnN-hrX8c"
tags = ["implicit_operands"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding CMP, CMOVcc, and SETcc"
url = "https://www.youtube.com/watch?v=gzORplUWGsI"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PUSH/POP, JMP/Jcc, and CALL"
url = "https://www.youtube.com/watch?v=sSm3DlHqtBs"
tags = ["relative_displacements"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding LEA, MOVSX/MOVSXD/MOVZX, and CBW-CQO"
url = "https://www.youtube.com/watch?v=jetqAr1R3WA"
tags = ["operand_widths"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding BSF/BSR, BT/BTC/BTR/BTS, LZCNT/TZCNT, and POPCNT"
url = "https://www.youtube.com/watch?v=Jm1KCxteQgc"
tags = ["mandatory_prefixes"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding POP r/m, JECXZ/JRCXZ, CPUID/RDTSC, NOP, and XCHG"
url = "https://www.youtube.com/watch?v=jk7JGn8CQOg"
tags = ["memory_displacements"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding Legacy SSE/VEX/EVEX Prefixes with MOVAPS and VMOVAP"
url = "https://www.youtube.com/watch?v=blaCwZGXafY"
tags = ["vex_evex_prefixes"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding EVEX Masks with MOVAPS/PD, VMOVAPS/PD, MOVUPS/PD, and VMOVUPS/PD"
url = "https://www.youtube.com/watch?v=TF1bhofjewM"
tags = ["opmasks"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding MOVSS/SD, VMOVSS/SD, MOVDQA/U, and VMOVDQA/U/8/16/32/64"
url = "https://www.youtube.com/watch?v=e7uA5UhO0VY"
tags = ["form_matching"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding EVEX Rounding/Broadcasts with ADD/VADD, VSUB, VMUL, and VDIV SS/SD/PS/PD"
url = "https://www.youtube.com/watch?v=VawHWPuoPdw"
tags = ["embedded_rounding", "broadcasts"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding EVEX Compressed Disp8 and Tuple Types"
url = "https://www.youtube.com/watch?v=8dvh-1A9G5Q"
tags = ["compressed_disp8"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding SAE with COMISS/SD, UCOMISS/SD, and SHUF/VSHUF PS/PD"
url = "https://www.youtube.com/watch?v=wf7IY6UPEqo"
tags = ["sae"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding GPR/XMM Transfers with MOVD/Q and VMOVD/Q"
url = "https://www.youtube.com/watch?v=tc69PslRYlE"
tags = ["vex_w"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding CVT/VCVT and CVTT/VCVTT Scalar SS/SD Conversions"
url = "https://www.youtube.com/watch?v=NN6pQSRh514"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding CVT/VCVT and CVTT/VCVTT Packed PS/PD/DQ Conversions"
url = "https://www.youtube.com/watch?v=0drIPmApkaY"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding CMP/VCMP SS/SD/PS/PD and PCMPEQ/PCMPGT B/W/D/Q"
url = "https://www.youtube.com/watch?v=3T_z2JboWZo"
tags = ["opmasks"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding LOCK/REP Prefixes and CS/SS/DS/ES/FS/GS Segments"
url = "https://www.youtube.com/watch?v=y63Ei_TmMe0"
tags = ["prefixes"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding MOVS/CMPS/LODS/SCAS/STOS, CMPXCHG/XADD, Fences, and Cache Ops"
url = "https://www.youtube.com/watch?v=Fo7cfeQII2I"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding Flags, INT/UD, RDTSCP/XGETBV, RDRAND/SEED, IRET/SYSRET, and ENTER/LEAVE"
url = "https://www.youtube.com/watch?v=IrV6mYwPIfw"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding ADC/SBB, INC/DEC, SHLD/SHRD, BSWAP, MOVBE, and CRC32"
url = "https://www.youtube.com/watch?v=-ZlTGBzthf8"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding ANDN, BEXTR, BZHI, MULX, PDEP/PEXT, RORX, SARX/SHLX/SHRX"
url = "https://www.youtube.com/watch?v=1sG-RquYZ2k"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding AND/ANDN/OR/XOR PS/PD, MIN/MAX, SQRT, RCP, and RSQRT"
url = "https://www.youtube.com/watch?v=ssxVl_AW7Mc"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Generating Go Tests from NASM Comments"
url = "https://www.youtube.com/watch?v=Ud4xPNtFtro"
tags = ["test_generation"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding BLEND/VBLEND, PBLEND, DP, INSERTPS, and EXTRACTPS"
url = "https://www.youtube.com/watch?v=529wN3hI0WE"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding LDDQU, MOVDUP, MOVHL/LHPS, MOVH/LPS/PD, MOVMSK, MOVNT, and VMASKMOV"
url = "https://www.youtube.com/watch?v=pxX3-D9jrgs"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding AESENC/LAST, AESDEC/LAST, AESIMC, AESKEYGENASSIST, and PCLMULQDQ"
url = "https://www.youtube.com/watch?v=KOTxUiW9M-0"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PADD/PSUB, PADDS/PSUBS, and PADDUS/PSUBUS"
url = "https://www.youtube.com/watch?v=voPAAA7MV0g"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PMADD, PMULDQ/UDQ, PMULH, and PMULL"
url = "https://www.youtube.com/watch?v=4jZRI9Ud01c"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PAVG, PMAXS/U, PMINS/U, and PSIGN"
url = "https://www.youtube.com/watch?v=kgOKJfWQ58s"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PACKSS, PACKUS, PUNPCKL, and PUNPCKH"
url = "https://www.youtube.com/watch?v=zYjBxaJxJ4M"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PSHUFB/D/LW/HW and PALIGNR"
url = "https://www.youtube.com/watch?v=8E6t9TVqy6U"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PSLL, PSRA, PSRL, VPSLLV, VPSRAV, and VPSRLV"
url = "https://www.youtube.com/watch?v=O0Ye6llavn0"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PMOVMSKB, PMOVSX, PMOVZX, PEXTR, and PINSR"
url = "https://www.youtube.com/watch?v=VMPhNiPiWPE"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding PABS, PAND, PANDN, POR, PXOR, and PTEST"
url = "https://www.youtube.com/watch?v=NRu91bOvX-Y"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VPBLENDD, VPBROADCAST, VBROADCAST, VINSERT, and VEXTRACT"
url = "https://www.youtube.com/watch?v=Z7UcyyDQA7Q"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VPERM2F128, VPERMW/D/Q, VPERMILPS, and VPERMPS/PD"
url = "https://www.youtube.com/watch?v=Cvgy8aKOSPk"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VBROADCAST, VCVTPD2PH, VCVTPH2PD/PS/PSX, and VCVTPS2PH/PHX"
url = "https://www.youtube.com/watch?v=BfwqibEVOuk"
tags = ["opcode_maps"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VFMADD, VFMSUB, VFNMADD, and VFNMSUB"
url = "https://www.youtube.com/watch?v=JXsi9MNRSCk"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VGATHER, VSCATTER, VPGATHER, and VPSCATTER"
url = "https://www.youtube.com/watch?v=1Fqz5ZAV960"
tags = ["vsib"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding AVX-512 Mask Register Instructions"
url = "https://www.youtube.com/watch?v=8pkeLX1wDyc"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VPCMP, VPMOV, and VPMASKMOV"
url = "https://www.youtube.com/watch?v=zZwUSIC7YK8"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding UNPCKL, UNPCKH, ROUND, LDMXCSR, and STMXCSR"
url = "https://www.youtube.com/watch?v=2b8wgdFGXrA"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding VPERM2I128, VPERMILPD, VZEROUPPER, and VZEROALL"
url = "https://www.youtube.com/watch?v=DveZs8OR_dQ"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Encoding CMPXCHG8B/16B, CLD, STD, and ENDBR64"
url = "https://www.youtube.com/watch?v=rD2Wn2idNMw"
tags = ["form_filling"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Cleanup and Validation"
url = "https://www.youtube.com/watch?v=K5Qn69Aezhw"
tags = ["validation"]

[[video_data.compiler_toolchain]]
subseries = "x86_64_encoder"
title = "Improving Performance"
url = "https://www.youtube.com/watch?v=LhcW-OqLdQM"
tags = ["performance"]

[[video_data.compiler_from_scratch]]
title = "Building a Scanner"
url = "https://www.youtube.com/watch?v=yFV8zv6bluU"
tags = ["scanner"]

[[video_data.compiler_from_scratch]]
title = "Building a Pratt Parser"
url = "https://www.youtube.com/watch?v=dcigPW9F__w"
tags = ["parser"]

[[video_data.compiler_from_scratch]]
title = "Building Parser Test Infrastructure"
url = "https://www.youtube.com/watch?v=p8SpOSzx0-M"
tags = ["parser_tests"]

[[video_data.compiler_from_scratch]]
title = "Parsing Functions and Improving Parser Errors"
url = "https://www.youtube.com/watch?v=_sJnIuUQLOw"
tags = ["diagnostics", "functions"]

[[video_data.compiler_from_scratch]]
title = "Building a Type Checker"
url = "https://www.youtube.com/watch?v=24_SQQfbHpI"
tags = ["type_checker"]

[[video_data.compiler_from_scratch]]
title = "Type-Checking Return Statements"
url = "https://www.youtube.com/watch?v=jJzlVNKWGuc"
tags = ["type_checker", "name_lookup"]

[[video_data.compiler_from_scratch]]
title = "Generating Basic IR"
url = "https://www.youtube.com/watch?v=EkjCeu1IUSc"
tags = ["ir"]

[[video_data.compiler_from_scratch]]
title = "Intel SDM, Vol 1, Basic Execution Environment and Procedures"
url = "https://www.youtube.com/watch?v=mZ68eiPGgsk"
tags = ["manual_study"]

[[video_data.compiler_from_scratch]]
title = "Intel SDM Vol 2, Instruction Format and Encoding"
url = "https://www.youtube.com/watch?v=LuyEd6PU22w"
tags = ["manual_study"]

[[video_data.compiler_from_scratch]]
title = "Encoding Register-to-Register MOV"
url = "https://www.youtube.com/watch?v=RcZnbwzX5-E"
tags = ["modrm", "register_operands"]

[[video_data.compiler_from_scratch]]
title = "Encoding Register/Memory MOV"
url = "https://www.youtube.com/watch?v=_Q0A6imwIaw"
tags = ["modrm", "memory_operands"]

[[video_data.compiler_from_scratch]]
title = "Encoding Memory Displacements"
url = "https://www.youtube.com/watch?v=SkYzSXls1F0"
tags = ["memory_displacements"]

[[video_data.compiler_from_scratch]]
title = "Encoding Scaled-Index Addressing"
url = "https://www.youtube.com/watch?v=ArDIhTlYwIc"
tags = ["sib"]

[[video_data.compiler_from_scratch]]
title = "Encoding Immediate MOV"
url = "https://www.youtube.com/watch?v=i14QVAstXBw"
tags = ["immediates"]

[[video_data.compiler_from_scratch]]
title = "Improving x86-64 Encoder Tests"
url = "https://www.youtube.com/watch?v=slEJOs0YSg4"
tags = ["test_harness"]

[[video_data.compiler_from_scratch]]
title = "Encoding LEA, ADD, and SUB"
url = "https://www.youtube.com/watch?v=un9mANWML2A"
tags = ["encoder"]

[[video_data.compiler_from_scratch]]
title = "Encoding MUL, DIV, and RET"
url = "https://www.youtube.com/watch?v=-fwf4Ued6Tw"
tags = ["encoder"]

[[video_data.compiler_from_scratch]]
title = "Lowering IR to x86-64 Machine Code"
url = "https://www.youtube.com/watch?v=x-bIeQ-qlz4"
tags = ["lowering"]

[[video_data.compiler_from_scratch]]
title = "Writing PE32+ Executables"
url = "https://www.youtube.com/watch?v=BwcPKuHLUUo"
tags = ["pe32"]

[[video_data.js_treewalk_interpreter]]
title = "Writing a Scanner"
url = "https://www.youtube.com/watch?v=t5p8Qsc7PrU"
tags = ["scanner"]

[[video_data.js_treewalk_interpreter]]
title = "Writing a TDOP/Pratt Parser"
url = "https://www.youtube.com/watch?v=jbJsUKkuUlU"
tags = ["parser"]

[[video_data.js_treewalk_interpreter]]
title = "Writing a Tree-Walk Interpreter"
url = "https://www.youtube.com/watch?v=if7EJ3Jg0-o"
tags = ["interpreter"]

[[video_data.js_treewalk_interpreter]]
title = "Adding Unary Prefix Operators"
url = "https://www.youtube.com/watch?v=S3IdDp9vKUY"
tags = ["operators"]

[[video_data.js_treewalk_interpreter]]
title = "Adding Unary Postfix Operators"
url = "https://www.youtube.com/watch?v=j7T2LNTelBo"
tags = ["operators"]

[[video_data.js_treewalk_interpreter]]
title = "Changing Order of Operations with Groups"
url = "https://www.youtube.com/watch?v=nJjp4oE0QIo"
tags = ["grouping"]

[[video_data.js_treewalk_interpreter]]
title = "Parsing Expression Statements"
url = "https://www.youtube.com/watch?v=fgcjweNr2TA"
tags = ["statements"]

[[video_data.js_treewalk_interpreter]]
title = "Adding Return Statements"
url = "https://www.youtube.com/watch?v=andeu6oLy0A"
tags = ["returns"]

[[video_data.js_treewalk_interpreter]]
title = "Executing Functions"
url = "https://www.youtube.com/watch?v=AoUce9PqSI0"
tags = ["functions"]

[[video_data.js_treewalk_interpreter]]
title = "Variables, Block Statements, and Nested Block Returns"
url = "https://www.youtube.com/watch?v=WpIhU7oeoSk"
tags = ["variables"]

[[video_data.js_treewalk_interpreter]]
title = "Parsing and Executing Function Calls"
url = "https://www.youtube.com/watch?v=WRlsSH6hRds"
tags = ["calls"]


[video_tag_colours.blue]
background = "#e8eef8"
text = "#374668"

[video_tag_colours.grey]
background = "#ececec"
text = "#555"

[video_tag_colours.green]
background = "#e7f3eb"
text = "#356044"

[video_tag_colours.orange]
background = "#fff0d7"
text = "#79521a"

[video_tag_colours.purple]
background = "#eee9f8"
text = "#59417b"

[video_tags]
broadcasts = { label = "Memory broadcasts", colour = "blue" }
calls = { label = "Calls", colour = "green" }
compressed_disp8 = { label = "Compressed disp8", colour = "blue" }
diagnostics = { label = "Diagnostics", colour = "orange" }
embedded_rounding = { label = "Embedded rounding", colour = "blue" }
encoder = { label = "Encoder", colour = "blue" }
encoding_overview = { label = "Encoding overview", colour = "blue" }
memory_displacements = { label = "Memory displacements", colour = "blue" }
form_filling = { label = "Form filling", colour = "grey" }
form_matching = { label = "Form matching", colour = "blue" }
form_scoring = { label = "Form scoring", colour = "blue" }
functions = { label = "Functions", colour = "green" }
grouping = { label = "Grouping", colour = "green" }
immediates = { label = "Immediates", colour = "blue" }
immediate_widths = { label = "Immediate widths", colour = "blue" }
implicit_operands = { label = "Implicit operands", colour = "blue" }
interpreter = { label = "Interpreter", colour = "green" }
ir = { label = "IR", colour = "purple" }
lowering = { label = "Lowering", colour = "purple" }
mandatory_prefixes = { label = "Mandatory prefixes", colour = "blue" }
manual_study = { label = "Manual study", colour = "purple" }
register_operands = { label = "Register operands", colour = "blue" }
memory_operands = { label = "Memory operands", colour = "blue" }
modrm = { label = "ModRM", colour = "blue" }
name_lookup = { label = "Name lookup", colour = "green" }
opcode_maps = { label = "Opcode maps", colour = "blue" }
op_en = { label = "Op/En", colour = "blue" }
operators = { label = "Operators", colour = "green" }
operand_widths = { label = "Operand widths", colour = "blue" }
opmasks = { label = "Opmasks", colour = "blue" }
parser = { label = "Parser", colour = "green" }
parser_tests = { label = "Parser tests", colour = "green" }
pe32 = { label = "PE32+", colour = "purple" }
performance = { label = "Performance", colour = "orange" }
prefixes = { label = "Prefixes", colour = "blue" }
relative_displacements = { label = "Relative displacements", colour = "blue" }
returns = { label = "Returns", colour = "green" }
rip_relative = { label = "RIP-relative", colour = "blue" }
sae = { label = "SAE", colour = "blue" }
scanner = { label = "Scanner", colour = "green" }
sib = { label = "SIB", colour = "blue" }
statements = { label = "Statements", colour = "green" }
test_generation = { label = "Test generation", colour = "blue" }
test_harness = { label = "Test harness", colour = "blue" }
type_checker = { label = "Type checker", colour = "green" }
validation = { label = "Validation", colour = "blue" }
variables = { label = "Variables", colour = "green" }
vex_evex_prefixes = { label = "VEX/EVEX prefixes", colour = "blue" }
vex_w = { label = "VEX.W", colour = "blue" }
vsib = { label = "VSIB", colour = "blue" }
+++
