VERSION := 6.5
NAME := ncurses-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://invisible-mirror.net/archives/ncurses/$(TAR)
COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

#	cd build && $(AC_CFLAGS) ../$(NAME)/configure --prefix=$(ARC_DESTDIR)/usr/ $(AC_USE_TOOLCHAIN)

#	$(MAKE) -C build
#	$(MAKE) -C build install

#	touch $(COMPLETE)

$(TAR):
	rm -rf $(NAME)
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
#	cd $(NAME) && patch -p1 < ../gettext.patch
