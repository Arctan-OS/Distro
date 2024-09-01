ARC_DESTDIR := $(dir $(ARC_BUILD))

export ARC_DESTDIR

ARC_SYSROOT := $(ARC_TOOLCHAIN_BUILD)/sysroot

export ARC_SYSROOT

PREFIX := /

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--prefix=$(ARC_SYSROOT)/ \
		--with-sysroot=$(ARC_SYSROOT) \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	mkdir -p $(ARC_SYSROOT)

	$(MAKE) -C mlibc
	$(MAKE) -C gcc
