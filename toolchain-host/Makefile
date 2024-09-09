ARC_DESTDIR := $(dir $(ARC_SYSROOT))

export ARC_DESTDIR

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--host=$(OS_TRIPLET) \
		--prefix=$(PREFIX) \
		--with-sysroot=/ \
		--with-build-sysroot=$(ARC_SYSROOT) \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C mlibc-libraries
	$(MAKE) -C libgcc
	$(MAKE) -C gcc

	$(MAKE) -C libiconv
	$(MAKE) -C gettext


# TODO: Do this
#	$(MAKE) -C ncurses
#	$(MAKE) -C bash
