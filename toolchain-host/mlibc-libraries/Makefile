include $(ARC_TOOLCHAIN_HOST)/mlibc-headers/Makefile

MESON_FLAGS := --reconfigure --cross-file $(ARC_BUILD_SUPPORT)/meson.cross --prefix=$(ARC_HOST_PREFIX) \
		--buildtype=debugoptimized -Ddefault_library=both -Dlibgcc_dependency=false -Duse_freestnd_hdrs=enabled \
		build


NINJA_FLAGS := -C build

MLIBC_ROOT := $(ARC_TOOLCHAIN_HOST)/mlibc-headers/$(ARC_SOURCE_DIR)

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	make -C freestanding-libgcc-libraries

	rm -rf $(MLIBC_ROOT)/build
	mkdir -p $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && $(ARC_SET_COMPILER_ENV_FLAGS) LDFLAGS="-Wl,$(ARC_TOOLCHAIN_HOST)/mlibc-libraries/freestanding-libgcc-libraries/libgcc-bin/libgcc-x86_64.a" \
			    meson setup $(MESON_FLAGS) -Dno_headers=true
	meson install -C $(MLIBC_ROOT)/build

	touch $(COMPLETE)
