ARC_DESTDIR := $(dir $(ARC_SYSROOT))

export ARC_DESTDIR

PREFIX := /usr

export PREFIX

AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--host=$(OS_TRIPLET) \
		--prefix=$(ARC_SYSROOT)/usr \
		--disable-nls \
		--disable-werror

export AC_FLAGS

AC_CFLAGS :=
#CFLAGS=-Wl,-rpath-link,$(ARC_BUILD)/lib

export AC_CFLAGS

all:
	$(MAKE) -C libgcc
	$(MAKE) -C mlibc-libraries
#	$(MAKE) -C gcc
	$(MAKE) -C gettext
#	$(MAKE) -C bash
