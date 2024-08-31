VERSION := 14.2.0
GCC_NAME := gcc-$(VERSION)
export GCC_NAME
TAR := $(GCC_NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gcc/$(GCC_NAME)/$(TAR)

AC_EXTRA_FLAGS := \
		  --enable-languages=c,c++,lto \
			--enable-shared \
			--enable-host-shared \
			--disable-multilib \
			--enable-initfini-array

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	make -C binutils

	rm -rf build
	mkdir build

	cd build && ../$(GCC_NAME)/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	make -C build all-gcc all-target-libgcc
	make -C build install-gcc install-target-libgcc

	touch $(COMPLETE)

$(TAR):
	rm -rf $(GCC_NAME)
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	cd $(GCC_NAME) && patch -p1 < ../gcc.patch
