ARC_DESTDIR := $(dir $(ARC_TOOLCHAIN))

export ARC_DESTDIR

PREFIX := /

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--prefix=$(ARC_DESTDIR)/ \
		--with-sysroot=$(ARC_DESTDIR) \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	make -C mlibc
	make -C gcc
