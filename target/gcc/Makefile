VERSION := 14.2.0
GCC_NAME := gcc-$(VERSION)
export GCC_NAME
TAR := $(GCC_NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gcc/$(GCC_NAME)/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	make -C binutils

# TODO: Use $(ARC_ROOT)/host/gcc/build to make all-target-libgcc and install-target-libgcc.
#       Just change around the directories so that it is installed into the initramfs instead.

$(TAR):
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
