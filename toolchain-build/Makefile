ARC_DESTDIR := $(dir $(ARC_SYSROOT))

export ARC_DESTDIR

PREFIX := /usr

export PREFIX

AC_FLAGS := \
		--with-sysroot=$(ARC_SYSROOT) \
		--target=$(OS_TRIPLET) \
		--prefix=$(ARC_DESTDIR)/$(PREFIX) \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C mlibc-headers
	$(MAKE) -C gcc
