ARC_DESTDIR := $(dir $(ARC_SYSROOT))

export ARC_DESTDIR

PREFIX := $(PREFIX)/local

export PREFIX

AC_FLAGS := \
		--with-sysroot=$(ARC_SYSROOT) \
		--target=$(OS_TRIPLET) \
		--prefix=$(PREFIX) \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C $(ARC_TOOLCHAIN_HOST)/mlibc-headers
	$(MAKE) -C autoconf
	$(MAKE) -C autoconf-2.69
	$(MAKE) -C automake
	$(MAKE) -C libtool

#	$(MAKE) -C gnulib
	$(MAKE) -C gcc
