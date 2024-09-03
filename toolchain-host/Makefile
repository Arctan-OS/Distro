ARC_DESTDIR := $(dir $(ARC_HOST))

export ARC_DESTDIR

ARC_SYSROOT := $(ARC_HOST)

export ARC_SYSROOT

PREFIX := /

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--host=$(OS_TRIPLET) \
		--prefix=$(ARC_SYSROOT)/usr \
		--disable-nls \
		--disable-werror

export AC_FLAGS

AC_CFLAGS := CFLAGS=-Wl,-rpath-link,$(ARC_BUILD)/lib

export AC_CFLAGS

all:
	mkdir -p $(ARC_SYSROOT)/usr/bin $(ARC_SYSROOT)/usr/include $(ARC_SYSROOT)/usr/lib

	ln -sf $(ARC_SYSROOT)/usr/bin $(ARC_SYSROOT)/bin
	ln -sf $(ARC_SYSROOT)/usr/bin $(ARC_SYSROOT)/sbin
	ln -sf $(ARC_SYSROOT)/usr/include $(ARC_SYSROOT)/include
	ln -sf $(ARC_SYSROOT)/usr/lib $(ARC_SYSROOT)/lib
	ln -sf $(ARC_SYSROOT)/usr/lib $(ARC_SYSROOT)/lib64

	$(MAKE) -C mlibc
	$(MAKE) -C gcc
	$(MAKE) -C gettext
#	$(MAKE) -C bash
