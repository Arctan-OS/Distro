VERSION := 6.3.0
NAME := gmp-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gmp/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../gmp-src/configure $(AC_FLAGS) --enable-shared

	make -C build
	DESTDIR=$(ARC_DESTDIR) make -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf gmp-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) gmp-src
	cd gmp-src && patch -p1 < ../gmp.patch
