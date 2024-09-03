ARC_DESTDIR := $(dir $(ARC_SYSROOT))

export ARC_DESTDIR

PREFIX := /usr

export PREFIX

AC_FLAGS := \
		--with-sysroot=$(ARC_SYSROOT) \
		--target=$(OS_TRIPLET) \
		--prefix=$(ARC_DESTDIR)/usr \
		--disable-nls \
		--disable-werror

export AC_FLAGS

AC_CFLAGS := CFLAGS=-Wl,-rpath-link,$(ARC_BUILD)/lib

export AC_CFLAGS

all:
	$(MAKE) -C mlibc-headers
	$(MAKE) -C gcc
