DESTDIR := $(dir $(ARC_INITRAMFS))
export DESTDIR

PREFIX := /
export PREFIX

AC_FLAGS := --prefix=$(PREFIX) --exec-prefix=$(PREFIX)
export AC_FLAGS

all:
	make -C mlibc -j$(nproc)
#	make -C gcc -j$(nprocs)
	make -C bash-5.2 -j$(nproc)
