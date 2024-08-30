REPO := https://github.com/managarm/mlibc
MESON_FLAGS := --reconfigure --cross-file $(ARC_ROOT)/build-support/cross.txt --prefix=$(PREFIX) \
		-Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both \
		--sysconfdir=/etc --localstatedir=/var --libdir=lib --sbindir=sbin --bindir=bin --includedir=include \
		build

MLIBC_ROOT := $(ARC_ROOT)/host/mlibc/mlibc
NINJA_FLAGS := -j8 -C build
COMPLETE := build.complete

all:
	rm -rf $(MLIBC_ROOT)/build
	mkdir $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && meson setup $(MESON_FLAGS) -Dheaders_only=true
	DESTDIR=$(DESTDIR) meson install -C $(MLIBC_ROOT)/build

	rm -rf $(MLIBC_ROOT)/build
	mkdir $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	DESTDIR=$(DESTDIR) meson install -C $(MLIBC_ROOT)/build
