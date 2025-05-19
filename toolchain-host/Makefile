ARC_DESTDIR := $(ARC_SYSROOT)

export ARC_DESTDIR

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--host=$(OS_TRIPLET) \
		--prefix=$(ARC_HOST_PREFIX) \
		--with-sysroot=/ \
		--with-build-sysroot=$(ARC_SYSROOT) \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C mlibc-libraries
	$(MAKE) -C libgcc
	$(MAKE) -C gcc
# Circular dependency with libiconv and gettext
# gettext will remake libiconv
	$(MAKE) -C libiconv
	$(MAKE) -C gettext


# TODO: Do this
#	$(MAKE) -C ncurses
#	$(MAKE) -C bash
