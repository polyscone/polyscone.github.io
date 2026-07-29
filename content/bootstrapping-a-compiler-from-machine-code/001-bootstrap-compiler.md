+++
title = "Building the First Bootstrap Compiler"
description = "Writing a self-hosting compiler directly in x86-64 machine code that converts hexadecimal source text into executable bytes and supports comments."
date = 2026-07-30
draft = false
tags = ["Compiler", "x86_64", "PE32+", "Windows"]
+++

## Preparing New Imports

In the previous post I set up a working executable that could call the [`GetProcessVersion`](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getprocessversion) function which was imported from `kernel32.dll`.

This is a good start because it means I've got access to everything I need to start writing the initial bootstrap compiler. So, in this post I'll get a basic initial bootstrap compiler up and running that can compile a source file that contains binary in the form of hex ASCII characters, and comments, which I can use to annotate my machine code to make it easier to follow.

Before looking at the code in the `.text` section though, I think I should prepare my import data in advance so I can just focus on the code without having to jump between the sections and adjusting RVAs all the time.

Once the new import data has been sorted out I should be able to focus solely on the code and how it all works without any distractions.

In order to write the initial compiler I'll need a few different functions from `kernel32.dll`, and I can drop the `GetProcessVersion` import.

The functions I need relate to file I/O and they are: [`CreateFileA`](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea), [`ReadFile`](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile), and [`WriteFile`](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile).

I'll use `CreateFileA` to create the output file that I'll write my newly compiled executable data to, `ReadFile` to read bytes one by one from the input source file, and `WriteFile` to write bytes one by one to the output file I create with `CreateFileA`.

I'll be reading and writing bytes one at a time to keep the implementation as simple as possible; I will be manually encoding instructions, after all...

In my current `rei_0.exe` file I'm importing only the `GetProcessVersion` function, but I don't have any use for this function any more, so I need to replace it with imports to the three file I/O functions I just went over.

All I need to do is open up `rei_0.exe` in a hex editor and edit the `.rdata` section. The IAT, Import Lookup Table, and Hint/Name Table will all need to change to let Windows know about the new imports.

The IAT and Import Lookup Table come first. Each entry in these arrays is eight bytes in size, and I need four entries in each array; three entries to define the three functions I want to import, and one null entry to identify the end of the array. This means my IAT and Import Lookup Table combined will take up 64 bytes in total.

As mentioned in the previous post the IAT is a copy of the Import Lookup Table, so I'll just define the IAT and then duplicate it for the Import Lookup Table data.

The current IAT starts at offset `0x438` on disk, and if I look at the bytes starting at the IAT all the way up to the end of the hint/name table I should see the following:

{{<hextable start="0x430">}}
.. .. .. .. .. .. .. .. 58 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 <58 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00> 00 00 47 65 74 50 72 6f
63 65 73 73 56 65 72 73 69 6f 6e 00
{{</hextable>}}

I've highlighted the Import Lookup Table, which comes between the IAT and the Hint/Name Table.

If I were to replace the IAT and Import Lookup Table with 64 null bytes then the Hint/Name Table would be pushed up to start at offset `0x478`, instead of the current `0x458`.

This is what the IAT, Import Lookup Table, and current Hint/Name Table look like if I do this, again with the Import Lookup Table bytes highlighted:

{{<hextable start="0x430">}}
.. .. .. .. .. .. .. .. 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 <00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00> 00 00 47 65 74 50 72 6f
63 65 73 73 56 65 72 73 69 6f 6e 00
{{</hextable>}}

Because of this I'll need to use the RVA `0x2078` as the start of my hint/name table.

{{<note>}}
Remember that the `.rdata` section starting at the on-disk offset `0x400` will be mapped into virtual memory starting at RVA `0x2000`, meaning the on-disk offset `0x478` will be translated to RVA `0x2078`.
{{</note>}}

The simplest way to get the RVAs that I need to populate the IAT and Import Lookup Table with is to just fill out the Hint/Name Table first and then fill out the IAT and Import Lookup Table afterwards, copying the start addresses for each hint/name entry as required.

I'll define my import function names in the order `CreateFileA`, `ReadFile`, and then `WriteFile`. Each function name will start with two null bytes because I don't know the hints, followed by a null-terminated string of the function name itself, and then a padding byte that I'll include if the null-terminating byte of the string falls on an even offset.

Starting at offset `0x478` my new Hint/Name Table will look like this:

{{<hextable start="0x470">}}
.. .. .. .. .. .. .. .. <00> 00 43 72 65 61 74 65
46 69 6c 65 41 00 <00> 00 52 65 61 64 46 69 6c 65
00 00 <00> 00 57 72 69 74 65 46 69 6c 65 00
{{</hextable>}}

I've highlighted the starting byte of each entry in the Hint/Name Table. As you can see, they all start on an even offset due to the padding byte that gets added if the null-terminating byte of the previous string ended on an even offset.

From this table I can see that the on-disk offsets of the function names are:

- `CreateFileA` → `0x478`
- `ReadFile` → `0x486`
- `WriteFile` → `0x492`

Since the on-disk offset `0x400` is mapped to the RVA `0x2000`, so these file offsets translate to the RVAs:

- `CreateFileA` → `0x2078`
- `ReadFile` → `0x2086`
- `WriteFile` → `0x2092`

If I fill out each eight byte entry in the IAT with each of these RVAs, and then duplicate the IAT into the Import Lookup Table bytes, the full data for the IAT, Import Lookup Table, and Hint/Name Table should look like this, again with the Import Lookup Table highlighted:

{{<hextable start="0x430">}}
.. .. .. .. .. .. .. .. 78 20 00 00 00 00 00 00
86 20 00 00 00 00 00 00 92 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 <78 20 00 00 00 00 00 00
86 20 00 00 00 00 00 00 92 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00> 00 00 43 72 65 61 74 65
46 69 6c 65 41 00 00 00 52 65 61 64 46 69 6c 65
00 00 00 00 57 72 69 74 65 46 69 6c 65 00
{{</hextable>}}

With these changes I also need to update the address of the Import Lookup Table in the Import Directory Table that starts at offset `0x400` and currently looks like this:

{{<hextable start="0x400">}}
<48 20 00 00> 00 00 00 00 00 00 00 00 <28 20 00 00>
<38 20 00 00> 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
{{</hextable>}}

I've highlighted the old Import Lookup Table RVA (`0x2048`), the DLL name RVA (`0x2028`), and the IAT RVA (`0x2038`).

Due to the positioning of the DLL name string and the IAT they haven't moved at all even with the new data being added, but the Import Lookup Table now starts at RVA `0x2058`, so updating it leaves me with this:

{{<hextable start="0x400">}}
<58 20 00 00> 00 00 00 00 00 00 00 00 <28 20 00 00>
<38 20 00 00> 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
{{</hextable>}}

Now the only thing I need to update is the data directories section at the beginning of the executable starting at offset `0xc8`. This is what it currently looks like:

{{<hextable start="0xc0">}}
.. .. .. .. .. .. .. .. 00 00 00 00 00 00 00 00
<00 20 00 00 28 00 00 00> 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 <38 20 00 00 10 00 00 00>
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
{{</hextable>}}

The highlighted sections are the Import Table and IAT data-directory entries, which describe the RVA and size of the Import Directory Table and IAT respectively.

The Import Directory Table's RVA and size haven't changed, and neither has the RVA of the IAT, but the IAT has increased in size from 16 bytes, which is what it was before, to 32 bytes. Because of this I need to update the size from `10 00 00 00` to `20 00 00 00`. Making the changes leaves me with the following data directories:

{{<hextable start="0xc0">}}
.. .. .. .. .. .. .. .. 00 00 00 00 00 00 00 00
<00 20 00 00 28 00 00 00> 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 <38 20 00 00 20 00 00 00>
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
{{</hextable>}}

## Preparing String Data

I know that as part of this program I'll need to open and write files, and I'll need to store a couple of file names to do that. The only two strings I need are one that defines the file name to open for reading and another that defines the file name to create/open for writing.

I'll assume that both files are in the same directory as the executable itself and I'll read a program from `"a.rei_0"` and write a program to `"a.exe"`.

Both of these strings should be null-terminated, meaning they end with a null byte, and they can go anywhere in the `.rdata` section. I'll put them close together at the very end to keep things simple.

Making sure to include the null terminator, the `"a.rei_0"` file name is 8 bytes in length and the `"a.exe"` file name is 6 bytes in length. I'll store both strings directly next to each other in the last 14 bytes of the `.rdata` section, which means `"a.rei_0"` starts at file offset `0x5f2` and `"a.exe"` starts at file offset `0x5fa`:

{{<hextable start="0x5f0">}}
.. .. 61 2E 72 65 69 5F 30 00 61 2E 65 78 65 00
{{</hextable>}}

Because offset `0x400` in the file maps to RVA `0x2000`, I can reference RVA `0x21f2` for the `"a.rei_0"` string and RVA `0x21fa` for the `"a.exe"` string when writing the actual code for the program.

{{<note>}}
Offset `0x400` on disk is mapped to RVA `0x2000`, so `0x400` should be treated as the base. That means the string data for `"a.rei_0"`, for example, starts `0x1f2` bytes into the section making its RVA `0x21f2`.
{{</note>}}

## Execution Context

Before writing the machine code I need to establish the parts of the x86-64 execution model and Microsoft ABI that the compiler uses.

### General Purpose CPU Registers

An x86-64 CPU has 16 general-purpose registers: `rax`, `rcx`, `rdx`, `rbx`, `rsp`, `rbp`, `rsi`, `rdi`, and `r8`-`r15`. Different names select different-sized portions of the same register. For example, `rax`, `eax`, and `al` refer to its low 64, 32, and 8 bits, while `r8`, `r8d`, and `r8b` do the same for register 8.

Writing a 32-bit register clears the upper 32 bits of the corresponding 64-bit register. The compiler uses this when it writes values to `eax`, `ecx`, or `edx` without needing a larger 64-bit encoding.

{{<img src="images/gpr-register-names-en.png" alt="Examples of x86-64 general-purpose register naming patterns">}}

### Special Registers and the Stack

The `rip` register contains the address of the next instruction. The compiler uses it indirectly for RIP-relative addressing, where an instruction identifies code or data with a signed 32-bit displacement from `rip`.

The `rsp` register points to the top of the current thread's stack. The stack grows towards lower addresses, so a function subtracts from `rsp` to allocate a frame and adds the same amount before returning. Instructions such as `call`, `ret`, `push`, and `pop` also update it automatically.

Finally, the `RFLAGS` register contains status bits updated by many arithmetic and logical instructions. The compiler's comparisons set these flags, and conditional jumps inspect them.

### The Microsoft x64 Calling Convention

The compiler calls Win32 functions, so it follows the [Microsoft x64 calling convention](https://docs.microsoft.com/en-us/cpp/build/x64-calling-convention). The relevant rules are stack alignment, argument and return-value placement, register volatility, and shadow space.

#### Alignment

The stack pointer must be aligned to a 16-byte boundary at each call site. A `call` instruction first pushes an eight-byte return address, so a function normally enters eight bytes away from that boundary. A function that makes another call therefore allocates a frame whose size is eight modulo 16; a frame containing only the mandatory 32-byte shadow space would normally be 40 bytes (`0x28`) because of adding an extra 8 bytes to satisfy the 16-byte alignment.

#### Arguments and Returns

The first four integer or pointer arguments go in `rcx`, `rdx`, `r8`, and `r9`. Further arguments occupy consecutive eight-byte stack slots after the shadow space. At the caller's call site, argument five is at `[rsp+32]`, argument six at `[rsp+40]`, and so on. After `call` pushes the return address, the callee sees those same arguments at `[rsp+40]`, `[rsp+48]`, and so on.

For completeness, floating-point arguments in the first four positions use `xmm0`-`xmm3`; this compiler doesn't need them right now.

Integer and pointer return values use `rax`, which is how the compiler receives file handles and bytes from its function calls.

#### Volatile and Non-Volatile Registers

The registers `rax`, `rcx`, `rdx`, and `r8`-`r11` are volatile: a caller must assume a callee may overwrite them. The compiler therefore needs to keep values that must survive calls, such as file handles, on the stack.

The registers `rbx`, `rbp`, `rdi`, `rsi`, `rsp`, and `r12`-`r15` are non-volatile. A function that changes one must restore its original value before returning. In particular, every function below that subtracts from `rsp` adds the same amount back before `ret`.

#### Shadow Space

Before every call, the caller reserves 32 bytes of shadow space for the callee, even when the function takes fewer than four arguments. The callee may use this area to spill the four register arguments. Stack arguments follow it, which is why the fifth argument begins at `[rsp+32]` at the call site.

## Writing Machine Code

With the basics of the hardware and things like the Microsoft x64 calling convention out of the way I can now turn my attention to the `.text` section and implement the basic initial compiler.

### The Intel Software Developer's Manual

In order to figure out what machine code I should be writing I'll be using the [Intel Software Developer's Manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html), which detail everything you could want to know about Intel CPUs. Volume 2 is the instruction set reference and contains information about how instructions are encoded along with tables and references for all of the instructions available on the CPU.

### Instruction Format

Section 2.1 of volume 2 of the manuals describes the instruction format, where they have a diagram showing the meaning of each byte and what the bits in some of the bytes mean:

{{<img src="images/intel-instruction-format-en.png" alt="Instruction Encoding Format from the Intel Software Developer's Manuals">}}

When writing out the instructions in hex I just need to follow the order of the bytes as shown in the diagram.

First come any instruction prefixes. The one this compiler uses is the REX prefix, which selects a 64-bit operand and extends the register fields in the ModR/M and SIB bytes. It must appear immediately before the opcode.

After the prefixes come 1-3 instruction opcodes. It's the opcodes that tell the CPU what kind of instruction is being executed.

Then it's the ModR/M byte, if required, which is used in some instructions to specify the addressing mode and location of different operands. For example, in a `mov` instruction the ModR/M byte allows the CPU to know whether it's copying data to/from registers or memory based on the arrangement of bits in the byte.

The ModR/M byte can be a little confusing at first, but its encoding is described in section 2.1.5 complete with a simple example:

{{<img src="images/mod-rm-encoding-en.png" alt="ModR/M Byte Encoding from the Intel Software Developer's Manuals">}}

So bits 6 and 7 (the two most significant bits) in the byte represent the "Mod", bits 3, 4, and 5 represent the "REG", and finally bits 0, 1, and 2 represent the "R/M".

The "Mod" specifies the addressing mode and is used in combination with the "R/M" to specify the location of an `r/m` operand. The "REG" field either specifies an `r` operand or extends the opcode, depending on the instruction.

What then follows are some tables that can be used to find the encodings of specific combinations of these bits and what they mean:

{{<img src="images/mod-rm-addressing-forms-en.png" alt="ModR/M Addressing Forms from the Intel Software Developer's Manuals">}}

This table looks confusing, but it should become clearer when using it to figure out encodings for specific instructions.

This particular table shows 32-bit addressing forms. Most of the entries carry over naturally to 64-bit addressing, but there are some differences. The important one here is that the `mod=00`, `r/m=101` form becomes a 32-bit displacement relative to `rip` in 64-bit mode.

Similar to the ModR/M byte, next comes the SIB (Scale Index Base) byte which is used in scaled index addressing mode and is only added if required. The SIB byte also has its own table similar to that of the ModR/M byte that can be used when working out encodings for particular instructions.

Finally, an encoding may contain a displacement and/or an immediate value. An immediate is a value encoded directly in the instruction. These fields are not necessarily one byte wide: their sizes depend on the opcode, operand size, and addressing mode.

### Instruction Encodings

The only bit of preparation I want to do now is to figure out what all the different instruction encodings are that I might need to use. Thinking ahead a little there are a few different instructions I'll need to encode in order to write my program.

#### The `add` and `sub` Instructions

First of all I'll need to be able to do basic arithmetic, so I'll need to figure out the encodings for the `add` and `sub` instructions. These instructions are also what I'll use to move the stack pointer around, which is stored in the `rsp` register.

In order to figure out the encodings of the instructions I need to run I can just look at the tables that describe each specific instruction, and then if needed I can also use the addressing form tables and others to figure out encodings for things like the ModR/M byte. Section 3.1 explains how to interpret the information in the tables that describe each instruction.

Looking at the `add` instruction's documentation the only encoding I know for sure that I'll need is the one to add to the `rsp` register to move the top of the stack. I'll likely only be using small values in here to start with, so I think the encoding described in the `ADD r/m64, imm8` row will do for now.

I know I need this row because I don't expect I'll be adding anything outside the range of a signed byte to the `rsp` value, and the value I add will be hard-coded, meaning it's an "immediate" value; because of this, `imm8` fits the requirement for the source operand (the operand on the right side). Then, because I want to add to `rsp` it means I need to choose an encoding that selects a 64-bit register or memory location using the ModR/M byte, and out of the `imm8` rows the only choice that fits is the one with `r/m64` defined for the destination operand (the operand on the left side).

I can see that the encoding for the instruction described in the `ADD r/m64, imm8` row is `REX.W + 83 /0 ib`.

What this means is that I need to start the instruction with a `REX` prefix where the `W` bit is set. If I look at the manual for the `REX` prefix fields I can find the following table:

{{<img src="images/rex-prefix-fields-en.png" alt="REX Prefix Fields from the Intel Software Developer's Manuals">}}

So every REX prefix needs the highest 4 bits set as `0b0100`. I need to set bit `W` (bit 3) to `1`, which sets the operand size to be 64-bit, but it doesn't mention any of the other bits, so I can leave those as `0`. This gives me a byte with the bits `0b01001000`, which is `0x48` in hex.

This is then followed by the byte `0x83` for the actual opcode, and then there's a `/0`, which in section 3.1 is described as follows:

The `/digit` notation uses a digit between 0 and 7. It indicates that the instruction uses only the ModR/M byte's r/m (register or memory) operand, while the reg field contains a digit that extends the instruction's opcode.

In other words, the "Mod" and "R/M" bits of the Mod/RM byte are used in the addressing form table and the "REG" bits are used to extend the opcode, which just means that in the addressing form table I should look up the `/digit` column when finding the encoding I want, which in this case is `0`, and only change the "Mod" and "R/M" bits to select the row.

I know that I want to use the `add` instruction to add to the `rsp` register, and since the addressing form tables only specify up to 32-bit I know that I need to look for the `esp` row instead in the table. This lands me on an encoding of `c4` for the ModR/M byte.

After the `/0` is `ib`, which is described in section 3.1 as follows:

The `ib`, `iw`, `id`, and `io` notation describes a 1-byte, 2-byte, 4-byte, or 8-byte immediate operand following the opcode, ModR/M bytes, or scale-indexing bytes. The opcode determines whether the operand is signed, and multi-byte values are given with the low-order byte first.

So it's `ib`, rather than `iw`, `id`, or `io`, because it's saying that an immediate value in the form of a byte should come at the end of instruction encoding.

If I put all of this together I get `48 83 c4 <imm8>`, where the `<imm8>` at the end can be set to any signed 8-bit value to add to the `rsp` register.

If I follow this same process for the `sub` instruction I get the encoding `48 83 ec <imm8>`, where `<imm8>` can be replaced with any signed 8-bit value to subtract from the value in `rsp`. The encoding for `sub` in this case is the same as `add`, but this time the `/digit` was `/5`, which changed the extension to the opcode in the "REG" bits of the ModR/M byte to give an encoding of `ec` instead of `c4`.

I'm sure I'll need to look up other encodings for these instructions as I go, but these are the two I know without a doubt I'll need, so I'll mention others as they come up.

#### The `lea` Instruction

The next instruction I know that I'll need is `lea` which loads an effective address into a register. An effective address is essentially just a calculated virtual memory address. This will be useful for passing things like pointers to functions when I need to call them.

The table describing the `lea` instruction is short, but I know I'll be copying effective addresses into 64-bit registers, so I'll go by the `LEA r64,m` row for the encoding.

In `REX.W + 8D /r` once again `REX.W` shows up, which I already know is `0x48` followed by the opcode `0x8d`, which just leaves me with `/r`, which just means I need to look up by the register I want in the address form table.

There are two different encodings of `lea` I'm going to need. One will be used for loading the addresses of local variable in the stack, and the other will be for loading addresses of read-only data in the `.rdata` section, like the starting address of a file name string, for example. In the case where the address is on the stack I'll need to calculate it relative to the `rsp` register, and since the stack will be small I'll use an 8-bit wide displacement. For the case where I want to load an address from `.rdata` I'll instead do that relative to the `rip` register, which contains the address of the next instruction; since this is "RIP-relative addressing" it means the displacement will be a 32-bit wide signed integer.

If I assume that I want to load the effective address into the `rcx` register, then for the `rsp` relative calculation the ModR/M byte will be `4c`. This byte can change based on the register, for example loading into `rdx` would make it `54` instead, but it's easy to switch that out if I need to. In this case the "Effective Address" row says `[--][--]+disp8`, and there are notes below the table that say:

> The [--][--] nomenclature means a SIB follows the ModR/M byte.
>
> The disp32 nomenclature denotes a 32-bit displacement that follows the ModR/M byte (or the SIB byte if one is present) and that is added to the index.
>
> The disp8 nomenclature denotes an 8-bit displacement that follows the ModR/M byte (or the SIB byte if one is present) and that is sign-extended and added to the index.

So I need to add an SIB byte after the ModR/M byte and then add an 8-bit displacement byte after that which will be added to the index described by the SIB byte.

The SIB byte encoding is described in another table as follows:

{{<img src="images/sib-addressing-forms-en.png" alt="SIB Addressing Forms from the Intel Software Developer's Manuals">}}

Since I want to calculate an effective address relative to `rsp` that means I need to look at the `esp` column as the "base". I don't need a scaled index at all, so I can just use the `none` row to find the encoding `24`.

After the SIB byte is the 8-bit displacement byte, which can be anything I need it to be, so if I put it all together I get the encoding `48 8d <modrm> 24 <disp8>`. The `<modrm>` can be any encoding on the `[--][--]+disp8` row in the ModR/M addressing table; for example, `rcx` would be `4c`. The `<disp8>` can be any signed 8-bit displacement relative to the value in the `rsp` register.

Next is loading an effective address relative to the `rip` register. As mentioned, since this is RIP-relative addressing it means the displacement will be a 32-bit wide signed integer. Of course, I'll want to load the effective address into a 64-bit register again, so the encoding will start the same as the stack-relative instruction, but this time the ModR/M byte will be one of those along the `disp32` row in the ModR/M table followed by a 32-bit displacement relative to the value in `rip`.

If I wanted to store an effective address in the `rax` register which is calculated as a value relative to the value in `rip` then I would need to set the ModR/M byte to `05` and follow it with 4 bytes of displacement. For example, if I want to store the effective address `[rip+0x1072]`, which is +4,210 bytes relative to `rip`, I would need to encode the instruction as `48 8d 05 72 10 00 00`.

So I can generalise this by saying that the encoding for using `lea` with a 64-bit register and RIP-relative addressing is `48 8d <modrm> <disp32>`.

#### The `shl` Instruction

Part of the requirement for this version of the compiler is to convert ASCII hexadecimal characters into raw bytes. The ASCII representation of a byte in hex requires the use of two bytes, meaning that one byte in an ASCII text file represents one [nibble (half a byte)](https://en.wikipedia.org/wiki/Nibble) of a raw byte. Combined with the restriction that I'll be reading one byte at a time, this means that I'll need to store an ASCII byte's value somewhere, and then shift it up by 4 bits before combining it with the next byte. In order to do this I'll need to make use of the `shl` instruction to shift bits to the left.

The `shl` documentation is included under the "SAL/SAR/SHL/SHR" heading, where `sal` and `shl` are actually exactly the same, but `sar` and `shr` are slightly different.

Since I'm only going to be shifting the bits in a single byte I should be okay with the `SHL r/m8, imm8` instruction, which is `C0 /4 ib`. This means that I have the choice of any encoding in the `/4` column in the ModR/M table followed by a byte that describes the number of times I want to shift the bits to the left.

If I wanted to shift the byte in `al` by `4`, for example, then the full encoding of the instruction would be `c0 e0 04`.

#### The `or` Instruction

Since I'll be combining high and low nibbles to make raw byte values I'll need a way to combine the nibble I'm working on with a nibble that's already been converted and stored somewhere. For this I can just use the `or` instruction, which will combine the active bits of each operand into a single value.

Since I'll only be combining high and low nibbles to make byte values I'll use the `OR r8, r/m8` form. This has the opcode `0A /r`; the register operand is the destination and the register-or-memory operand is the source. Since I know I'll be storing the already converted nibble on the stack, I can look up the ModR/M and SIB bytes for an `rsp`-relative memory source and select `al` as the destination.

I think I'll just go with the `al` register for this purpose, since I'll be using the `rax` register to return bytes from a read function anyway.

In that case the `or` instruction's encoding will be `0a 44 24 <disp8>`, where `<disp8>` is a signed displacement from the value in `rsp`.

#### The `not` Instruction

I plan on keeping a 64-bit value on the stack that I'll use as a flag to know whether I've finished converting an ASCII character pair into a byte or not. When the flag is `0` it will mean that I still need to convert the rest of the ASCII character pair to the raw byte form, and when it's any other value it will mean that I need to write the converted byte out to the new executable file.

I'll encode the `NOT r/m64` instruction so that its operand size matches the 64-bit flag.

I'll want to execute this instruction on a value on the stack, so once again I'll need ModR/M and SIB bytes that allow me to describe an offset from the value in `rsp`; this leaves me with the encoding `48 f7 54 24 <disp8>`.

#### The `jmp` Instruction and its Variants

Luckily the `jmp` instruction and all of its conditional variants that I could imagine using are very simple as far as encoding goes. Since all I'll need is to be able to jump directly to nearby code I can just take the encodings from the `JMP rel8` or `JMP rel32` lines.

I'll take note of both the `rel8` and `rel32` instructions for each conditional jump as well (for example, `je`), because if I don't need to use a 32-bit operand then it's worth using the 8-bit operand instead to save on code size. The 16-bit operands (`rel16`) aren't supported in 64-bit mode, and if you look at the opcodes for them you'll see that they're actually the same as the 32-bit ones.

The opcodes for `JMP rel8` and `JMP rel32` are `eb <rel8>` and `e9 <rel32>` respectively. The conditional ones all follow the same pattern with different opcode bytes.

The `je` instruction is `74 <rel8>` and `0f 84 <rel32>`; `jl` is `7c <rel8>` and `0f 8c <rel32>`; `jg` is `7f <rel8>` and `0f 8f <rel32>`; and `jne` is `75 <rel8>` and `0f 85 <rel32>`. That should be enough jumps to easily write the logic needed for skipping comments and converting ASCII character pairs into their raw byte values.

#### The `call` Instruction

I'll need to use `call` in two different ways; one way will be to call my own functions _directly_ using a relative displacement, and the other way will be to call the imported Win32 API functions _indirectly_ through addresses in the IAT.

The first `call` encoding I'll look at is the direct one, which I'll use for functions in my own code. For this use case I'll need the `CALL rel32` instruction, which has the opcode `E8 cd`, meaning it's just `e8` followed by a 32-bit wide displacement which is relative to the value in the `rip` register. I'll just note this down as `e8 <rel32>`.

Next I need an indirect call, which means I want the `CALL r/m64` instruction, which has the opcode `FF /2`. For this instruction I know that I'll always want to make the call using RIP-relative addressing, so I need to choose the encoding for the ModR/M byte that's on the `disp32` row, and I'm fixed to the `/2` column by the opcode, so the ModR/M byte needs to be `15`, which is then followed by a 32-bit signed displacement relative to the value in the `rip` register. That makes the general form `ff 15 <disp32>`.

#### The `xor` Instruction

The only thing I want to use `xor` for is to zero out the `rax` register before returning at the end of the program. This is because integer return values use the `rax` register, and I want the program to finish with a `0` exit code if it ran successfully.

Since zeroing a register is as simple as `xor`ing that register with itself the instruction I could use for this one is `XOR r/m64, r64`, which has an opcode column of `REX.W + 31 /r`.

This would mean that the final encoding for `xor`ing `rax` with itself is `48 31 c0`.

There's something else to consider here though. That is, in 64-bit mode operands have a default size of 32-bits. When a 32-bit operand is used with a register it actually results in the full 64-bits of that register being set. Because of this I can actually remove the REX prefix `48` which leaves me with `31 c0` to run `xor` on `eax` instead for the same result in less code.

#### The `ret` Instruction

The `ret` instruction is the simplest of all the instructions I need to use and just transfers program control to a return address located on the top of the stack, which is usually placed there automatically by a `call` instruction.

The encoding for a return is a simple single-byte `c3`.

#### Recap

With all of that I now have the following reference for some of the basic instruction I think I'll need to use in the program:

- `add` → `48 83 c4 <imm8>` _(add to `rsp`)_
- `sub` → `48 83 ec <imm8>` _(subtract from `rsp`)_
- `lea` → `48 8d <modrm> 24 <disp8>` _(relative to `rsp` into a 64-bit register)_
- `lea` → `48 8d <modrm> <disp32>` _(RIP-relative into a 64-bit register)_
- `shl` → `c0 <modrm> <imm8>` _(shift an 8-bit register or memory operand selected by a ModR/M byte using the `/4` opcode extension)_
- `or` → `0a 44 24 <disp8>` _(`or` the byte relative to `rsp` into `al`)_
- `not` → `48 f7 54 24 <disp8>` _(invert a 64-bit value relative to `rsp`)_
- `jmp` → `eb <rel8>` and `e9 <rel32>` _(relative branch)_
- `je` → `74 <rel8>` and `0f 84 <rel32>` _(relative branch)_
- `jne` → `75 <rel8>` and `0f 85 <rel32>` _(relative branch)_
- `jl` → `7c <rel8>` and `0f 8c <rel32>` _(relative branch)_
- `jg` → `7f <rel8>` and `0f 8f <rel32>` _(relative branch)_
- `call` → `e8 <rel32>` _(relative, direct call)_
- `call` → `ff 15 <disp32>` _(RIP-relative, indirect call through memory)_
- `xor` → `31 c0` _(for zeroing the value in `eax`/`rax`)_
- `ret` → `c3`

The remaining `mov`, `cmp`, `add`, and `sub` forms can be selected from the same tables as they arise in the implementation.

#### Accessing Registers `r8`-`r15`

Some of the instructions I've recorded the encodings for allow me to do things like copying values to 64-bit registers, but in order to use the new `r8`-`r15` registers with those instructions there's one small change that needs to happen.

The REX prefix contains extra bits that extend the different register fields in an instruction. For the `lea` example I'll use below, the destination register is encoded in the ModR/M byte's REG field, so it's the REX `R` bit that extends it. The REG field in the ModR/M byte is only made up of 3 bits, which means it has a maximum value of `7` (`0b111`). Values `0`-`7` select one of the first 8 registers, like `rax` or `rcx`, but the encoding can't go any higher than that by itself. However, in 64-bit mode the REX prefix's `R` bit is treated as the most significant bit of the REG bits in the ModR/M byte, so even though the ModR/M byte itself still only has 3 bits in the REG field I can treat it as if it were 4 bits, which gives me a maximum value of `15` (`0b1111`). That is enough to select any one of the 16 general-purpose registers available in 64-bit mode.

The REX prefix is described in detail in section 2.2.1 of the Intel Software Developer Manuals, but the following diagrams describe how the bits in the REX prefix byte extend information in the other bytes in an instruction:

{{<img src="images/rex-prefix-extension-bits-1-en.png" alt="REX Prefix Extension Bits from the Intel Software Developer's Manuals">}}
{{<img src="images/rex-prefix-extension-bits-2-en.png" alt="REX Prefix Extension Bits from the Intel Software Developer's Manuals" hide-anchor="true">}}

As you can see, the first 4 bits of the REX prefix are `0b0100`, as I saw earlier, and the `W` bit is set to `1` when you want to tell the CPU that the operand size should be treated as 64-bit wide, but there are 3 extra bits called the `R`, `X`, and `B` bits.

There are four different situations where the extension bits are used slightly differently, but the arrows show how the extension bits are distributed to different parts of an instruction in different cases to double the number of values that part of the instruction would otherwise be able to encode.

The `R` bit extends the ModR/M `REG` field. The `B` bit extends the ModR/M `R/M` field, the SIB `BASE` field, or a register encoded in the opcode itself, and the `X` bit extends the SIB `INDEX` field.

What this means is that if I take one of the instructions I already encoded that uses a REX prefix, like the `lea` instruction, then I would just need to alter the REX prefix to select the new registers.

For example, the following instruction encoding would load an effective address into the `rax` register using a RIP-relative displacement of `0x1072`:

```txt
48 8d 05 72 10 00 00
```

The `05` ModR/M byte is the one that selects the `rax` register for me and has the binary value `0b00000101`. In this case the REG field (bits 3-5 in the ModR/M byte) is all `0`, which you'll see selects the `rax` (`eax`) register if you look at the REG row in the ModR/M addressing table.

Looking at the REG row in the ModR/M  addressing table you can also see that each subsequent register selection just counts up by one each time. If the REG bits in the ModR/M byte being `0b000` select the first register (`rax`) then `0b001` selects the second register (`rcx`), and so on.

Once I reach `0b111` that's register index `7` (`rdi`) and there's nowhere else to go from there. So all I need to do is set the `R` bit in the REX prefix to `1` and imagine that it's the new most significant bit in the REG field of the ModR/M byte.

Setting the `R` bit in the REX prefix to `1` changes the usual value I've been using for those instructions from `48` to `4c`, because the binary changes from `0b01001000` to `0b01001100`.

With the `R` bit in the REX prefix set to `1` if I now set the REG bits in the ModR/M byte to `0b000` again I can imagine the actual value to be `0b1000`, which is `8`. This allows me to select the `r8` register, and like the first 8 registers the register selection just increases by one each time. So to select register `r9` I would set the REG bits to `0b001`, but with the `R` bit in the REX prefix set I can imagine it as `0b1001`, which is `9`.

So if this encoding of the `lea` instruction loads an effective address into `rax`...

```txt
48 8d 05 72 10 00 00
```

...then this encoding would load it into `r8` instead:

```txt
4c 8d 05 72 10 00 00
```

As you can see, the ModR/M byte is still `05`, but the REX prefix changed from `48` to `4c`.

## The Initial Bootstrap Compiler

Finally I can start writing the code for the initial compiler. The first thing I need to do is remove the code that I put into the `.text` section when preparing the file; the entire `.text` section should be filled with nothing but null bytes before I put any new code in there.

The plan here is to write a few small functions using the instruction encodings I've come up with and build a simple state machine that can take care of the few rules this initial compiler has.

### The Entry Point and the Main Prologue

First I'll need to figure out how much stack space to allocate. I'll allocate a fixed 32 bytes for shadow space so it's ready for use whenever I need to call a function, then I'll need to allocate three stack-argument slots; this is because `CreateFileA` takes seven arguments, and if the first four go into registers then the last three need stack slots. In addition to that I'll need 16 bytes that can be used to store two file handles, one for the file I'll be reading from and the other that I'll be writing to, plus space for the byte I'm currently working on. Any remaining bytes are padding needed to reach a suitably aligned frame size.

If I add all of that up it leaves me with 88 bytes of required stack space. There's also the matter of needing the stack pointer to be aligned on a 16-byte boundary, and while 88 isn't divisible by 16, if I consider the fact that the stack is unaligned on program entry that means allocating 88 bytes of space on the stack will actually bring it back into alignment again anyway, so I don't need to add any extra padding.

Remember that the stack grows down, so to increase stack space I actually need to subtract 88 bytes from the stack pointer. To do this I'll add the machine code equivalent of the following assembly to the start of the `.text` section:

```asm
; Prologue
;     [rsp+88] Return address
;     [rsp+80] Alignment padding
;     [rsp+72] Byte from file
;     [rsp+64] Return from CreateFileA (Write)
;     [rsp+56] Return from CreateFileA (Read)
;     [rsp+48] Arg 7
;     [rsp+40] Arg 6
;     [rsp+32] Arg 5
;     [rsp+ 0] Shadow space for saving args 1, 2, 3, and 4
sub    rsp, 88
```

That translates to the following machine code:

{{<hextable start="0x200">}}
48 83 ec 58
{{</hextable>}}

{{<note>}}
Since `rsp` is a non-volatile register it means I need to remember to restore it before returning from the current function. This will be as simple as adding 88 bytes to `rsp` again before calling `ret`.
{{</note>}}

### Creating and Opening Files for Writing and Reading

Now that I've allocated enough stack space and made sure the stack pointer is aligned on a 16-byte boundary I can work on getting two handles to the files I need to work with.

The first file, `"a.rei_0"`, is the source code file that I'll be reading byte-by-byte. The second file, `"a.exe"`, is the file I'll be writing the compiled program to.

In order to get both handles I'll make two calls to the same function, `CreateFileA`. This function can open existing files or create them if they don't exist, and once it's done so will return a handle to the file that can be used with other functions like `ReadFile` and `WriteFile`.

`CreateFileA` takes seven arguments, and is [defined on the MSDN site](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea) like so:

```c
HANDLE CreateFileA(
  LPCSTR                lpFileName,
  DWORD                 dwDesiredAccess,
  DWORD                 dwShareMode,
  LPSECURITY_ATTRIBUTES lpSecurityAttributes,
  DWORD                 dwCreationDisposition,
  DWORD                 dwFlagsAndAttributes,
  HANDLE                hTemplateFile
);
```

As described in the Microsoft x64 calling convention, the first four arguments will be placed in registers, and the final three will be written to stack slots.

In the code I'll just define all of the arguments in reverse order, so I'll start with `hTemplateFile` and move my way back to `lpFileName`.

I can't forget that the shadow space needs to take up 32 bytes and must be adjacent to the return address that's pushed onto the stack by the `call` instruction, so the first 32 bytes of the stack are essentially reserved and I need to skip them.

That means the first stack argument, which is the 5th argument in the list, needs to start at the effective address `[rsp+32]`. The second will be at the effective address `[rsp+40]`, and the third will be at `[rsp+48]`, because each argument needs 8 bytes of space.

Moving backwards through the documentation for the function, about `hTemplateFile` it says...

> This parameter can be NULL.
>
> When opening an existing file, CreateFile ignores this parameter.

...so I'll need to set this argument to `0`.

The `dwFlagsAndAttributes` section says...

> The file or device attributes and flags, FILE_ATTRIBUTE_NORMAL being the most common default value for files.

...so I'll set this argument to `FILE_ATTRIBUTE_NORMAL`, which is `128`.

The `dwCreationDisposition` argument tells the function what to do when the file doesn't already exist. For the `a.rei_0` source file I'll use `OPEN_EXISTING`, which is `3`, so `CreateFileA` returns `INVALID_HANDLE_VALUE` for a missing input instead of silently creating an empty source file. This prototype does not yet check that return value.

The `lpSecurityAttributes` and `dwShareMode` fields I'll just set to `0`, so I'll need to `xor` the `r8` and `r9` registers for these.

The second parameter, `dwDesiredAccess`, is basically how I want to use the file, so for this first file I'll set it to `GENERIC_READ`, which is `0x80000000`.

Finally, for the first parameter I need to pass an argument value which is a pointer to the start of a file name string. I already set up the file name string `"a.rei_0"` at offset `0x5f2` in the `.rdata` section of the executable, and when mapped into memory it will be at RVA `0x21f2`. For this I'll need to use the `lea` instruction to calculate an effective address relative to the value in `rip`, which will be pointing at the next instruction.

Unfortunately I don't know exactly what the displacement value to give to the `lea` instruction is yet, since I don't know what the value in `rip` will be until I've written some instructions. For now I'll just fill in the displacements with `0x1000` and come back to them later.

So, I'll need to translate the following assembly to machine code:

```asm
; Win32 CreateFileA call to open file for reading
mov    qword ptr [rsp+48], 0         ; NULL
mov    qword ptr [rsp+40], 128       ; FILE_ATTRIBUTE_NORMAL
mov    qword ptr [rsp+32], 3         ; OPEN_EXISTING
xor    r9, r9                        ; NULL
xor    r8, r8                        ; 0
mov    edx, 0x80000000               ; GENERIC_READ
lea    rcx, [rip+0x21f2-0x1031]      ; "a.rei_0" address in .rdata
call   qword ptr [rip+0x2038-0x1037] ; Call CreateFileA
mov    qword ptr [rsp+56], rax       ; Save returned handle
```

There are a few instructions here that I didn't find the encodings of before, so I'll look them up now; they are:

- `xor r8, r8`
- `xor r9, r9`
- `mov r32, imm32`
- `mov r/m64, imm32`
- `mov r/m64, r64`

The `xor` instructions are the easiest to encode since they're just `4d 31 c0` for the `r8` register and `4d 31 c9` for the `r9` register. I could use `r8d` and `r9d` to clear the full registers as well, but selecting either of them still requires a REX prefix, so the instructions would remain three bytes long.

Copying an immediate 32-bit wide value into a 32-bit register is a little different, since the opcode listed for it is `B8+ rd id`. The `r` in `rd` here means that the lower 3 bits of the opcode itself are used to select the destination register for the immediate value to be copied into. The `d` part of `rd` just means it's a 32-bit operation. Then the `id` part just means a 32-bit immediate value should come after the opcode.

The starting opcode for this type of `mov` is `b8`, or `0b10111000` in binary. As you can see the lower 3 bits are all zero, which would select the first register, which is `eax`. The `mov` instruction I want to encode is to copy a value into the `edx` register for one of the argument values in a call to `CreateFileA`, and since `edx` is the third register that means I need to add `2` to the opcode using the lower 3 bits; doing so gives me the final opcode which is `ba`. I then just follow the opcode with the immediate value I want to copy to the register.

{{<note>}}
I'm using a 32-bit register here (`edx`) rather than a 64-bit one (`rdx`) because in 64-bit mode the default operand size is 32 bits, and writing any 32-bit GPR automatically clears the upper 32 bits of its corresponding 64-bit register. Thus `mov edx, 0x11223344` leaves `rdx` equal to `0x0000000011223344`. Because I don't need a full 64-bit immediate here, the 32-bit form saves code space.

For example, to move the value `0x11223344` into `edx` the machine code is `ba 44 33 22 11`, which only takes up 5 bytes, but to do the same thing with `rdx` turns into `48 ba 44 33 22 11 00 00 00 00`, which in this case is just a waste of space taking up 10 bytes instead.
{{</note>}}

Next I need to be able to encode moving an immediate value into a 64-bit memory location, which I'll use for setting values on the stack for arguments, so it'll also need to encode a displacement relative to the value in `rsp`.

The opcode for `MOV r/m64, imm32` is `REX.W + C7 /0 id`, so it's just the usual 64-bit enabling REX prefix (`48`) followed by the opcode (`c7`) with the ModR/M byte restricted to the `/0` column in the ModR/M address table, and then finally followed by a 32-bit immediate value that is sign-extended and stored as a 64-bit value.

When it comes to the ModR/M byte, I want to be able to use a displacement from the `rsp` register, which means I'll need to select one of the encodings that allows the use of the SIB byte (rows with `[--][--]`), since that's where the `rsp` register is encoded. I know that every positive displacement I'll use is under 128, so it will fit in a signed 8-bit value. This means I need to use `44` as the ModR/M byte, which is the `[--][--]+disp8` row in the table. This is the same as the `lea` instruction I looked at earlier.

After the ModR/M byte should be a SIB byte where I want to encode the selection of the `rsp` register with no scaled index. As with the `lea` instruction I looked at earlier this means the SIB byte needs to have the value `24`, which is then followed by a single byte that holds the displacement value.

So, if I wanted to move the 32-bit value `0x11223344` into the memory location `[rsp+0x20]` (the first stack-based argument) then I would encode it as `48 c7 44 24 20 44 33 22 11`.

Finally, I need to be able to copy a 64-bit value from a register into a memory location relative to the value in `rsp`. I'll use this to copy the return value of functions like `CreateFileA` into the stack for later use.

Like the previous `mov` instruction I just looked at this also involves the REX prefix and using a value for the ModR/M byte that allows the SIB byte to come after it so I can select the `rsp` register to use as a base for the memory displacement value. Since I want to move return values I'll be moving data from `rax`, so the same as before the ModR/M byte will be `44` and the SIB byte will be `24` with a single displacement byte after it.

For example, storing the value in `rax` at `[rsp+0x38]` would be `48 89 44 24 38`.

So to recap the encodings are:

- `xor r8, r8` → `4d 31 c0`
- `xor r9, r9` → `4d 31 c9`
- `mov edx, imm32` → `ba 44 33 22 11`
- `mov r/m64, imm32` → `48 c7 44 24 <disp8> <imm32>` _(relative to `rsp`)_
- `mov r/m64, r64` → `48 89 44 24 <disp8>` _(from `rax` to relative to `rsp`)_

Now I know what all of the instruction encodings are supposed to be I can count their bytes to keep track of the `rip` value used by each RIP-relative instruction.

For example, the very first instruction is the `sub` one that allocates stack space and makes sure the stack pointer is aligned on a 16-byte boundary. That instruction takes up 4 bytes in total, so since the program starts at RVA `0x1000` I can imagine that the value in `rip` will be `0x1004`, which is where the next instruction would start.

Using this information I can calculate the displacements needed in RIP-relative addresses for the `lea` and `call` instructions in the assembly from earlier where I just left them as the place holder `0x1000` values.

Translating the assembly instructions for the `CreateFileA` call I showed earlier I get the following machine code:

{{<hextable start="0x200">}}
.. .. .. .. 48 c7 44 24 30 00 00 00 00 48 c7 44
24 28 80 00 00 00 48 c7 44 24 20 03 00 00 00 4d
31 c9 4d 31 c0 ba 00 00 00 80 48 8d 0d c1 11 00
00 <ff> 15 01 10 00 00 <48> 89 44 24 38
{{</hextable>}}

I've highlighted the two bytes that the value in the `rip` register would be pointing at when it executes the `lea` and `call` instructions.

The first highlighted byte is where the `rip` register will be pointing when it's executing the `lea` instruction, because it's the start of the `call` instruction which comes next.

The second highlighted byte is where the `rip` register will be pointing when it's executing the `call` instruction, because it's the start of the `mov` instruction that comes after it.

With this in mind you can see why I chose the displacements `0x11c1` and `0x1001` in the machine code above.

The first argument to `CreateFileA` is a pointer to the start of a file name string. I know that when the executable is mapped into memory the string for `"a.rei_0"` will start at RVA `0x21f2`. When the `.text` section is mapped into memory it will start at RVA `0x1000`, so the `rip` register will point to `0x1031` when it's executing the `lea` instruction. That means `[rip+0x11c1]` at that point in time is the same as `[0x1031 + 0x11c1]` which equals `0x21f2`.

The same applies to the RIP-relative address in the `call` instruction. At the start of this post I set up the IAT and found that the address for `CreateFileA` will be stored at RVA `0x2038` by Windows. When the `call` instruction is running `rip` will point at the RVA `0x1037`, which means if I add `0x1001` to it I'll get the RVA `0x2038`.

Now that I've shown how I know what the displacements should be I won't go over it again and assume you understand how I found the correct values.

Directly after that code I need to do the same thing again, but this time it's to get a file handle for writing. The main differences are that instead of `OPEN_EXISTING` I'll use `CREATE_ALWAYS`, which is `2`; instead of `GENERIC_READ` I'll use `GENERIC_WRITE`, which is `0x40000000`; I'll use the RIP-relative address for the `"a.exe"` string; and I'll store the file handle at address `[rsp+64]` on the stack, instead of `[rsp+56]`.

If I alter the assembly code from the first function call I get this:

```asm
; Win32 CreateFileA call to open file for writing
mov    qword ptr [rsp+48], 0         ; NULL
mov    qword ptr [rsp+40], 128       ; FILE_ATTRIBUTE_NORMAL
mov    qword ptr [rsp+32], 2         ; CREATE_ALWAYS
xor    r9, r9                        ; NULL
xor    r8, r8                        ; 0
mov    edx, 0x40000000               ; GENERIC_WRITE
lea    rcx, [rip+0x21fa-0x1069]      ; "a.exe" address in .rdata
call   qword ptr [rip+0x2038-0x106f] ; Call CreateFileA
mov    qword ptr [rsp+64], rax       ; Save returned handle
```

Which translates to the following machine code:

{{<hextable start="0x230">}}
.. .. .. .. .. .. .. .. .. .. .. .. 48 c7 44 24
30 00 00 00 00 48 c7 44 24 28 80 00 00 00 48 c7
44 24 20 02 00 00 00 4d 31 c9 4d 31 c0 ba 00 00
00 40 48 8d 0d 91 11 00 00 ff 15 c9 0f 00 00 48
89 44 24 40
{{</hextable>}}

{{<note>}}
To keep this bootstrap program small, the code assumes that `CreateFileA`, `ReadFile`, and `WriteFile` succeed. It also relies on process termination to close both file handles.
{{</note>}}

### Processing the Source

Now that I've shown how I'm hand-encoding the machine code I'll stick to describing the rest of the program in assembly, just because it's easier to show at this point. You can find the full hand-encoded machine code at the end of this post.

With both file handles open I can start processing the source file. The main loop only needs to read one byte at a time and decide what to do with it:

```asm
; main_process_next_byte:
mov    rcx, qword ptr [rsp+56] ; File handle to read
call   fn_read_byte

cmp    al, 0                   ; Check for the end of the file
je     main_epilogue
```

The input file handle is stored at `[rsp+56]`, so I copy it into `rcx` as the first argument and call `fn_read_byte`. That function returns the byte it read in `al`, or `0` if it reached the end of the file. This means an actual null byte in the source is also treated as the end. If it returns `0` then there is nothing left to compile and I can jump to the main epilogue.

The next thing I need to handle is a comment:

```asm
cmp    al, 0x3b              ; Compare to ';'
je     main_skip_comment
```

If the byte is a semicolon (`0x3b`) I repeatedly call `fn_read_byte` until I either reach the end of the file or find a line feed (`0x0a`). Once the line feed is found I jump back to the start of the main loop and continue with the next byte.

```asm
; main_skip_comment:
mov    rcx, qword ptr [rsp+56]
call   fn_read_byte
test   al, al
je     main_epilogue
cmp    al, 0x0a
je     main_process_next_byte
jmp    main_skip_comment
```

For anything that isn't part of a comment I only care about characters in the ranges `0`-`9` and `a`-`f`. I can filter everything else out with a few comparisons:

```asm
cmp    al, 0x30                    ; '0'
jl     main_process_next_byte
cmp    al, 0x66                    ; 'f'
jg     main_process_next_byte
cmp    al, 0x3a                    ; ':'
jl     main_convert_and_write      ; 0-9
cmp    al, 0x60                    ; '`'
jg     main_convert_and_write      ; a-f
jmp    main_process_next_byte
```

The first two comparisons discard anything outside the full range from `0` to `f`. The other two divide that range into the characters I want to keep and the punctuation between `9` and `a`, which I also discard.

Once I've found a valid hexadecimal character I exchange `eax` and `edx` to put the character into `edx`, put the input file handle back into `rcx`, and call `fn_convert_ascii_pair`. The previous value in `edx` is no longer needed:

```asm
; main_convert_and_write:
xchg   eax, edx
mov    rcx, qword ptr [rsp+56]
call   fn_convert_ascii_pair
```

The converted byte is returned in `al`. I copy it onto the stack, pass its address and the output file handle to `fn_write_byte`, and then jump back to the beginning of the loop to process the next pair.

```asm
mov    byte ptr [rsp+72], al

; main_write_byte:
lea    rdx, [rsp+72]
mov    rcx, qword ptr [rsp+64]
call   fn_write_byte
jmp    main_process_next_byte
```

### Converting ASCII Hexadecimal

Each byte in the output is represented by two ASCII characters in the source file. For example, the source characters `4b` need to become the single byte `0x4b`.

The conversion function allocates its stack space, clears the saved-byte and done-flag slots, then copies its first character argument from `edx` into `eax`:

```asm
; fn_convert_ascii_pair:
sub    rsp, 56
mov    qword ptr [rsp+32], 0
mov    qword ptr [rsp+40], 0
mov    eax, edx
```

It then handles one nibble at a time. ASCII digits start at `0x30`, so subtracting `0x30` converts `0`-`9` into the values `0x0`-`0x9`. Lower-case letters start at `0x61`, but `a` needs to become `0xa`, so I subtract `0x57` (`0x61 - 0x0a`) from characters in that range:

```asm
; convert_nibble_main:
cmp    al, 0x3a
jl     convert_nibble_digit
sub    al, 0x57                    ; Convert a-f
jmp    convert_nibble_next_byte

; convert_nibble_digit:
sub    al, 0x30                    ; Convert 0-9
```

For the first character in the pair I shift the converted value four bits to the left and save it on the stack. This turns the value into the high nibble of the final byte. I then read and convert the second character and combine its value with the saved high nibble using `or`:

```asm
; convert_nibble_next_byte:
cmp    qword ptr [rsp+40], 0
jne    convert_nibble_epilogue
shl    al, 4
mov    qword ptr [rsp+32], rax
call   fn_read_byte
not    qword ptr [rsp+40]
jmp    convert_nibble_main

; convert_nibble_epilogue:
or     al, byte ptr [rsp+32]
add    rsp, 56
ret
```

Using `4b` as an example, the `4` becomes `0x04` and is shifted to become `0x40`. The `b` becomes `0x0b`, and combining `0x40` and `0x0b` gives the final byte `0x4b`.

The small flag at `[rsp+40]` tells the function whether it's converting the first or second nibble. It starts at `0`, is inverted after reading the second character, and causes the function to return once both nibbles have been processed.

This initial compiler assumes valid input. In particular, hexadecimal characters need to appear in adjacent pairs, and comments or other ignored characters can only appear between complete pairs. The conversion function reads the second character directly rather than running it through the main filtering and comment logic.

### Reading and Writing Bytes

The last two functions are small wrappers around `ReadFile` and `WriteFile`.

`fn_read_byte` calls `ReadFile` with a buffer size of one and provides stack space for both the byte and the number of bytes read:

```asm
; fn_read_byte:
sub    rsp, 56
mov    qword ptr [rsp+32], 0
lea    r9, [rsp+48]                ; Number of bytes read
mov    r8, 1                       ; Read one byte
lea    rdx, [rsp+40]               ; Byte buffer
call   qword ptr [rip+0x2040-0x113e]

xor    eax, eax
cmp    byte ptr [rsp+48], 0
je     read_byte_epilogue
mov    al, byte ptr [rsp+40]

; read_byte_epilogue:
add    rsp, 56
ret
```

Before checking the result I clear `eax`, making `0` the default return value. If the number of bytes read is also `0` then the function has reached the end of the file and can return immediately. Otherwise it copies the byte from the stack into `al` and returns it to the caller.

`fn_write_byte` works in almost the same way. It receives the output file handle in `rcx` and the address of the converted byte in `rdx`, sets the number of bytes to write to one, and calls `WriteFile`:

```asm
; fn_write_byte:
sub    rsp, 56
mov    qword ptr [rsp+32], 0
lea    r9, [rsp+40]                ; Number of bytes written
mov    r8, 1                       ; Write one byte
call   qword ptr [rip+0x2048-0x116f]
add    rsp, 56
ret
```

Once the main loop reaches the end of the input file it clears `eax` to return an exit code of `0`, restores the 88 bytes allocated by its prologue, and returns:

```asm
; main_epilogue:
xor    eax, eax
add    rsp, 88
ret
```

### Padding the `.text` Section

The program code doesn't occupy the full 512 bytes reserved for the `.text` section. The remaining bytes up to the start of `.rdata` at file offset `0x400` just need to be filled with zeros:

{{<hextable start="0x370">}}
.. .. .. .. .. .. .. 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0x050+
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
{{</hextable>}}

## Final Compiler and Source

The complete `rei_0.exe` file is shown below, followed by the annotated `a.rei_0` source file that describes the same bytes using the language the compiler accepts.

{{<textdump title="Final rei_0.exe binary">}}
4D 5A 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00
50 45 00 00 64 86 02 00 00 00 00 00 00 00 00 00
00 00 00 00 F0 00 22 00 0B 02 00 00 00 02 00 00
00 02 00 00 00 00 00 00 00 10 00 00 00 10 00 00
00 00 00 40 01 00 00 00 00 10 00 00 00 02 00 00
06 00 01 00 00 00 00 00 06 00 00 00 00 00 00 00
00 30 00 00 00 02 00 00 00 00 00 00 03 00 60 81
00 00 10 00 00 00 00 00 00 10 00 00 00 00 00 00
00 00 10 00 00 00 00 00 00 10 00 00 00 00 00 00
00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
00 20 00 00 28 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 38 20 00 00 20 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 2E 74 65 78 74 00 00 00
00 02 00 00 00 10 00 00 00 02 00 00 00 02 00 00
00 00 00 00 00 00 00 00 00 00 00 00 20 00 00 60
2E 72 64 61 74 61 00 00 00 02 00 00 00 20 00 00
00 02 00 00 00 04 00 00 00 00 00 00 00 00 00 00
00 00 00 00 40 00 00 40 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
48 83 EC 58 48 C7 44 24 30 00 00 00 00 48 C7 44
24 28 80 00 00 00 48 C7 44 24 20 03 00 00 00 4D
31 C9 4D 31 C0 BA 00 00 00 80 48 8D 0D C1 11 00
00 FF 15 01 10 00 00 48 89 44 24 38 48 C7 44 24
30 00 00 00 00 48 C7 44 24 28 80 00 00 00 48 C7
44 24 20 02 00 00 00 4D 31 C9 4D 31 C0 BA 00 00
00 40 48 8D 0D 91 11 00 00 FF 15 C9 0F 00 00 48
89 44 24 40 48 8B 4C 24 38 E8 9C 00 00 00 3C 00
74 4A 3C 3B 74 12 3C 30 7C EA 3C 66 7F E6 3C 3A
7C 1A 3C 60 7F 16 EB DC 48 8B 4C 24 38 E8 78 00
00 00 84 C0 74 26 3C 0A 74 CA EB EC 92 48 8B 4C
24 38 E8 1C 00 00 00 88 44 24 48 48 8D 54 24 48
48 8B 4C 24 40 E8 86 00 00 00 EB A8 31 C0 48 83
C4 58 C3 48 83 EC 38 48 C7 44 24 20 00 00 00 00
48 C7 44 24 28 00 00 00 00 89 D0 3C 3A 7C 04 2C
57 EB 02 2C 30 48 83 7C 24 28 00 75 14 C0 E0 04
48 89 44 24 20 E8 10 00 00 00 48 F7 54 24 28 EB
DA 0A 44 24 20 48 83 C4 38 C3 48 83 EC 38 48 C7
44 24 20 00 00 00 00 4C 8D 4C 24 30 49 C7 C0 01
00 00 00 48 8D 54 24 28 FF 15 02 0F 00 00 31 C0
80 7C 24 30 00 74 04 8A 44 24 28 48 83 C4 38 C3
48 83 EC 38 48 C7 44 24 20 00 00 00 00 4C 8D 4C
24 28 49 C7 C0 01 00 00 00 FF 15 D9 0E 00 00 48
83 C4 38 C3 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
58 20 00 00 00 00 00 00 00 00 00 00 28 20 00 00
38 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 6B 65 72 6E 65 6C 33 32
2E 64 6C 6C 00 00 00 00 78 20 00 00 00 00 00 00
86 20 00 00 00 00 00 00 92 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 78 20 00 00 00 00 00 00
86 20 00 00 00 00 00 00 92 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 43 72 65 61 74 65
46 69 6C 65 41 00 00 00 52 65 61 64 46 69 6C 65
00 00 00 00 57 72 69 74 65 46 69 6C 65 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 61 2E 72 65 69 5F 30 00 61 2E 65 78 65 00
{{</textdump>}}

{{<textdump title="Final a.rei_0 source file">}}
; (Offset 0x0000) MS-DOS Stub
	4d 5a 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00

; (Offset 0x003c) PE Signature Offset
	40 00 00 00

; (Offset 0x0040) PE signature
	50 45 00 00

; (Offset 0x0044) COFF File Header
	64 86       ; Machine
	02 00       ; NumberOfSections
	00 00 00 00 ; TimeDateStamp
	00 00 00 00 ; PointerToSymbolTable
	00 00 00 00 ; NumberOfSymbols
	f0 00       ; SizeOfOptionalHeader
	22 00       ; Characteristics

; (Offset 0x0058) Optional Header

; (Offset 0x0058) Optional Header: Standard Fields
	0b 02       ; Magic
	00          ; MajorLinkerVersion
	00          ; MinorLinkerVersion
	00 02 00 00 ; SizeOfCode
	00 02 00 00 ; SizeOfInitializedData
	00 00 00 00 ; SizeOfUninitializedData
	00 10 00 00 ; AddressOfEntryPoint
	00 10 00 00 ; BaseOfCode

; (Offset 0x0070) Optional Header: Windows-Specific Fields
	00 00 00 40 01 00 00 00 ; ImageBase
	00 10 00 00             ; SectionAlignment
	00 02 00 00             ; FileAlignment
	06 00                   ; MajorOperatingSystemVersion
	01 00                   ; MinorOperatingSystemVersion
	00 00                   ; MajorImageVersion
	00 00                   ; MinorImageVersion
	06 00                   ; MajorSubsystemVersion
	00 00                   ; MinorSubsystemVersion
	00 00 00 00             ; Win32VersionValue
	00 30 00 00             ; SizeOfImage
	00 02 00 00             ; SizeOfHeaders
	00 00 00 00             ; CheckSum
	03 00                   ; Subsystem
	60 81                   ; DllCharacteristics
	00 00 10 00 00 00 00 00 ; SizeOfStackReserve
	00 10 00 00 00 00 00 00 ; SizeOfStackCommit
	00 00 10 00 00 00 00 00 ; SizeOfHeapReserve
	00 10 00 00 00 00 00 00 ; SizeOfHeapCommit
	00 00 00 00             ; LoaderFlags
	10 00 00 00             ; NumberOfRvaAndSizes (number of data-directories)

; (Offset 0x00c8) Optional Header: Data Directories
	; Export Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Import Table (Import Directory Table)
	00 20 00 00 ; RVA
	28 00 00 00 ; Size

	; Resource Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Exception Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Certificate Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Base Relocation Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Debug
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Architecture (Reserved, must be 0)
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Global Ptr
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; TLS Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Load Config Table
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Bound Import
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; IAT
	38 20 00 00 ; RVA
	20 00 00 00 ; Size

	; Delay Import Descriptor
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; CLR Runtime Header
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

	; Reserved, must be zero
	00 00 00 00 ; RVA
	00 00 00 00 ; Size

; (Offset 0x0148) Section Table (Section Headers)
	; .text
	2e 74 65 78 74 00 00 00 ; Name
	00 02 00 00             ; VirtualSize
	00 10 00 00             ; VirtualAddress
	00 02 00 00             ; SizeOfRawData
	00 02 00 00             ; PointerToRawData
	00 00 00 00             ; PointerToRelocations
	00 00 00 00             ; PointerToLinenumbers
	00 00                   ; NumberOfRelocations
	00 00                   ; NumberOfLinenumbers
	20 00 00 60             ; Characteristics

	; .rdata
	2e 72 64 61 74 61 00 00 ; Name
	00 02 00 00             ; VirtualSize
	00 20 00 00             ; VirtualAddress
	00 02 00 00             ; SizeOfRawData
	00 04 00 00             ; PointerToRawData
	00 00 00 00             ; PointerToRelocations
	00 00 00 00             ; PointerToLinenumbers
	00 00                   ; NumberOfRelocations
	00 00                   ; NumberOfLinenumbers
	40 00 00 40             ; Characteristics

; Padding until the .text section
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00

; (Offset 0x0200) .text section

; fn_main:
	; Prologue
	;     [rsp+88] Return address
	;     [rsp+80] Alignment padding
	;     [rsp+72] Byte from file
	;     [rsp+64] Return from CreateFileA (Write)
	;     [rsp+56] Return from CreateFileA (Read)
	;     [rsp+48] Arg 7
	;     [rsp+40] Arg 6
	;     [rsp+32] Arg 5
	;     [rsp+ 0] Shadow space for saving args 1, 2, 3, and 4
	48 83 ec 58                   ; sub    rsp, 88

	; Win32 CreateFileA call to open file for reading
	48 c7 44 24 30 00 00 00 00    ; mov    qword ptr [rsp+48], 0         ; NULL
	48 c7 44 24 28 80 00 00 00    ; mov    qword ptr [rsp+40], 128       ; FILE_ATTRIBUTE_NORMAL
	48 c7 44 24 20 03 00 00 00    ; mov    qword ptr [rsp+32], 3         ; OPEN_EXISTING
	4d 31 c9                      ; xor    r9, r9                        ; NULL
	4d 31 c0                      ; xor    r8, r8                        ; 0
	ba 00 00 00 80                ; mov    edx, 0x80000000               ; GENERIC_READ
	48 8d 0d c1 11 00 00          ; lea    rcx, [rip+0x21f2-0x1031]      ; "a.rei_0" address in .rdata
	ff 15 01 10 00 00             ; call   qword ptr [rip+0x2038-0x1037] ; Call CreateFileA
	48 89 44 24 38                ; mov    qword ptr [rsp+56], rax       ; Save returned handle

	; Win32 CreateFileA call to open file for writing
	48 c7 44 24 30 00 00 00 00    ; mov    qword ptr [rsp+48], 0         ; NULL
	48 c7 44 24 28 80 00 00 00    ; mov    qword ptr [rsp+40], 128       ; FILE_ATTRIBUTE_NORMAL
	48 c7 44 24 20 02 00 00 00    ; mov    qword ptr [rsp+32], 2         ; CREATE_ALWAYS
	4d 31 c9                      ; xor    r9, r9                        ; NULL
	4d 31 c0                      ; xor    r8, r8                        ; 0
	ba 00 00 00 40                ; mov    edx, 0x40000000               ; GENERIC_WRITE
	48 8d 0d 91 11 00 00          ; lea    rcx, [rip+0x21fa-0x1069]      ; "a.exe" address in .rdata
	ff 15 c9 0f 00 00             ; call   qword ptr [rip+0x2038-0x106f] ; Call CreateFileA
	48 89 44 24 40                ; mov    qword ptr [rsp+64], rax       ; Save returned handle

	; main_process_next_byte:
	48 8b 4c 24 38                ; mov    rcx, qword ptr [rsp+56]       ; File handle to read
	e8 9c 00 00 00                ; call   fn_read_byte

	3c 00                         ; cmp    al, 0x0                       ; Compare return to `0`
	74 4a                         ; je     main_epilogue                 ; If `0` quit program

	; Check for comment
	3c 3b                         ; cmp    al, 0x3b                      ; Compare return to ';' char
	74 12                         ; je     main_skip_comment             ; If ';' skip comment

	; Check for character in 0-9 or a-f range
	3c 30                         ; cmp    al, 0x30                      ; Compare return to '0' char
	7c ea                         ; jl     main_process_next_byte        ; Skip if not in range
	3c 66                         ; cmp    al, 0x66                      ; Compare return to 'f' char
	7f e6                         ; jg     main_process_next_byte        ; Skip if not in range
	3c 3a                         ; cmp    al, 0x3a                      ; Compare return to ':' char
	7c 1a                         ; jl     main_convert_and_write        ; Convert if in range
	3c 60                         ; cmp    al, 0x60                      ; Compare return to '`' char
	7f 16                         ; jg     main_convert_and_write        ; Convert if in range

	; Default case
	eb dc                         ; jmp    main_process_next_byte        ; Start again

	; main_skip_comment:
	48 8b 4c 24 38                ; mov    rcx, qword ptr [rsp+56]       ; File handle to read
	e8 78 00 00 00                ; call   fn_read_byte
	84 c0                         ; test   al, al                        ; Check for end of file
	74 26                         ; je     main_epilogue                 ; Finish if at end of file
	3c 0a                         ; cmp    al, 0xa                       ; Compare return to '\n'
	74 ca                         ; je     main_process_next_byte        ; If '\n' start again
	eb ec                         ; jmp    main_skip_comment             ; Otherwise skip comment

	; main_convert_and_write:
	92                            ; xchg   eax, edx                      ; Put last read byte in edx
	48 8b 4c 24 38                ; mov    rcx, qword ptr [rsp+56]       ; File handle to read
	e8 1c 00 00 00                ; call   fn_convert_ascii_pair
	88 44 24 48                   ; mov    byte ptr [rsp+72], al         ; Copy converted byte to stack

	; main_write_byte:
	48 8d 54 24 48                ; lea    rdx, [rsp+72]                 ; Address of byte to write
	48 8b 4c 24 40                ; mov    rcx, qword ptr [rsp+64]       ; File handle to write
	e8 86 00 00 00                ; call   fn_write_byte
	eb a8                         ; jmp    main_process_next_byte        ; Start again after writing

	; Epilogue
	; main_epilogue:
	31 c0                         ; xor    eax, eax                      ; Set return to `0`
	48 83 c4 58                   ; add    rsp, 88                       ; Restore the stack pointer
	c3                            ; ret                                  ; Return

; fn_convert_ascii_pair:
	; Parameters
	;     rcx: file handle to read from
	;     rdx: byte that will become the high nibble
	; Return
	;     The converted byte from the ASCII character pair
	; Prologue
	;     [rsp+56] Return address
	;     [rsp+48] Alignment
	;     [rsp+40] Done flag
	;     [rsp+32] Byte
	;     [rsp+ 0] Shadow space for saving args 1, 2, 3, and 4
	48 83 ec 38                   ; sub    rsp, 56
	48 c7 44 24 20 00 00 00 00    ; mov    qword ptr [rsp+32], 0
	48 c7 44 24 28 00 00 00 00    ; mov    qword ptr [rsp+40], 0
	89 d0                         ; mov    eax, edx

	; convert_nibble_main:
	3c 3a                         ; cmp    al, 0x3a                      ; Compare to ':' char
	7c 04                         ; jl     convert_nibble_digit          ; Convert digit
	2c 57                         ; sub    al, 0x61-0xa                  ; Subtract ASCII 'a'-10 to convert
	eb 02                         ; jmp    convert_nibble_next_byte

	; convert_nibble_digit:
	2c 30                         ; sub    al, 0x30                      ; Subtract ASCII '0' to convert

	; convert_nibble_next_byte:
	48 83 7c 24 28 00             ; cmp    qword ptr [rsp+40], 0         ; Compare flag to 0
	75 14                         ; jne    convert_nibble_epilogue       ; return if done
	c0 e0 04                      ; shl    al, 4                         ; Make high nibble
	48 89 44 24 20                ; mov    qword ptr [rsp+32], rax       ; Save high nibble
	e8 10 00 00 00                ; call   fn_read_byte                  ; Get the next byte in the pair
	48 f7 54 24 28                ; not    qword ptr [rsp+40]            ; Flip done flag
	eb da                         ; jmp    convert_nibble_main           ; Convert new nibble

	; convert_nibble_epilogue:
	0a 44 24 20                   ; or     al, byte ptr [rsp+32]         ; Combine high nibble in return
	48 83 c4 38                   ; add    rsp, 56                       ; Restore the stack pointer
	c3                            ; ret                                  ; Return

; fn_read_byte:
	; Parameters
	;     rcx: file handle to read from
	; Return
	;     0:        finished reading
	;     non-zero: the data that was read
	; Prologue
	;     [rsp+56] Return address
	;     [rsp+48] Number of bytes read
	;     [rsp+40] Byte from file
	;     [rsp+32] Arg 5
	;     [rsp+ 0] Shadow space for saving args 1, 2, 3, and 4
	48 83 ec 38                          ; sub    rsp, 56

	; Win32 ReadFile call to read a single byte
	48 c7 44 24 20 00 00 00 00    ; mov    qword ptr [rsp+32], 0         ; NULL
	4c 8d 4c 24 30                ; lea    r9, [rsp+48]                  ; Num bytes read address
	49 c7 c0 01 00 00 00          ; mov    r8, 1                         ; Num bytes to read (1)
	48 8d 54 24 28                ; lea    rdx, [rsp+40]                 ; Byte from file address
	                                                                     ; File handle (rcx already set)
	ff 15 02 0f 00 00             ; call   qword ptr [rip+0x2040-0x113e] ; Call ReadFile

	31 c0                         ; xor    eax, eax                      ; Default return to 0
	80 7c 24 30 00                ; cmp    byte ptr [rsp+48], 0          ; Compare bytes read to 0
	74 04                         ; je     read_byte_epilogue            ; If no bytes were read

	; If data was read, copy exactly one byte into the zeroed return register
	8a 44 24 28                   ; mov    al, byte ptr [rsp+40]         ; Set return to the byte read

	; Epilogue
	; read_byte_epilogue:
	48 83 c4 38                   ; add    rsp, 56                       ; Restore the stack pointer
	c3                            ; ret                                  ; Return

; fn_write_byte:
	; Parameters
	;     rcx: file handle to write to
	;     rdx: address of the byte to write
	; Prologue
	;     [rsp+56] Return address
	;     [rsp+48] Alignment padding
	;     [rsp+40] Number of bytes written
	;     [rsp+32] Arg 5
	;     [rsp+ 0] Shadow space for saving args 1, 2, 3, and 4
	48 83 ec 38                   ; sub    rsp, 56

	; Win32 WriteFile call to write a single byte
	48 c7 44 24 20 00 00 00 00    ; mov    qword ptr [rsp+32], 0         ; NULL
	4c 8d 4c 24 28                ; lea    r9, [rsp+40]                  ; Num bytes written address
	49 c7 c0 01 00 00 00          ; mov    r8, 1                         ; Num bytes to write (1)
	                                                                     ; Byte address (rdx already set)
	                                                                     ; File handle (rcx already set)
	ff 15 d9 0e 00 00             ; call   qword ptr [rip+0x2048-0x116f] ; Call WriteFile

	; Epilogue
	48 83 c4 38                   ; add    rsp, 56                       ; Restore the stack pointer
	c3                            ; ret                                  ; Return

; (Offset 0x0400) .rdata
	; Padding until the .rdata section
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00

; (Offset 0x0400) Import Directory Table
	; kernel32.dll
	58 20 00 00 ; Import Lookup Table RVA (Characteristics)
	00 00 00 00 ; Time/Date Stamp
	00 00 00 00 ; Forwarder Chain
	28 20 00 00 ; Name RVA
	38 20 00 00 ; Import Address Table RVA (IAT / Thunk Table)

	; Empty entry to signal the end of the table
	00 00 00 00
	00 00 00 00
	00 00 00 00
	00 00 00 00
	00 00 00 00

; (Offset 0x0428) "kernel32.dll" string (with extra alignment bytes)
; Used in the Import Directory Table in the Name RVA field
; +-------------------------------------------------------------+
; | NOTE:                                                       |
; | If the RVA of this string changes then the RVA in the       |
; | "Import Directory Table" also needs to change               |
; +-------------------------------------------------------------+
	6b 65 72 6e 65 6c 33 32 2e 64 6c 6c 00 00 00 00

; (Offset 0x0438) Import Address Table (IAT)
; These are RVAs of strings in the Hint/Name Table
; This table is the same as the Import Lookup Table
; +-------------------------------------------------------------+
; | NOTE:                                                       |
; | If the size of this table changes then the size             |
; | in "Optional Header: Data Directories" also needs to change |
; | If the RVA of this table changes then the RVA in the        |
; | "Import Directory Table" also needs to change               |
; +-------------------------------------------------------------+
	78 20 00 00 00 00 00 00 ; CreateFileA (Offset 0x438; RVA 0x2038)
	86 20 00 00 00 00 00 00 ; ReadFile    (Offset 0x438; RVA 0x2040)
	92 20 00 00 00 00 00 00 ; WriteFile   (Offset 0x438; RVA 0x2048)
	00 00 00 00 00 00 00 00 ; Null entry to signal the end of the table

; (Offset 0x0458) Import Lookup Table
; These are RVAs of strings in the Hint/Name Table
; This table is the same as the IAT
; +-------------------------------------------------------------+
; | NOTE:                                                       |
; | If the RVA of this table changes then the RVA in the        |
; | "Import Directory Table" also needs to change               |
; +-------------------------------------------------------------+
	78 20 00 00 00 00 00 00
	86 20 00 00 00 00 00 00
	92 20 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 ; Null entry to signal the end of the table

; (Offset 0x0478) Hint/Name Table
; A padding null byte is required at the end of strings in addition
; to the null terminator to make them end on an odd boundary
;    0  1  2  3  4  5  6  7  8  9 10 11 12 13
	00 00 43 72 65 61 74 65 46 69 6c 65 41 00 ; CreateFileA (Offset 0x0478; RVA 0x2078)
	00 00 52 65 61 64 46 69 6c 65 00 00       ; ReadFile    (Offset 0x0486; RVA 0x2086)
	00 00 57 72 69 74 65 46 69 6c 65 00       ; WriteFile   (Offset 0x0492; RVA 0x2092)

; Padding until the end of the section
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	00 00 00 00

; (Offset 0x05f2) String data
	61 2e 72 65 69 5f 30 00 ; "a.rei_0"

; (Offset 0x05fa) String data
	61 2e 65 78 65 00       ; "a.exe"
{{</textdump>}}

## Finishing Up

At this point the initial bootstrap compiler has everything it needs. It opens `a.rei_0`, reads and converts its hexadecimal byte pairs, ignores comments and other characters between them, and writes the resulting bytes to `a.exe`. That `a.exe` can then be used to compile the same source into an identical `a.exe` again.

The language is deliberately tiny and the compiler assumes its input is valid, but that's enough for this stage. The source file can contain the complete executable while still leaving room for comments that describe its headers, data, functions, and individual instructions.

The main goal here was to end with a small compiler whose source can be written and maintained as normal text, meaning I no longer need to make every change directly in a hex editor, and I think I've achieved that.
