VERSION := 6.5
NAME := ncurses-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://invisible-mirror.net/archives/ncurses/$(TAR)
COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build &&  ../ncurses-src/configure $(AC_FLAGS) --enable-shared --enable-host-shared

	$(MAKE) -C build
	DESTDIR=$(ARC_DESTDIR) $(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf $(NAME)
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) ncurses-src
	cd $(NAME) && patch -p1 < ../ncurses.patch
