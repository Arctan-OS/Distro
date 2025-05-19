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

	cp -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} gcc-src/libgcc
	cp -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} gcc-src/libiberty

	ARC_RECONF_DIR=gcc-src $(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh -I"$(realpath ./gcc-src/config)"

	cd build && $(ARC_SET_COMPILER_ENV_FLAGS) $(ARC_SET_TARGET_COMPILER_ENV_FLAGS) ../gcc-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	$(MAKE) -C build all-gcc
	$(MAKE) -C build install-gcc

	touch $(COMPLETE)

$(TAR):
	rm -rf gcc-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) gcc-src
	cd gcc-src && patch -p1 < ../gcc.patch
