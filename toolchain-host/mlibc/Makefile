MLIBC_ROOT := $(ARC_TOOLCHAIN_BUILD)/mlibc/mlibc-src
MESON_FLAGS := --reconfigure --cross-file $(ARC_ROOT)/build-support/cross.txt --prefix=$(PREFIX) \
		 -Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both \
		--libdir=usr/lib --bindir=usr/bin --includedir=usr/include \
		build

NINJA_FLAGS := -C build

COMPLETE := build.complete

$(COMPLETE):
	rm -rf $(MLIBC_ROOT)/build
	mkdir $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && meson setup $(MESON_FLAGS) -Dheaders_only=true
	DESTDIR=$(ARC_SYSROOT) meson install -C $(MLIBC_ROOT)/build

	rm -rf $(MLIBC_ROOT)/build
	mkdir $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	DESTDIR=$(ARC_SYSROOT) meson install -C $(MLIBC_ROOT)/build

	cp -r $(ARC_SYSROOT)/* $(ARC_DESTDIR)/

	touch $(COMPLETE)
