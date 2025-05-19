VERSION := 5.2
NAME := bash-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/bash/$(TAR)
COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) ../bash-src/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf bash-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) bash-src
	cd bash-src && patch -p1 < ../bash.patch
