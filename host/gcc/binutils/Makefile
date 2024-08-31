VERSION := 2.43
NAME := binutils-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/binutils/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && ../$(NAME)/configure $(AC_FLAGS)
	make -C build
	make -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf $(NAME)
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	cd $(NAME) && patch -p1 < ../binutils.patch
