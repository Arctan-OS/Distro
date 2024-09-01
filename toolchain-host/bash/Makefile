VERSION := 5.2
NAME := bash-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/bash/$(TAR)
COMPLETE := bash-$(VERSION)/tar.complete
AC_EXTRA_FLAGS := --with-sysroot=$(ARC_TOOLCHAIN) --host=$(OS_TRIPLET)

$(COMPLETE): $(TAR)
	cd bash-src && ./configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)
	$(MAKE) -C bash-src install DESTDIR=$(DESTDIR)

	touch $(COMPLETE)

$(TAR):
	rm -rf bash-src
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) bash-src
	cd bash-src && patch -p1 < ../bash.patch
