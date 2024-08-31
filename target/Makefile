DESTDIR := $(dir $(ARC_INITRAMFS))
export DESTDIR

PREFIX := /
export PREFIX

AC_FLAGS := --prefix=$(PREFIX)
export AC_FLAGS

all:
	make -C mlibc
	make -C gcc
#	make -C bash
