VERSION := 2.4.7
NAME := libtool-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://mirror.csclub.uwaterloo.ca/gnu/libtool/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../libtool-src/configure --prefix=$(ARC_SYSROOT)/$(PREFIX)

	$(MAKE) -C build
	$(MAKE) -C build install

	cp -pv $(ARC_SYSROOT)/usr/local/share/autoconf/build-aux/config.sub $(ARC_DESTDIR)/$(PREFIX)/share/libtool

	touch $(COMPLETE)

$(TAR):
	rm -rf libtool-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) libtool-src
	cd libtool-src && patch -p1 < ../libtool.patch
