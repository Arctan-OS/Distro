DESTDIR := $(dir $(ARC_INITRAMFS))
export DESTDIR

AC_CONFIGURE := --prefix=$(PREFIX) --exec-prefix=$(PREFIX)
export AC_CONFIGURE

all:
	make -C mlibc
	make -C gcc
	make -C bash-5.2
