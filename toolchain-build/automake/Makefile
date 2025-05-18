VERSION := 1.16.2
NAME := automake-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/automake/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../automake-src/configure --prefix=$(ARC_SYSROOT)$(PREFIX)

	$(MAKE) -C build
	$(MAKE) -C build install

	cp -pv $(ARC_SYSROOT)/usr/local/share/autoconf/build-aux/config.sub $(ARC_DESTDIR)$(PREFIX)/share/automake-1.16

	touch $(COMPLETE)

$(TAR):
	rm -rf automake-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) automake-src
