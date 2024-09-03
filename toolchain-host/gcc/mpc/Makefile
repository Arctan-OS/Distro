VERSION := 1.3.1
NAME := mpc-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/mpc/$(TAR)

AC_EXTRA_FLAGS := --with-gmp-include=$(ARC_HOST)/include --with-gmp-lib=$(ARC_HOST)/lib \
		  --with-mpc-include=$(ARC_HOST)/include --with-mpc-lib=$(ARC_HOST)/lib

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) ../mpc-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	make -C build
	make -C build install

	touch $(COMPLETE)

$(TAR):
	rm -rf mpc-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) mpc-src
	cd mpc-src && patch -p1 < ../mpc.patch
