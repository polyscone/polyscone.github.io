+++
title = "Preparing an Executable"
description = "I write an executable file by hand that imports a Win32 API function to call. This provides me with a simple template that I can use to start writing the initial bootstrap compiler."
date = 2026-07-29
draft = false
tags = ["Compiler", "x86_64", "PE32+", "Windows"]
+++

## Introduction

I wanted document the process of bootstrapping a simple compiler directly from x86-64 machine code, so that's what I'm going to do in these posts.

The plan is to implement the initial, very simple compiler using machine code, which I'll then use to implement the next compiler, and so on and so forth (a.k.a. ["bootstrapping"](https://en.wikipedia.org/wiki/Bootstrapping_(compilers))).

I need some way to create binary files, so I'll be using the [HxD hex editor](https://mh-nexus.de/en/hxd/) to complete this initial stage of the project.

## The Rei Language

I'm calling the small language used for this bootstrap stage "Rei", if only to have a way to refer to it when needed. It will only support the following in its initial form:

- The lower-case ASCII characters `0123456789abcdef`, which will be converted into their actual hexadecimal values in byte-sized chunks.
- Comments starting with `;` that continue until the end of the line.

When I say that ASCII characters will be converted in "byte-sized chunks" I mean that, for example, the ASCII string `"4b"`, which occupies 2 bytes in a text file, will be converted to the actual binary value `0x4b`, which would occupy 1 byte in an executable file.

Comments will of course be completely discarded, and outside of comments any characters _not_ in the set `0123456789abcdef` will be ignored between complete byte pairs. To keep the initial compiler simple, the two hexadecimal characters that make up each byte will need to be adjacent to each other.

The main requirement for the initial bootstrap compiler is to allow me to write subsequent compilers using ASCII characters rather than having to actually look at the raw bytes through HxD. This way I can use a normal text editor, like Notepad or Sublime Text, throughout the rest of the project.

Implementing these two features should allow me to "rewrite" the initial compiler quite easily in a normal text editor, which means I'll be able to drop HxD. It also means I'll be able to annotate sections of machine code with comments to keep track of what's going on, which should make it easier to implement the next iteration of the compiler.

## Writing a Windows Executable

In order to execute any machine code in Windows I need to write an executable file, also known as an "image". An executable is essentially a container for a program's code, and houses additional information that tells Windows how to load it into memory and run it.

Windows expects any file you want it to execute to contain certain information at specific locations in the file, which means I have to write the file data in a certain format. The executable format used in Windows is called "PE32", for _32-bit_ programs, and "PE32+", for _64-bit_ programs, so I'll be writing the file according to the PE32+ specification since I want a 64-bit executable.

{{<note>}}
PE stands for "Portable Executable". The format supports multiple architectures, but each individual image still declares a specific target architecture in its COFF `Machine` field.
{{</note>}}

[The specification for these formats can be found on MSDN](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format). The MSDN page actually covers both the 32-bit (PE32) and 64-bit (PE32+) versions of the format because the differences between the two are minimal. In my case the differences will mostly come down to using eight bytes instead of four bytes for some of the fields I need to define due to differences in pointer sizes between 32-bit and 64-bit.

Since I'll be writing the executable by hand I'll stick as much as possible to writing only what's necessary. Having said that, it'd be nice for the program to do something other than just immediately running a return instruction or doing basic arithmetic.

In order for any program to be of any real use to me in the long run it'll need to be able to call functions in the [Win32 API](https://docs.microsoft.com/en-us/windows/win32/api/). These functions are provided in the form of ["Dynamic-Link Libraries" (DLLs)](https://en.wikipedia.org/wiki/Dynamic-link_library), and to use them you just need to import them into your program.

{{<note>}}
Interestingly enough, DLLs use the same PE32/PE32+ format as executable files. They're marked as DLLs and loaded into a process rather than being launched directly.
{{</note>}}

It's not possible to do things essential for a compiler, like reading and writing files, without using functions provided by the OS, so getting working imports set up right away seems like a worthwhile thing to do, even if it makes this initial step take longer. Part of writing an executable is actually telling Windows which functions from which DLLs you want it to patch into memory for you at load-time, hence the "dynamic-link" part of "DLL".

To keep things simple, I'll just import the [`GetProcessVersion`](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getprocessversion) function from `kernel32.dll`, which I'll then call, returning the function's return value from my own program so I can inspect it by `echo`ing the `%errorlevel%` variable in the Windows command line. The `%errorlevel%` variable contains the value returned from the last program that was run. If I can do this, then it means I can call any function from any DLL provided by the OS, which will give me all I need to build a working initial bootstrap compiler.

If I were to write the program I'm describing in C it would look something like this:

```c
#include <windows.h>

int main () {
	return GetProcessVersion(0);
}
```

Writing a functional executable that can do this should provide me with a useful template that I can alter to start implementing the initial bootstrap compiler.

To write the first executable I'll use the HxD hex editor and save all changes into a file called `rei_0.exe`. Once I see the executable is working I'll alter the contents of this file in the next post to implement the initial bootstrap compiler for the [simple language described earlier](#the-rei-language).

For now, I'll go through [the PE32+ specification](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format) and fill out all of the bytes that make up the format as required. I'll be going through the specification from top to bottom, since that's the order the bytes need to be written in anyway. Each section of the specification has a brief description and the number of bytes each field should be.

### PE32+ File Structure In Memory and On Disk

Before I start on the first part of the executable I thought it might be helpful to provide a visual of the structure of a PE32+ file and the basic mapping from the on-disk sections to in-memory sections that happens when you ask Windows to run a program.

When you write an executable it will of course be stored as a file, which is a collection of bytes on disk. When you ask Windows to run it, the loader maps the headers and loadable sections into the process's virtual address space. Some file data, such as an attribute certificate table, is deliberately not mapped.

A lot of the fields you need to define in the PE32+ format refer to either offsets in the file on disk, or offsets in memory after the contents of the file have been loaded into memory.

For example, you need to start by defining the header data in your executable. This starts at offset `0x00`, so the header data starts right at the beginning of the file.

Sections of data on disk can be no smaller than 512 bytes, so once you finish defining the header data you need to make sure the next section of the file starts at the next offset into the file that's a multiple of 512. If the header data were to finish at offset `0x1b0` then you would need to add as many null bytes as required to reach offset `0x200` (512) to start the next section.

Each section of the executable on disk is mapped into memory when you ask Windows to run your program, but in-memory sections will be no smaller than 4KiB, matching the normal x86-64 page size on Windows. In my case, in the beginning at least, this is much larger than the 512 byte sections I'll be writing on disk. Because of this there's a bit of a disconnect between the offsets on disk and in memory that can be a little difficult to think about at first when reading the specification.

The on-disk offsets will start at multiples of `0x200` (512) and the in-memory offsets will start at multiples of `0x1000` (4,096). This means that you might write a section at offset `0x200` on disk which is then mapped to offset `0x1000` in memory. The headers of the executable start at the very beginning of the file, or offset `0x00`, and will be mapped to the same offset (`0x00`) in memory.

{{<note>}}
The offset from the image base **when loaded into memory** is called the ["Relative Virtual Address" (RVA) in the specification](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#general-concepts), so that's what I'll call it from now on too.

It should also be noted that any time I talk about "memory", or "offsets", I'm actually referring to [**virtual** memory, or **virtual** memory offsets](https://en.wikipedia.org/wiki/Virtual_memory), and not physical memory. If the distinction between virtual and physical ever becomes important then I'll be more explicit about which one I'm talking about.
{{</note>}}

{{<img src="images/pe-sections-en.png" alt="PE32+ on-disk to in-memory section mapping">}}

### The MS-DOS stub

At the start of every PE32+ file there's a small section called the [MS-DOS stub](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#ms-dos-stub-image-only), which was used during the transition from DOS to provide a small program that could print out a message, telling the user that the PE file they were trying to run isn't compatible with DOS mode. If you open up an existing executable on your system in HxD, or any other program that lets you see the bytes in the file, you're quite likely to see a message to the user in this section of the file.

The MSDN page says...

> The MS-DOS stub is a valid application that runs under MS-DOS.

...but of course, I'm not expecting this small program to ever actually run under DOS, so I won't make it do anything useful there and will just fill out the minimum fields that the Windows loader needs before moving onto the next part.

The same section of the documentation also says...

> At location 0x3c, the stub has the file offset to the PE signature.

...and then in the [signature section](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#signature-image-only) it says...

> After the MS-DOS stub, at the file offset specified at offset 0x3c, is a 4-byte signature that identifies the file as a PE format image file.

...so I can just place a 4-byte file offset starting at offset `0x3c` in the file to tell Windows where the PE signature begins and just fill out the bytes leading up to it with zeros. According to [the wiki on DOS MZ executable](https://en.wikipedia.org/wiki/DOS_MZ_executable) the first two bytes also need to be the ASCII characters `MZ`, so I'll have to fill those two bytes out with the correct values too.

If I start the file with the ASCII characters `MZ` and fill out my PE signature offset at offset `0x3c` I get the following:

{{<hextable>}}
<4d 5a> 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 <40 00 00 00>
{{</hextable>}}

The `4d 5a` at the beginning is the ASCII for `MZ` which make up the required MS-DOS signature.

At offset `0x3c` is the 4-byte offset that tells Windows where the PE signature starts in the file. Since I'm putting the PE signature directly after this MS-DOS stub the offset I want Windows to use is `0x40`, which comes 4 bytes after `0x3c`.

#### Endianness

You'll notice that the bytes for the PE signature offset have been entered as `40 00 00 00`, so now seems like a good time to look at [endianness](https://en.wikipedia.org/wiki/Endianness), which describes the order in which sequences of bytes should be interpreted.

The two common byte orders are "little-endian" and "big-endian".

Little-endian just means that the byte representing the smallest part of the value in a sequence of two or more bytes goes on the left, with each byte increasing in significance to the right.

Big-endian is the opposite, where the largest byte goes on the left and each byte decreases in significance to the right.

The smallest byte in a sequence is called the ["Least Significant Byte" (LSB)](https://en.wikipedia.org/wiki/Bit_numbering#Least_significant_byte), and the largest byte is called the ["Most Significant Byte" (MSB)](https://en.wikipedia.org/wiki/Bit_numbering#Most_significant_byte). Note that "LSB" and "MSB" can also stand for "Least Significant Bit" and "Most Significant Bit" respectively when talking about the bits a byte is made up of, and in cases where the meaning is ambiguous sometimes "LSBit"/"MSBit" and "LSByte"/"MSByte" are used as well.

PE files are assumed to have their byte sequences stored in little-endian order on disk, so when I write out a sequence of bytes in my executable I need to remember to start with the LSB on the left and move up to the MSB on the right.

Endianness changes how a multi-byte value is stored, not the value itself. The offset is still the integer `0x00000040`. Written as a 32-bit little-endian field, its four bytes are `40 00 00 00`; written in big-endian order, they would be `00 00 00 40`. The two hexadecimal digits within each byte stay in their normal order.

{{<note>}}
Changing the endianness of a byte sequence is as simple as reversing the order of the bytes, but you need to be careful not to change the order of the hex digits that make up a single byte whilst doing so.
{{</note>}}

Endianness only matters when you have a sequence of bytes that needs to be interpreted in a certain way. If you only need to read one byte, for example, then the order of the bytes around it makes no difference to the interpretation of that single byte. If however, you need to read four bytes that are to be interpreted as a 32-bit integer, then the order of the bytes in that four byte sequence is crucial, because if they're in the wrong order then the sequence will be interpreted as a completely different value than expected.

### PE Signature

Now that I have the MS-DOS stub in place I can add the PE signature. [According to the MSDN page](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#signature-image-only) the signature is the ASCII characters `PE` followed by two null bytes (null bytes are just bytes with a value of zero, or `0x00` in hex):

> After the MS-DOS stub, at the file offset specified at offset 0x3c, is a 4-byte signature that identifies the file as a PE format image file. This signature is "PE\0\0" (the letters "P" and "E" followed by two null bytes).

This signature needs to start at the offset defined at offset `0x3c`, which I set to be `0x40`, so I can put these bytes directly after the MS-DOS stub.

{{<hextable start="0x40">}}
50 45 00 00
{{</hextable>}}

### COFF File Header

["Common Object File Format" (COFF)](https://en.wikipedia.org/wiki/COFF) is an object-file format with roots in Unix. PE combines a DOS-compatible header and stub with a PE signature, a COFF-derived file header, an optional header, and sections.

The COFF file header comes straight after the PE signature and it's where I get to start defining some real information about the program.

This is also the first section of the specification that [provides me with a table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#coff-file-header-object-and-image) describing each field required, in order, along with how many bytes they should occupy and descriptions about what they're used for. In these tables the "offset" column is the offset from the start of that section of the file, not the offset from the beginning of the file.

The `Machine` field lets me specify the target CPU this executable is intended to be run on. You can see a list of valid values in the [table below the main COFF one](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#machine-types).

Since I'm writing a PE32+ file that's intended to be run on x86-64 CPUs I'll specify that the `Machine` is `IMAGE_FILE_MACHINE_AMD64`, which has the hex value `0x8664`. Remember though, that these bytes need to be in little-endian order, so the actual bytes I enter in the hex editor will be `64 86`. Since this is a common theme I won't mention it any more and just assume you know that all byte sequences I put into the executable are in little-endian order.

`NumberOfSections` defines the number of entries in the [section table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#section-table-section-headers) that follows the headers. Sections are parts of the executable that serve different purposes. One section might contain code and another read-only data, for example, and I get to define more information about them in the section table later on.

I'll use two sections: one for executable instructions and another for read-only data.

Like the `Machine` field this is also two bytes long, so I'll enter the value `02 00`, to specify that I'll be defining two sections in this executable.

`TimeDateStamp` conventionally records the low 32 bits of the number of seconds since the Unix epoch, but I'll leave it as `00 00 00 00`.

The description for the `PointerToSymbolTable` and `NumberOfSymbols` fields says that they...

> should be zero for an image because COFF debugging information is deprecated.

...so I'll leave these fields collectively as `00 00 00 00 00 00 00 00`.

`SizeOfOptionalHeader` is a little more tricky to figure out, but basically it's here to tell Windows how many bytes the optional header occupies, which comes directly after the COFF file header.

You can calculate the number of bytes needed for the optional header by looking at the [optional header tables](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-image-only) in the specification and summing up the number of bytes in each field. If you have Microsoft Visual C++ (MSVC) installed on your computer, then you can also find a header file called `winnt.h` which contains [the `IMAGE_OPTIONAL_HEADER64` struct](https://docs.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_optional_header64). This struct is the one I'll be filling out after I'm done with the COFF file header and it's the one I need to specify the size of.

The `IMAGE_OPTIONAL_HEADER64` struct takes up a total of 240 bytes, which is `0xf0` in hex, so I'll enter the value `f0 00` for this field.

Finally there's the `Characteristics` field, which describes to Windows some of the attributes of the executable and the program contained within.

You can find a [list of characteristics on the same MSDN page](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#characteristics), but I'll be using the bitwise OR of `IMAGE_FILE_EXECUTABLE_IMAGE` and `IMAGE_FILE_LARGE_ADDRESS_AWARE`.

The `IMAGE_FILE_EXECUTABLE_IMAGE` flag is needed because, as the name suggests, it's used for executables, and the `IMAGE_FILE_LARGE_ADDRESS_AWARE` flag just lets Windows know that the program will be okay with using memory addresses greater than 2GiB.

The value of `IMAGE_FILE_EXECUTABLE_IMAGE | IMAGE_FILE_LARGE_ADDRESS_AWARE` is `22 00`, so that's the value I need to enter for this field.

The final COFF file header, which comes directly after the PE signature, looks like this:

{{<hextable start="0x40">}}
.. .. .. .. 64 86 02 00 00 00 00 00 00 00 00 00
00 00 00 00 f0 00 22 00
{{</hextable>}}

### Optional Header

With the COFF file header out of the way I can now move onto [the optional header](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-image-only), which for image files like the one I'm writing, _isn't actually optional_. The name of this header is explained in the MSDN specification as follows:

> Every image file has an optional header that provides information to the loader. This header is optional in the sense that some files (specifically, object files) do not have it. For image files, this header is required.

The optional header is made up of three major parts. They are: standard fields, which is defined for all implementations of COFF; Windows-specific fields, which allows you to define Windows specific features, like the subsystem you want to use; and the data directories, which is how you tell Windows at which memory offsets it can find structures like the Import Directory Table.

#### Standard Fields

The first of the three major parts in the optional header is [the standard fields](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-standard-fields-image-only). It starts with a `Magic` field, which allows you to specify whether this is a PE32 or PE32+ file. For PE32+ files the magic number is listed as `0x20b`, so I'll enter it as `0b 02` in the executable.

Next come two bytes that make up the `MajorLinkerVersion` and `MinorLinkerVersion` fields. These allow you to define the version of the linker used to compile the executable, but since I'm doing this whole thing by hand I'll just leave these as `00 00`.

`SizeOfCode` takes the number of bytes that the code section, commonly called the `.text` section, takes up on disk. It's possible to have multiple sections with the same name, so if there are multiple `.text` sections then this should be the sum of the bytes those sections take up on disk. I don't even have a `.text` section yet, so how do I know what this field's value should be?

If I do some reading ahead in the [next major part](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-windows-specific-fields-image-only) of the optional header specification I'll see that there's a `FileAlignment` field. This field determines the alignment factor in bytes of each section in the executable on disk, and the minimum value is 512 bytes, as described in the table on the MSDN page:

> The alignment factor (in bytes) that is used to align the raw data of sections in the image file. The value should be a power of 2 between 512 and 64 K, inclusive. The default is 512.

In other words, I can assume my `.text` section's size, or the size of any other on-disk section for that matter, will be a multiple of 512 if I use the minimum value in the `FileAlignment` field. Since I don't plan to write a lot of code in the beginning, I can assume any instructions I write will be under 512 bytes in size, meaning I'll have to round up to the next multiple of `FileAlignment`. Because of this I'll set `SizeOfCode` to 512, or `00 02 00 00` in hex.

`SizeOfInitializedData` works in the same way as `SizeOfCode`, but this time it describes the sum of the sizes in bytes taken by initialised data sections. Whether a section contains initialised data or not is actually set as part of a `Characteristics` field when defining sections much later in the file, but I know that I'll only have one initialised data section, and because of `FileAlignment` I also know that it will also be 512 bytes in size at a minimum, so I'll set this to `00 02 00 00` as well.

The `SizeOfUninitializedData` field is more of the same, but this time it's the sum of the sizes in bytes taken by uninitialised (`.bss`) data sections. I don't have any uninitialised data at this time, so I'll leave this as `00 00 00 00`.

{{<note>}}
Uninitialised data doesn't actually take up any space in the executable on disk, so the `SizeOfUninitializedData` is actually the size of the sections that the Windows loader will commit space for in the virtual address space.

It's worth remembering that uninitialised (`.bss`) sections in memory are filled with zeros by the OS at load-time.

{{</note>}}

`AddressOfEntryPoint` allows you to tell Windows at which offset in memory relative to the image base it should start executing the code at. "Relative to the image base" just means "relative to whatever virtual memory address the start of the executable was loaded into by Windows". This is essentially how you tell Windows where the equivalent of a C `main` function is. The important thing to note here is that it's the entry point relative to the image base **when the executable is loaded into memory**.

This is important because the offsets you use in the executable _on disk_ will actually be different to the offsets you use _in memory_. I'll define the memory offsets for each section later on, but the general idea is that although I might put the `.text` section at offset `0x200` relative to the image base on disk, I might tell Windows to map that section to offset `0x1000` relative to the image base in memory.

For the `AddressOfEntryPoint` I'll use an RVA of `0x1000`, like I just gave in the previous example, so I'll set this to `00 10 00 00` and when it comes time to define the `.text` section later I'll make sure Windows knows to map it into memory starting at that RVA.

`BaseOfCode` is an RVA that tells Windows where the beginning-of-code section is. I'll only have one `.text` section, and I already know I'll ask Windows to map it to the RVA `0x1000`, so I'll set this to `00 10 00 00` as well. The fact that I'm also telling Windows that `0x1000` is the `AddressOfEntryPoint` is just coincidence, since these can be different.

In case you're wondering why I'm setting the RVA to `0x1000`, it's because the default [page size](https://en.wikipedia.org/wiki/Page_(computer_memory)) on Windows is 4KiB (`0x1000` in hex), and Windows can only apply memory protection settings in page-sized chunks. I want to set the start of each section to be a multiple of the page size, and `0x1000` is of course a multiple of `0x1000`.

{{<note>}}
The `.text` section is usually the first section you'll see in an executable, followed by other sections like the read-only data section, so it'll typically start at an RVA of `0x1000`.

Section data must appear in the same ascending order as the section RVAs, and the section RVAs themselves must be ascending and adjacent after alignment. The names are conventional, but the ordering and alignment constraints still apply.
{{</note>}}

The next field, `BaseOfData`, has actually been removed in PE32+ and is only required for the PE32 files, so I can skip it and don't actually need to write out any bytes at all in this case.

With that, the standard fields part of the optional header now looks like this:

{{<hextable start="0x50">}}
.. .. .. .. .. .. .. .. 0b 02 00 00 00 02 00 00
00 02 00 00 00 00 00 00 00 10 00 00 00 10 00 00
{{</hextable>}}

#### Windows-Specific Fields

The [Windows-specific fields](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-windows-specific-fields-image-only) are an extension of the COFF optional header format, and let you define things like which subsystem the program will use.

The first field, `ImageBase`, is the preferred address you'd like Windows to start mapping the executable into memory at, and must be a multiple of 64KiB. The table of fields on MSDN has some suggestions for the value, but I'll set this to `0x140000000`, or `00 00 00 40 01 00 00 00` in HxD, just because that's what I've seen in some other 64-bit executables on my machine. In reality this value doesn't really matter to me because I'll allow Windows to randomise the image base location at load-time anyway.

`SectionAlignment` is the alignment factor in bytes for sections when they're loaded into memory. The page size of the architecture is the default here, which I previously mentioned is 4KiB for most processor architectures, so I'll set this to `00 10 00 00`.

All this means is that when sections from the executable on disk are loaded into memory they should be loaded at addresses which are a multiple of this number. For example the `.text` section could be loaded at RVA `0x1000`, and the `.rdata` section could be loaded at RVA `0x2000`.

`FileAlignment` is exactly the same as `SectionAlignment`, but this time it's in relation to the bytes in the executable on disk. The smallest value for this is 512 bytes. This means that the `.text` section could be stored at offset `0x200`, and the `.rdata` section could be stored at offset `0x400`.

Since I want to use as little on-disk space as possible I'll just keep this as the minimum value and set it to `00 02 00 00`. This just means that if I don't completely fill a section on disk with data I won't have to pad it out with as many null bytes.

Hopefully you can see the relationship between `FileAlignment` and `SectionAlignment`. Basically the sections at their `FileAlignment` offsets on disk are loaded into memory at their `SectionAlignment` RVAs. I'll define the actual RVAs for each section later, but these two values determine the kind of numbers I need to use when I get to it.

`MajorOperatingSystemVersion` and `MinorOperatingSystemVersion` determine the required minimum OS version that the program should be run on. Although I'm using Windows 11 I'm going to just arbitrarily choose Windows 7 to be the required version. Behind the scenes Windows 7 is actually version _6.1_, so I'll set these fields to the value `06 00 01 00`.

`MajorImageVersion` and `MinorImageVersion` refer to the version of the executable itself; I'll leave this as `00 00 00 00`.

`MajorSubsystemVersion` and `MinorSubsystemVersion` determine the minimum subsystem version required to run the program. At the time of writing it looks like MSVC uses 6.0 for this by default, so that's what I'll use as well and set it to `06 00 00 00`.

The `Win32VersionValue` field is reserved and the MSDN page says that it must be left as zero, so I'll leave it as `00 00 00 00`.

`SizeOfImage` must be a multiple of `SectionAlignment`, which makes sense since it describes the size of the executable when it's been loaded into memory. I know that I'll have two sections, one at `0x1000` and one at `0x2000`, and since there's no way I'll take up more than 4KiB (`0x1000`) of memory in any single section, that means none of the sections will grow to be any larger than that and I can assume the image size must be 12KiB, or `0x3000` bytes. This is because if my last section starts at `0x2000` and takes up `0x1000` bytes of space then the end of the section must be at offset `0x3000` relative to the image base, so I'll set this field to the value `00 30 00 00`.

The `SizeOfHeaders` field is just the combined size in bytes of the MS-DOS stub, PE headers, and section headers, which is then rounded up to a multiple of `FileAlignment`, which in my case is 512 bytes. In other words, it describes the offset where the actual sections begin after all of the header data. I haven't actually gotten to the section headers yet, but I already know that my sections will start at offset `0x200` on disk, because they have to, since that's my `FileAlignment` value and I know that the rest of these headers won't take up any more than 512 bytes of space. Since the headers take up less than 512 bytes of space in total I can just round it up to 512 bytes and set this field to `00 02 00 00`.

I'm going to completely ignore the `CheckSum` and set it to all zeros, since the MSDN page says...

> The following are checked for validation at load time: all drivers, any DLL loaded at boot time, and any DLL that is loaded into a critical Windows process.

...and my executable doesn't fall into any of those categories, so I don't need to worry about it.

The next field, `Subsystem`, allows you to tell Windows which subsystem you want the program to run under. There is a [long list of subsystems](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#windows-subsystem) that you could choose from, but the two most important ones in my case are `IMAGE_SUBSYSTEM_WINDOWS_GUI` and `IMAGE_SUBSYSTEM_WINDOWS_CUI`, which specify running as a GUI program or a command line program respectively.

Since I'm writing a compiler I'll set this to the `IMAGE_SUBSYSTEM_WINDOWS_CUI` value for a command line program, which is `3`, or `03 00` in the executable.

Next up is the `DllCharacteristics` field, which is where you tell Windows all about what the executable can do. This is just going to be the bitwise OR of a few flags [from the DLL characteristics table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#dll-characteristics). The ones I'm interested in are:

- `IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA`
- `IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE`
- `IMAGE_DLLCHARACTERISTICS_NX_COMPAT`
- `IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE`

The `IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA` flag lets Windows know that it's okay to use high-entropy 64-bit ["Address Space Layout Randomisation" (ASLR)](https://en.wikipedia.org/wiki/Address_space_layout_randomization). ASLR is a security technique that helps to prevent the exploitation of memory vulnerabilities by randomly arranging the address space of a process, including the base of the image, which is why the `ImageBase` field I set earlier in the file didn't really matter to me.

In order to use `IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA`, however, you also need to specify that it's okay for the DLL to be relocated at load-time, which is why I also set the `IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE` flag. It also requires that the executable be "large address aware", which is one of the reasons I set the `IMAGE_FILE_LARGE_ADDRESS_AWARE` flag earlier.

The `IMAGE_DLLCHARACTERISTICS_NX_COMPAT` flag lets Windows know that the executable is compatible with ["Data Execution Prevention" (DEP)](https://docs.microsoft.com/en-us/windows/win32/memory/data-execution-prevention), which is a feature that allows Windows to mark pages of memory as non-executable, helping to protect against the exploitation of vulnerabilities like buffer overruns. This is also one of the reasons I wanted my `SectionAlignment` field earlier set to the page size; sections with different protection requirements can then start on separate pages.

The `IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE` flag indicates that Terminal Server does not need to modify the program.

If I take the bitwise OR of all of these values I get the hex value that I need to set for `DllCharacteristics`, which is `60 81`.

The next two fields I need to fill out are `SizeOfStackReserve` and `SizeOfStackCommit`, both of which are used to control the memory that will be reserved/committed for the initial thread's stack.

The difference between "reserving" and "committing" memory in Windows is summed up on [the MSDN "page state" page](https://docs.microsoft.com/en-us/windows/win32/memory/page-state).

In relation to "reserved" memory it says...

> The page has been reserved for future use. The range of addresses cannot be used by other allocation functions. The page is not accessible and has no physical storage associated with it. It is available to be committed.

...and in relation to "committed" memory it says...

> Memory charges have been allocated from the overall size of RAM and paging files on disk. The page is accessible and access is controlled by one of the memory protection constants. The system initializes and loads each committed page into physical memory only during the first attempt to read or write to that page. When the process terminates, the system releases the storage for committed pages.

What this means is that if you know a certain amount of virtual memory _might_ be needed, but you don't necessarily want to make it available for actual use just yet, then you would _reserve_ it. This allows you to make sure that a block of contiguous virtual memory addresses is reserved for future use and will be left untouched by other parts of the program that also want to reserve their own memory. This is important for certain things, like a stack, where you don't want the virtual memory that it uses to be fragmented. No physical memory is actually mapped to the reserved virtual memory addresses at this point.

When you think you actually want to use some of that reserved memory you would _commit_ it, which is the way you tell Windows that you would like to use some of the virtual memory from a block you reserved earlier. Again, at this point no physical memory will have been mapped to the committed virtual memory addresses; that only happens when the program actually tries to access the virtual memory in some way for the first time.

The crucial difference between _reserved_ and _committed_ virtual memory to take away from this, if nothing else, is that _reserved_ virtual memory can't actually be used, but _committed_ virtual memory can, and you can only _commit_ virtual memory from a _reserved_ block.

{{<note>}}
If you're using one of the Win32 API functions for allocating memory you can actually ask Windows to both reserve and commit memory at the same time if needed.
{{</note>}}

The normal stack size for a program in Windows is 1MiB, but that doesn't mean I actually think I'll use all of that space. For that reason I should ask Windows to _reserve_ 1MiB of virtual memory for my stack so that I can be guaranteed a contiguous block of virtual memory addresses to use.

Even though I don't want to actually use the full 1MiB of _reserved_ virtual memory right away, I will need access to at least some of it, so I'll ask Windows to _commit_ 4KiB, which will be mapped to physical memory as required on first access.

1MiB in hex is `0x100000`, so I'll set `SizeOfStackReserve` to `00 00 10 00 00 00 00 00`, and 4KiB in hex is `0x1000`, so I'll set `SizeOfStackCommit` to `00 10 00 00 00 00 00 00`.

{{<note>}}
When actually using the stack in the program you don't have to ask Windows to commit each page of memory as you use up more and more space; this will be done automatically for you as required, as explained on the ["Thread Stack Size" MSDN page](https://docs.microsoft.com/en-us/windows/win32/procthread/thread-stack-size):

> The system commits additional pages from the reserved stack memory as they are needed, until either the stack reaches the reserved size minus one page (which is used as a guard page to prevent stack overflow) or the system is so low on memory that the operation fails.

Having said that, if for some reason you need to use more than one page of stack space at once then you would need to [call the \_chkstk routine](https://docs.microsoft.com/en-us/windows/win32/devnotes/-win32-chkstk), or manually do the equivalent, to ensure that the correct number of pages are committed before using the stack. This is just because pages are committed automatically on access one after the other, so if you skip a page and try to use a second page of memory without them being committed in order the program would just crash.
{{</note>}}

The `SizeOfHeapReserve` and `SizeOfHeapCommit` fields work in much the same way as the stack fields do, except this time it's for the _initial process heap_, so I'll set them to the same values with `SizeOfHeapReserve` being `00 00 10 00 00 00 00 00` and `SizeOfHeapCommit` being `00 10 00 00 00 00 00 00`.

Next up is the `LoaderFlags` field, which is reserved and must be set to `00 00 00 00`, so I can move straight on to the final field.

The final field in the Windows-specific part is `NumberOfRvaAndSizes`. This tells Windows how many data directories are defined in the last part of the optional header. Reading ahead to [the data directories section on MSDN](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-data-directories-image-only), I can see that there are a total of 16 data directories, so I'll set this field to `10 00 00 00`.

The final Windows-specific fields part of the optional header now looks like this:

{{<hextable start="0x70">}}
00 00 00 40 01 00 00 00 00 10 00 00 00 02 00 00
06 00 01 00 00 00 00 00 06 00 00 00 00 00 00 00
00 30 00 00 00 02 00 00 00 00 00 00 03 00 60 81
00 00 10 00 00 00 00 00 00 10 00 00 00 00 00 00
00 00 10 00 00 00 00 00 00 10 00 00 00 00 00 00
00 00 00 00 10 00 00 00
{{</hextable>}}

#### Data Directories

[The data directories](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-data-directories-image-only) are the last part of the optional header, and are also the easiest to get through because they're just an array of [`IMAGE_DATA_DIRECTORY`](https://docs.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_data_directory) structs. There are 16 of them taking up eight bytes each, meaning I need to use up a total of 128 bytes to define all of them.

[The table on the MSDN page](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#optional-header-data-directories-image-only) describes each of the data directories, but I'm only interested in two of them at the moment. They are the "Import Table" and the "Import Address Table" (IAT). These directories tell Windows where it can find information about which functions I want to import from DLLs at load-time, which will allow me to use things like functions for reading/writing files from `kernel32.dll`, for example.

{{<note>}}
The "Import Table" data-directory name is slightly ambiguous; this entry actually describes the "Import Directory Table". Just keep this in mind because there are a few things that use the words "import" and "table" in their names and it's easy to get them mixed up...
{{</note>}}

Each directory has two fields, a `VirtualAddress` and a `Size`. The `VirtualAddress` is the RVA of the start of the table being described itself, and `Size` is just the size in bytes of the table that's being pointed to.

I'm going to put my Import Directory Table and IAT into the `.rdata` section, which I'll ask Windows to map into memory starting at an RVA of `0x2000`. Unfortunately all I know about the tables at this point is that they'll start somewhere in the `.rdata` section, so I'll have to remember to revisit this part of the optional header when I know the RVAs and sizes of the tables I create later on.

For now, I'll fill out every single directory with null bytes, but I'll set the Import Table and IAT data-directory `VirtualAddress` fields to `00 20 00 00`, because at the very least I know my `.rdata` section will be mapped to the RVA `0x2000`. The Import Table is the 2nd data directory, and the IAT is the 13th, so the bytes for my data directories at this moment in time look like this:

{{<hextable start="0xc0">}}
.. .. .. .. .. .. .. .. 00 00 00 00 00 00 00 00
<00 20 00 00 00 00 00 00> 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 <00 20 00 00 00 00 00 00>
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
{{</hextable>}}

{{<note>}}
I'll come back to the highlighted `VirtualAddress` and `Size` fields later on when I fill out the `.rdata` section, since that's when I'll know the exact values to fill out the fields with.
{{</note>}}

### Section Table

The [section table (section headers)](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#section-table-section-headers) is where I can finally tell Windows all about the sections I'd like to use. This is where you define things like the section offsets on disk and in memory, so hopefully this should bring everything I've been over so far together.

{{<note>}}
You can refer back to the simple diagram of the mapping from on-disk data to in-memory data that I provided [at the beginning of this post](#pe32%2b-on-disk-to-in-memory-section-mapping) if it helps.
{{</note>}}

There are a couple of important pieces of information to keep in mind that are mentioned on the MSDN page:

> The number of entries in the section table is given by the NumberOfSections field in the file header. Entries in the section table are numbered starting from one (1). The code and data memory section entries are in the order chosen by the linker.
>
> In an image file, the VAs for sections must be assigned by the linker so that they are in ascending order and adjacent, and they must be a multiple of the SectionAlignment value in the optional header.

The number of entries in the section table should match the number I set for the `NumberOfSections` field in the COFF file header in the beginning, which I set to `02 00` because I only plan on having `.text` and `.rdata` sections to begin with.

It also says that the VAs must be in ascending order and adjacent, so I'll define the `.text` section first, since I want that to be mapped to the RVA `0x1000`, and then `.rdata` second, since I want that to map to `0x2000`. This way the VAs are ascending, and the `.rdata` section comes directly after the `.text` section, making them adjacent.

I'll go through the definition of the `.text` section first and talk about each field, and then I'll briefly look at the values for the `.rdata` section after that.

The first field in a section table entry is the `Name`. This can be anything you like up to eight bytes in length and no more. If the name you choose is less than eight bytes you just pad it out with zeros.

Even though this name has no bearing on how Windows loads the executable there are some commonly used names, so I'll use those. I'm defining the `.text` section first, which is for storing code. Because of that I'll set this to the ASCII string `.text`, which in hex will be `2e 74 65 78 74 00 00 00` with some zeros on the end to pad it out to eight bytes.

Next is `VirtualSize`, which is the size of the section when loaded into memory. If I know how many bytes are occupied by the actual data in the section then I should enter the exact size here, but I'm going to set it to the same size at the section on disk so I don't have to re-count the bytes each time the section data changes. Once I have a more sophisticated compiler I can calculate the actual size, but for now I'll set this to `00 02 00 00`.

`VirtualAddress` is the RVA that I want the section to be loaded at. Throughout this post I've mentioned a few times that my `.text` section will start at an RVA of `0x1000`, and setting this field is how I tell Windows I want that to be the case, so I'll set this value to `00 10 00 00`.

{{<note>}}
I start my first section at `0x1000` because all of the header data from the beginning of the file will be mapped to the RVA `0x0000`, so the first available section RVA I can use after that is `0x1000`.
{{</note>}}

The `SizeOfRawData` field must be a multiple of `FileAlignment`, which I set to 512 bytes, and it describes the size of the section data on disk. Since the code I put into my `.text` section will actually take up less than 512 bytes I have to round it up, so I'll set it to `00 02 00 00`.

I've also been saying that my `.text` section will start at an offset of `0x200` on disk, and the `PointerToRawData` field is where I set that value, so I'll enter `00 02 00 00` here.

The `PointerToRelocations`, `PointerToLinenumbers`, `NumberOfRelocations`, and `NumberOfLinenumbers` fields are all ignored in my case, so I can just set them all to `00 00 00 00 00 00 00 00 00 00 00 00`.

Finally, the `Characteristics` field is where I tell Windows about what kind of section it is I'm describing. You can find the [table of characteristic flags on the MSDN page](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#section-flags), but for the `.text` section the three I'm interested in are `IMAGE_SCN_CNT_CODE`, `IMAGE_SCN_MEM_EXECUTE`, and `IMAGE_SCN_MEM_READ`.

`IMAGE_SCN_CNT_CODE` just lets Windows know that the section contains code, `IMAGE_SCN_MEM_EXECUTE` lets Windows know that this section can be executed, and `IMAGE_SCN_MEM_READ` lets Windows know this section is readable.

Even though I set the `IMAGE_SCN_CNT_CODE` flag, if I don't also make it executable with the `IMAGE_SCN_MEM_EXECUTE` flag then the DEP feature that I enabled earlier on with `IMAGE_DLLCHARACTERISTICS_NX_COMPAT` will kick in and the program will crash with a DEP violation when I try to run it.

All I need to do is set the `Characteristics` to the bitwise OR of these flags, which is `20 00 00 60`.

With the definition of the `.text` section out of the way I can now create the second entry in the section table to define the `.rdata` section.

This will be largely the same as the `.text` section with only the `Name`, `VirtualAddress`, `PointerToRawData`, and `Characteristics` fields changing, so I'll only cover those fields and the rest can be assumed to be the same as the `.text` section.

As you've probably already guessed, `.rdata` is the common name given to the read-only data section of the executable, so that's what I'll set the `Name` field to, which is `2e 72 64 61 74 61 00 00`.

The `.text` section has been set to start at a `VirtualAddress` of `0x1000`, and earlier in the file I set `SectionAlignment` to be `0x1000`, which means the next section can start from `0x2000`, so I'll set `VirtualAddress` to `00 20 00 00`.

On disk, the `.text` section has been set to start at offset `0x200` by the `PointerToRawData` value. Earlier I set `FileAlignment` to `0x200`, which means the next section on disk can start at `0x400`, so I'll set `PointerToRawData` to `00 04 00 00` here.

Finally, the `Characteristics` field for `.rdata` will use the bitwise OR of the `IMAGE_SCN_CNT_INITIALIZED_DATA`, and `IMAGE_SCN_MEM_READ` flags.

The `IMAGE_SCN_CNT_INITIALIZED_DATA` flag is how Windows knows that this section contains initialised data and it's why I set the `SizeOfInitializedData` field earlier in the file to be 512 bytes. The `IMAGE_SCN_MEM_READ` field tells Windows that the section is readable.

The bitwise OR of these flags is `40 00 00 40`.

{{<note>}}
If you see a DEP violation error when you run your program it's because you're trying to execute data in a section that hasn't been set as executable. This is a good sign that you need to check things like RVA values and characteristic flags.
{{</note>}}

The final section table looks like this:

{{<hextable start="0x140">}}
.. .. .. .. .. .. .. .. 2e 74 65 78 74 00 00 00
00 02 00 00 00 10 00 00 00 02 00 00 00 02 00 00
00 00 00 00 00 00 00 00 00 00 00 00 20 00 00 60
2e 72 64 61 74 61 00 00 00 02 00 00 00 20 00 00
00 02 00 00 00 04 00 00 00 00 00 00 00 00 00 00
00 00 00 00 40 00 00 40
{{</hextable>}}

After the section table I just need to add enough padding to reach offset `0x200` which is where the actual `.text` section content starts:

{{<hextable start="0x190">}}
.. .. .. .. .. .. .. .. 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
{{</hextable>}}

This only brings me up to the start of the `.text` section though, and I want to work on the `.rdata` section first, so I'll add another 512 null bytes to bring myself up to offset `0x400` instead:

{{<hextable start="0x200">}}
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0x1c0+
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
{{</hextable>}}

### The .rdata Section

The `.rdata` section is where I'll store all of my read-only initialised data. In other words, I'd store immutable data in this section that will be used by the program, like initialised strings. I'm going to store all of my import data in this section as well. The IAT is an exception because Windows needs to update it before the program starts, but after that the section can still be treated as read-only.

Even though the `.text` section comes first on disk and in memory, I'm defining everything in `.rdata` first because I'll need to reference certain RVAs from the `.text` section.

#### Load-Time Dynamic Linking

Import data asks Windows to resolve DLL functions and write their addresses into the program before execution begins. This is [load-time dynamic linking](https://docs.microsoft.com/en-us/windows/win32/dlls/load-time-dynamic-linking), in contrast to explicitly loading a library while the program is running. The executable only needs the load-time form.

#### Adding Import Data

The only thing I'll be putting into the `.rdata` section at the moment is my [import data](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#the-idata-section). Import data is used to tell Windows which functions you want it to patch in to your process and from which DLLs.

{{<note>}}
There is another section you can use for defining import data, typically called the `.idata` section, but that means setting up another section at another memory offset, and since it's technically just read-only data anyway I'm going to put everything in `.rdata` instead.

This is quite common and you'll see the `.idata` section merged into the `.rdata` section in many executables.
{{</note>}}

The way import data works is that you set up an [Import Directory Table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#import-directory-table), which is an array of Import Directory entries that describe to Windows each DLL you'd like to use and which functions to import from each of those DLLs. The array ends with another full Import Directory entry that's filled with zeros to indicate the end of the table.

Each Import Directory entry contains a few RVAs. One RVA points to the name of the DLL you'd like to use, another points to an [Import Lookup Table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#import-lookup-table), and the last one points to an [Import Address Table (IAT)](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#import-address-table).

The Import Lookup Table will basically just contain more RVAs that point into a [Hint/Name Table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#hintname-table), which is where you define the names of the functions you want to import as null-terminated strings.

The contents of the IAT (the "Hint/Name Table RVA"s in the diagram below) will actually be an exact copy of the Import Lookup Table, but **at load-time Windows will replace the contents of the IAT with pointers to the functions you want to use**; this is how Windows patches in functions from DLLs when you run your program. You can then call the patched in memory addresses to use the imported functions.

Whilst the contents of the IAT will be replaced with pointers to the functions you want to use, the Import Lookup Table will be left untouched.

{{<img src="images/import-tables-en.png" alt="Import Directory Table with Name, Import Lookup Table, IAT, and Hint/Name Table">}}

I only need to define a single Import Directory entry in the Import Directory Table, since I only need to import from `kernel32.dll`.

The first field is the `Import Lookup Table RVA` field, and I'll actually start my Import Lookup Table a bit further into the file than you might expect. I'm going to start my Import Lookup Table directly after both the name of the DLL and the IAT.

{{<note>}}
This decision is purely to make things a bit easier on myself when it comes to writing programs later.

The IAT is the place in memory that will contain function pointers patched in by Windows at load-time that I want to call from the program's code, which means I'll need to calculate relative addresses that tell the CPU where the function pointers are.

If the IAT is placed after the Import Lookup Table, then any additions to the Import Lookup Table will naturally push the IAT addresses up, meaning I'll have to recalculate all of the function call relative addresses again in the `.text` section.

On the other hand, if I make sure to define the IAT before the Import Lookup Table, then the IAT can grow and shrink without forcing me to update all of the relative addresses in the code all the time.

Since I'm writing the first executables entirely by hand this will be a huge help in minimising mistakes.

I'm putting the name of the DLL before the IAT simply because once it's defined it won't change anyway, and leaving it in front of the IAT and Import Lookup Table will make them easier to find in a debugger.
{{</note>}}

Because of this I need to look ahead and figure out how many bytes the Import Directory entries themselves will occupy along with the number of bytes the DLL name and IAT will occupy. Once I know these numbers I can calculate the RVA of the Import Lookup Table as `<.rdata RVA> + <bytes occupied by other data>`.

I know that each Import Directory entry takes up 20 bytes in total, and I need two of them; one to define the `kernel32.dll` RVAs, which I'm doing now, and another one filled with zeros to indicate the end of the table, giving me a total of 40 bytes occupied by the Import Directory entries. I'll actually put the name of the DLL I want to import from after the Import Directory Table, so if I add these 40 bytes to the `.rdata` RVA I get a new RVA of `0x2028`, which I'll use for the `Name RVA` field.

I also know that the name of the DLL to import from is `kernel32.dll` and that it must be null-terminated, which adds an extra byte onto the end, so the length of this string will be 13 bytes. In total this puts me so far at 53 bytes occupied by other data. Skipping 53 bytes from the `.rdata` RVA would give me an RVA of `0x2035`, but I still need to take the size of the IAT into account because I want to start my Import Lookup Table after the IAT.

I'd like to start my IAT on an eight byte boundary so the pointers are aligned correctly. Because of this I'll add three extra null bytes after the name, giving me a total of 56 bytes so far, and placing the start of my IAT at a nice even RVA of `0x2038` instead.

{{<note>}}
As far as I know having your IAT and Import Lookup Table aligned to an eight byte boundary isn't required at all; it's just something I want to do so I can find them easier in a debugger.
{{</note>}}

The IAT and Import Lookup Table are both arrays which, like the Import Directory Table, end in a final null entry to identify the end. Each entry in these tables is eight bytes in length, which matches the size of a pointer.

Since I only need to import one function from `kernel32.dll` (`GetProcessVersion`) I know that I only need two entries in the IAT; one to define the function to import, and another to identify the end of the array. Adding another 16 bytes to the 56 bytes occupied by other data so far gives me 72 bytes to skip from the `.rdata` RVA in total, which would put the start of the Import Lookup Table at the RVA `0x2048`.

In figuring out the RVA for the Import Lookup Table I've actually found the RVAs for the other fields too. In addition, I know that I want to put the Hint/Name Table directly after all of the import data, and since the Import Lookup Table at the moment is only 16 bytes in total I can add that to `0x2048` to get `0x2058` for the start of the Hint/Name Table.

This gives me the following RVAs:

- `Name RVA` will be `0x2028`
- `Import Address Table RVA` will be `0x2038`
- `Import Lookup Table RVA` will be `0x2048`
- `Hint/Name Table` will be `0x2058`

{{<img src="images/import-tables-kernel-32-en.png" alt="The order I'll define import data in and their RVAs">}}

{{<note>}}
Earlier I mentioned that the reason for this ordering of the IAT and Import Lookup Table was to save me from recalculating RVAs when updating imports. With this scheme the Hint/Name Table will still be pushed around, so it might be worth leaving a large gap before it, but any hint/name RVAs would only need to be updated in this section of the executable, rather than in the program's code, so this will do for now.
{{</note>}}

I'll go through these in order.

I can set the first field (`Import Lookup Table RVA`) of my only Import Directory entry to `48 20 00 00`.

I'll ignore the next two fields, `Time/Date Stamp` and `Forwarder Chain`, and set them to `00 00 00 00 00 00 00 00`.

The `Name RVA` field is the offset of a string that defines the DLL name to import functions from. It's important to remember that the string must be null-terminated, so it needs a null byte on the end to indicate the end.

The DLL I want to import from is `kernel32.dll`. I'll put this string directly after the Import Directory Table, which I already know from my calculations will finish at the RVA `0x2028`, so I'll set `Name RVA` to `28 20 00 00`.

Finally, I need to fill out the `Import Address Table RVA` field, which points to my IAT. I know it will start at the RVA `0x2038`, so I'll set this field to `38 20 00 00`.

With my one and only Import Directory entry defined I can signal to Windows that it's the end of the Import Directory Table by filling out a second Import Directory entry with all zeros, so directly after the first entry I need to add 20 more null bytes to the file.

Now that the Import Directory Table is complete I need to fill out a null-terminated string that is the name of the DLL I want to import from.

The string I want to fill out is `"kernel32.dll\0"`, so I'll fill out the bytes `6b 65 72 6e 65 6c 33 32 2e 64 6c 6c 00`. I also wanted to add an extra 3 null bytes after this so I could start the IAT on an eight byte boundary, so I'll append `00 00 00` to the null-terminated string.

The IAT is actually just a complete copy of the [Import Lookup Table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#import-lookup-table), so I'll fill it out as if it were the Import Lookup Table and then just duplicate it when I get to the actual Import Lookup Table.

The table that describes the array entries for the Import Lookup Table on the MSDN page tells me that the MSB of the 64 bits that make up each entry is a flag that tells Windows whether to import the function by ordinal or by name:

> If this bit is set, import by ordinal. Otherwise, import by name. Bit is masked as 0x80000000 for PE32, 0x8000000000000000 for PE32+. 

I don't know the ordinal for the function to import, so I'll leave this bit as `0`, which tells Windows I want to import by name.

The lower 16 bits _would_ be the ordinal if I were using it, but since I'm importing by name I instead get to use the lower 31 bits to define the RVA of an entry in the ["hint/name table"](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#hintname-table).

I'll start my Hint/Name Table directly after the Import Lookup Table and the first entry in the Hint/Name Table will be the name of the function I want to import. The Hint/Name Table starts at RVA `0x2058`, so I can set the first entry in my IAT to `58 20 00 00 00 00 00 00`. Since this is the only entry I need in the IAT I can immediately follow it with a null entry to identify the end of the table, so I'll add the bytes `00 00 00 00 00 00 00 00` directly after it.

After the IAT I need to define my Import Lookup Table. As I mentioned earlier, the IAT is an exact copy of the data you would put into the Import Lookup Table, so I can just duplicate the IAT and enter `58 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00` again.

Directly after the Import Lookup Table I need to define my [Hint/Name Table](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#hintname-table). The Hint/Name Table is an array of hints, which are numbers that help to optimise function lookup, and/or null-terminated name strings of functions you want to import from various DLLs.

As explained on the MSDN page...

> One hint/name table suffices for the entire import section.

...meaning I can dump all of my hint/name pairs in this one array rather than creating a new array for every DLL I want to import from, though you could create multiple Hint/Name Tables if you wanted to.

Each entry in the hint/name table starts with two bytes, which make up the `Hint` field. The `Hint` is used to [optimise lookups for the function in the DLL](https://devblogs.microsoft.com/oldnewthing/20100317-00/?p=14573). I don't actually know the `Hint` for `GetProcessVersion`, so I'll just set these two bytes to `00 00`.

The next field, `Name`, is variable because it's a null-terminated string of the function name I want to import. In my case I want to import `GetProcessVersion`, so the string I want to set is `"GetProcessVersion\0"`, giving me the bytes `00 00 47 65 74 50 72 6f 63 65 73 73 56 65 72 73 69 6f 6e 00`.

`Pad` is the last field and its presence is determined by the length of the string in `Name`. Each entry in the hint/name table must end on an odd offset to align the start of the next entry in the array to an even offset. I don't actually have another entry to add to this table, but since my string's null-terminating byte ends on an even offset I'll add the extra `Pad` null byte as `00` to make sure it ends on an odd offset instead. This doesn't actually matter in this case, since it's the last entry with nothing else after it anyway, but I'm just doing it here to illustrate what you would do if you did need to add more names.

With the hint/name table completed there's nothing left to do. I can now just fill out the rest of the section on disk with null bytes up until offset `0x600`, which is where the executable should end since the entire section is supposed to be 512 bytes in length.

The final `.rdata` section, with some of the padding omitted from the table, looks like this:

{{<hextable start="0x400">}}
48 20 00 00 00 00 00 00 00 00 00 00 28 20 00 00
38 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 6b 65 72 6e 65 6c 33 32
2e 64 6c 6c 00 00 00 00 <58 20 00 00 00 00 00 00>
00 00 00 00 00 00 00 00 58 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 47 65 74 50 72 6f
63 65 73 73 56 65 72 73 69 6f 6e 00 00 00 00 00

0x170+
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
{{</hextable>}}

{{<note>}}
The eight bytes that I've highlighted are the IAT entry, and they will be altered at load-time with the memory address of the function I'm importing, which means I can use the entry as a pointer to call the imported function from the program's code. Only the IAT entries are altered, not the Import Lookup Table.
{{</note>}}

#### Revisiting the Data Directories

Remember back when I filled out the [data directories part of the optional header](#data-directories)?

I left the values in the Import Table and IAT data-directory entries only partially filled in. Well now that I've actually defined my Import Directory Table and IAT I can go back to set those entries to the correct values.

For the Import Table data-directory entry I know that it points to the Import Directory Table at RVA `0x2000`, so there's no change to the `VirtualAddress`, but I now know that it's 40 bytes in size (the first entry in the table plus the null entry identifying the end), so I can set that field to `28 00 00 00`.

The IAT's `VirtualAddress` and `Size` both need to change. The `VirtualAddress` I now know is `0x2038`, so I'll set that to `38 20 00 00`, and the `Size` of my IAT is 16 bytes (the first entry plus the null entry identifying the end), so I can set that to `10 00 00 00`.

The new data directories should look like this, where the highlighted bytes have been updated:

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

### The .text Section

The `.text` section of the executable is where you store the machine code instructions of the program that will be executed by the CPU.

I said that I wanted to call the Win32 function `GetProcessVersion` from `kernel32.dll`, so that's what the code I write here will do.

{{<note>}}
The Microsoft x64 ABI requires the caller to reserve 32 bytes of shadow space for every call, even when the callee takes fewer than four parameters. When this entry-point function begins, the return address already on the stack leaves rsp 8 bytes away from a 16-byte boundary. Subtracting 40 bytes (0x28) reserves the required 32-byte shadow space plus 8 bytes of alignment padding, leaving rsp 16-byte aligned before the call.

This deliberately tiny image does not contain the `.pdata`/`.xdata` unwind metadata normally required for a non-leaf x64 function. Normal execution works, but an exception could not be reliably unwound through this function.
{{</note>}}

The hex in these steps is the encoded x64 intructions. I'm not going to explain in any detail how the code here works, but I will look at the instructions in detail in the next post.

All this code will do is:

- Reserve the mandatory 32-byte shadow space and another 8 bytes to keep the stack 16-byte aligned at the call site: `48 83 ec 28`
- Set the value of the `rcx` register to `0` (well, `ecx` really): `31 c9`
- Call the imported `GetProcessVersion` function: `ff 15 2c 10 00 00`
- Restore the stack pointer: `48 83 c4 28`
- Return to the function that called the program to exit: `c3`

The instructions in my `.text` section look like this, and need to replace the first 17 bytes from the offset `0x200` in the executable:

{{<hextable start="0x200">}}
48 83 ec 28 31 c9 ff 15 2c 10 00 00 48 83 c4 28
c3
{{</hextable>}}

These instructions will be loaded into memory at the RVA `0x1000`, and because I told Windows that the entry point of my code (`AddressOfEntryPoint`) is `0x1000`, that's where it will start execution of the program.

The rest of the section is padded with null bytes up until offset `0x400` where the `.rdata` section starts as it was before.

## Testing the Executable

I now have an executable that's exactly 1,536 (`0x600`) bytes in size that I can run, and that should return the value of a call to the `GetProcessVersion` function.

{{<textdump title="Final executable binary">}}
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
00 00 00 00 00 00 00 00 38 20 00 00 10 00 00 00
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
48 83 EC 28 31 C9 FF 15 2C 10 00 00 48 83 C4 28
C3 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
48 20 00 00 00 00 00 00 00 00 00 00 28 20 00 00
38 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 6B 65 72 6E 65 6C 33 32
2E 64 6C 6C 00 00 00 00 58 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 58 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 47 65 74 50 72 6F
63 65 73 73 56 65 72 73 69 6F 6E 00 00 00 00 00
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
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
{{</textdump>}}

If I run this executable from the command line I should see that it exits with no errors and no output:

```bat
$ rei_0
```

After running the program I can then `echo` the variable `%errorlevel%`, which contains the integer returned from the last program that was run:

```bat
$ echo %errorlevel%
393216
```

You can see that the return value from the program was `393216`. This is the return value of the `GetProcessVersion` function call I made, which in turn was returned from the program.

As described by the [`GetProcessVersion` function page on MSDN](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getprocessversion), this function...

> Retrieves the major and minor version numbers of the system on which the specified process expects to run.

...which means that it's actually returning the number I set at the beginning of my executable in the `MajorSubsystemVersion` and `MinorSubsystemVersion` fields.

I set `MajorSubsystemVersion` to `06 00` and `MinorSubsystemVersion` to `00 00`, which together give me the hex value `0x00060000`. If I convert the hex to decimal I do indeed get the value `393216`, which means the program worked!

I want to quickly highlight what happened to the import data from the executable when it was mapped into memory at load-time as well.

If I open the program in a debugger and step into the entry point of the program, I can see the following disassembly. This is the assembly the debugger is showing me based on the machine code it sees:

{{<disassembly>}}
00007FF68CD0:1000   | 48 83 ec 28       | sub rsp, 0x28
00007FF68CD0:1004   | 31 c9             | xor ecx, ecx
: 00007FF68CD0:1006 | ff 15 2c 10 00 00 | call qword ptr [rip+0x102c]
00007FF68CD0:100C   | 48 83 c4 28       | add rsp, 0x28
00007FF68CD0:1010   | c3                | ret
{{</disassembly>}}

I've highlighted the line from the debugger that contains the `call` instruction, which in this case is giving the CPU a RIP relative address to a location in memory that contains the address of a function to call.

{{<note>}}
I'll look at RIP relative addressing in the next post, but it's basically just a way to refer to addresses in memory based on a displacement from the value in the `RIP` register.
{{</note>}}

You can see that the instruction after the `call` starts at RVA `0x100c`; this is the `rip` value used as the base for the call's RIP-relative address. If I add `0x102c` to `0x100c` I get `0x2038`, which is the exact spot I defined the IAT at earlier for importing the `GetProcessVersion` function from `kernel32.dll`.

If I open a memory window in the debugger and navigate to the address `rip+0x102c` I see the following:

{{<hextable start="0x2000">}}
48 20 00 00 00 00 00 00 00 00 00 00 28 20 00 00
38 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 6b 65 72 6e 65 6c 33 32
2e 64 6c 6c 00 00 00 00 <30 fd 08 c5 fc 7f 00 00>
00 00 00 00 00 00 00 00 58 20 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 47 65 74 50 72 6f
63 65 73 73 56 65 72 73 69 6f 6e 00 00 00 00 00
{{</hextable>}}

Notice that this is the `.rdata` section from offset `0x400` in the executable, but it's been mapped into memory at an RVA of `0x2000`, as I requested it should be.

I've highlighted the part of the IAT that I said Windows would change for me at load-time with an address for the function I wanted to import. This is the RVA `0x2038` I just calculated from `rip+0x102c`. This is how the CPU knows which address to call for imported functions.

If you look below the patched IAT you'll also notice that the Import Lookup Table still has its original `58 20 00 00 00 00 00 00` value, and so remains untouched.

With a basic executable in place that I can use to run code and have Windows patch in OS functions for me, I now have everything I need to start writing the initial bootstrap compiler for Rei.
