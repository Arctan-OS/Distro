VERSION := 14.2.0
NAME := gcc-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gcc/$(NAME)/$(TAR)

AC_EXTRA_FLAGS := \
		--enable-languages=c,c++,lto \
		--enable-shared \
		--enable-host-shared \
		--disable-multilib \
		--enable-initfini-array

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	$(MAKE) -C binutils

	rm -rf build
	mkdir build

	cd build && ../gcc-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	$(MAKE) -C build all-gcc
	$(MAKE) -C build install-gcc

	touch $(COMPLETE)

$(TAR):
	rm -rf gcc-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) gcc-src
	cd gcc-src && patch -p1 < ../gcc.patch
