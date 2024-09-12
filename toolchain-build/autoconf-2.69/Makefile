VERSION := 2.69
NAME := autoconf-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/autoconf/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../autoconf-src/configure --prefix=$(ARC_SYSROOT)/$(PREFIX)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf autoconf-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) autoconf-src
	cd autoconf-src && patch -p1 < ../autoconf.patch
