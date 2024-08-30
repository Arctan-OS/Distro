VERSION := 14.2.0
GCC_NAME := gcc-$(VERSION)
export GCC_NAME
TAR := $(GCC_NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gcc/$(GCC_NAME)/$(TAR)

AC_EXTRA_FLAGS := --target=$(OS_TRIPLET) \
		  --with-prefix=/ \
		  --with-sysroot=$(ARC_TOOLCHAIN) \
		  --disable-nls \
		  --enable-languages=c,c++,lto \
		  --disable-multilib \
		  --enable-initfini-array \
		  --enable-shared \
		  --enable-host-shared

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	make -C binutils

	rm -rf build
	mkdir build
	cd build && ../$(GCC_NAME)/configure $(AC_EXTRA_FLAGS)
	make -C build all-gcc
	make -C build install-gcc

	touch $(COMPLETE)

$(TAR):
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	cd $(GCC_NAME) && patch -p1 < ../gcc.patch
