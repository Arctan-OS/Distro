ARC_DESTDIR := $(dir $(ARC_SYSROOT))

export ARC_DESTDIR

PREFIX := /usr

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--host=$(OS_TRIPLET) \
		--prefix=$(ARC_DESTDIR)/$(PREFIX) \
		--with-build-sysroot=$(ARC_SYSROOT) \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C mlibc-libraries
	$(MAKE) -C libgcc

	$(MAKE) -C libiconv
	$(MAKE) -C gettext
	rm libiconv/build.complete
	$(MAKE) -C libiconv

# TODO: Do this
#	$(MAKE) -C gcc
#	$(MAKE) -C ncurses
#	$(MAKE) -C bash
