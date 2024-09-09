VERSION := 0.22.5
NAME := gettext-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gettext/$(TAR)
COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../gettext-src/configure $(AC_FLAGS)

	$(MAKE) -C build
	DESTDIR=$(ARC_DESTDIR) $(MAKE) -C build install

	rm ../libiconv/build.complete
	$(MAKE) -C ../libiconv

	touch $(COMPLETE)

$(TAR):
	rm -rf gettext-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) gettext-src
	cd gettext-src && patch -p1 < ../gettext.patch
