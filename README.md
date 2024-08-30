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



