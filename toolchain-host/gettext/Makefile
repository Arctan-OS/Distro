VERSION := 0.22.5
NAME := gettext-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/gettext/$(TAR)
COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) ../gettext-src/configure --prefix=$(ARC_DESTDIR)/usr/ $(AC_USE_TOOLCHAIN)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf gettext-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) gettext-src
	cd gettext-src && patch -p1 < ../gettext.patch
