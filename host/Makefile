DESTDIR := $(dir $(ARC_TOOLCHAIN))
export DESTDIR

PREFIX := /
export PREFIX

AC_CONFIGURE := --prefix=$(PREFIX) --exec-prefix=$(PREFIX)
export AC_CONFIGURE

all:
	make -C mlibc -j$(nprocs)
	make -C gcc -j12
