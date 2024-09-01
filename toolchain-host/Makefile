ARC_DESTDIR := $(dir $(ARC_HOST))

export ARC_DESTDIR

ARC_SYSROOT := $(ARC_TOOLCHAIN_HOST)/sysroot

export ARC_SYSROOT

PREFIX := /

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--host=$(OS_TRIPLET) \
		--prefix=$(ARC_SYSROOT)/ \
		--with-sysroot=$(ARC_SYSROOT) \
		--with-build-sysroot=$(ARC_BUILD) \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	mkdir -p $(ARC_SYSROOT)

	$(MAKE) -C mlibc
	$(MAKE) -C gcc
	$(MAKE) -C gettext
	$(MAKE) -C bash
