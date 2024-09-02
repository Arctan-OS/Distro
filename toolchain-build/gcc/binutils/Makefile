VERSION := 2.43
NAME := binutils-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/binutils/$(TAR)

COMPLETE := build.complete

AC_EXTRA_FLAGS := --with-sysroot=$(ARC_SYSROOT)

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../binutils-src/configure $(AC_FLAGS)
	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf binutils-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) binutils-src
	cd binutils-src && patch -p1 < ../binutils.patch
