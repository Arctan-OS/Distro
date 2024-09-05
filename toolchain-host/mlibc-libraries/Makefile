MESON_FLAGS := --reconfigure --cross-file $(ARC_ROOT)/build-support/meson.cross --prefix=$(PREFIX) \
		-Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both -Ddisable_libgcc_dependency=true \
		build


NINJA_FLAGS := -C build

MLIBC_ROOT := $(ARC_TOOLCHAIN_BUILD)/mlibc-headers/mlibc-src

COMPLETE := build.complete

$(COMPLETE):
	make -C freestanding-libgcc-libraries

	rm -rf $(MLIBC_ROOT)/build
	mkdir $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && LDFLAGS="-Wl,$(ARC_TOOLCHAIN_HOST)/mlibc-libraries/freestanding-libgcc-libraries/libgcc-bin/libgcc-x86_64.a" \
			    meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	DESTDIR=$(ARC_SYSROOT) meson install -C $(MLIBC_ROOT)/build

	touch $(COMPLETE)
