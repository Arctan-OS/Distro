VERSION := 4.2.1
NAME := mpfr-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/mpfr/$(TAR)

AC_EXTRA_FLAGS := --with-gmp-include=$(ARC_HOST)/include --with-gmp-lib=$(ARC_HOST)/lib

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../mpfr-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	make -C build
	make -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf mpfr-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) mpfr-src
	cd mpfr-src && patch -p1 < ../mpfr.patch
