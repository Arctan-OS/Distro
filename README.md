# Arctan-OS/Distro

## What
This is a repository which contains everything required to build an operating system which
uses Arctan-OS/Kernel and an Arctan compatible bootstrapper.

## Components
* [Kernel](https://github.com/Arctan-OS/Kernel)
* Bootstrapper
  * [Multiboot2 (mb2)](https://github.com/Arctan-OS/MB2BSP)
  * [Limine (lbp)](https://github.com/Arctan-OS/LBPBSP) (Work in Progress)

## Requirements
* gcc
* ld
* xorriso
* nasm
* make
* gzip
* cpio
* qemu
* See the requirements for the bootstrapper you are building with.
* Packages to build Binutils
* Packages to build GCC
* curl

## Build Instructions
The distrobution can be built with a command of the following form:

```shell
$ make <bsp> all
```

Where `<bsp>` is replaced with the shortened version of the bootstrapper to use.
For instance, if one were to build using the Multiboot2 bootstrapper, `<bsp>` would
be substituted by `mb2`.

The resultant ISO file can be started in `qemu-system-x86_64` using the following
command:

```shell
$ make run
```

## Directory Layout

The build system is organized into the following inital directories:
* build-support
* initramfs-constant
* toolchain-build
* toolchain-host

And the following runtime directories:
* build
* host
* initramfs
* volatile

NOTE: A program's build machine is the machine on which it is compiled (or built), the host machine
is the one on which the program is run.

### build-support

The build-support subdirectory contains files which aid in building the final disk image. These
may contain files used in the building of the build toolchain, host toolchain, kernel, and bootstrapper.

### initramfs-constant

These are files which are to be included in the final initramfs CPIO image. The contents of the subdirectory
are copied after the contents of host have been copied to the initramfs.

### toolchain-build

This subdirectory includes a sysroot folder, numerous other directories which contain the various programs
to build, and a topmost Makefile. The topmost Makefile establishes the aforementioned sysroot directory
and initializes the build of all programs under the directory.

This system does not build dependencies first,
it will build whatever it is told to build first. Therefore, if program A depends on programs B and C, then
the invokation of the B and C's Makefiles should be placed prior to the invokation of A's Makefile.

NOTE: In the case of GCC, the build files for Binutils are placed in the aptly named "binutils" subdirectory.
This way, when the toplevel Makefile does not have to worry about building Binutils prior to GCC, rather it 
can blindly call to build GCC.

NOTE: The sysroot merely acts as a build directory, and is not the final installation destination.

### toolchain-host

This subdirectory's purpose is identical to toolchain-build, in that it builds a toolchain; however, in this case
it instead builds it for the host machine (rather than the build machine) using the toolchain created by toolchain-build.

### build 

This subdirectory contains the final installtion of the build machine's toolchain.

### host

This subdirectory contains the final installation of the host's toolchain.

### initramfs

This directory contains all files which are to be included in the final initramfs image. This directory
is constructed in the following manner:
1. Copy all files from host.
2. Copy all files from initramfs-constant.

### volatile

This contains the kernel and bootstrapper which are to be built.

NOTE: It is the responsibility of the bootstrapper to construct the final product, defined by \$(ARC_PRODUCT),
and to appropriately install the kernel executable, located at \$(ARC_ROOT)/volatile/kernel/kernel.elf, and initramfs,
located at $(ARC_ROOT)/initramfs.cpio, into this final product.
