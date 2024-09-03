MESON_FLAGS := --reconfigure --cross-file $(ARC_ROOT)/build-support/meson.cross --prefix=$(PREFIX) \
		--buildtype=debugoptimized -Ddefault_library=both \
		build

#		-Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \

NINJA_FLAGS := -C build

MLIBC_ROOT := $(ARC_TOOLCHAIN_BUILD)/mlibc-headers/mlibc-src

COMPLETE := build.complete

$(COMPLETE):
	rm -rf $(MLIBC_ROOT)/build
	mkdir $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	DESTDIR=$(ARC_SYSROOT) meson install -C $(MLIBC_ROOT)/build

	touch $(COMPLETE)
