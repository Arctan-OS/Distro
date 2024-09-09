VERSION := bff01a69a35d368d54165d2340be55a46233917b
NAME := gnulib-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://git.savannah.gnu.org/cgit/gnulib.git/snapshot/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	./gnulib-src/gnulib-tool --create-testdir --with-tests --dir=./build --dry-run

	$(MAKE) -C build
	DESTDIR=$(ARC_DESTDIR) $(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf gnulib-src
	curl -o $(TAR) -L $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) gnulib-src
	cd gnulib-src && patch -p1 < ../gnulib.patch
