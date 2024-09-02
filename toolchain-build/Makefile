ARC_DESTDIR := $(dir $(ARC_BUILD))

export ARC_DESTDIR

ARC_SYSROOT := $(ARC_BUILD)

export ARC_SYSROOT

PREFIX := /

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--prefix=$(ARC_SYSROOT)/usr \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C mlibc
	$(MAKE) -C gcc

	ln -sf $(ARC_SYSROOT)/usr/bin $(ARC_SYSROOT)/bin
	ln -sf $(ARC_SYSROOT)/usr/bin $(ARC_SYSROOT)/sbin
	ln -sf $(ARC_SYSROOT)/usr/include $(ARC_SYSROOT)/include
	ln -sf $(ARC_SYSROOT)/usr/lib $(ARC_SYSROOT)/lib
	ln -sf $(ARC_SYSROOT)/usr/lib $(ARC_SYSROOT)/lib64
