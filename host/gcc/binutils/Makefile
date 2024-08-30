VERSION := 2.43
NAME := binutils-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/binutils/$(TAR)

AC_EXTRA_FLAGS := --target=$(OS_TRIPLET) \
		  --with-prefix=/ \
		  --with-sysroot=$(ARC_TOOLCHAIN) \
		  --disable-nls \
		  --disable-werror

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../$(NAME)/configure $(AC_EXTRA_FLAGS)
	make -C build
	make -C build install
	
	touch $(COMPLETE)

$(TAR):
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	cd $(NAME) && patch -p1 < ../binutils.patch