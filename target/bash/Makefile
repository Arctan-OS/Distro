VERSION := 5.2
NAME := bash-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/bash/$(TAR)
COMPLETE := bash-$(VERSION)/$(TAR).complete
AC_EXTRA_FLAGS := --with-sysroot=$(ARC_TOOLCHAIN) --host=$(OS_TRIPLET)

$(COMPLETE): $(TAR)
	cd $(NAME) && ./configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)
	make -C $(NAME) install DESTDIR=$(DESTDIR)

	touch $(COMPLETE)

$(TAR):
	rm -rf $(NAME)
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR)
	cd $(NAME) && patch -p1 < ../bash.patch
