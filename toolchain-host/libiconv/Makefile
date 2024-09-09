VERSION := 1.17
NAME := libiconv-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/libiconv/$(TAR)
COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) ../libiconv-src/configure $(AC_FLAGS)

	$(MAKE) -C build
	DESTDIR=$(ARC_DESTDIR) $(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf libiconv-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) libiconv-src
	cd libiconv-src && patch -p1 < ../libiconv.patch
