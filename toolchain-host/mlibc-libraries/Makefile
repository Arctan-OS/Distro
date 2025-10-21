include $(ARC_TOOLCHAIN_HOST)/mlibc-headers/Makefile

STANDALONE_LIBGCC_DATE := 2025-08-21
STANDALONE_LIBGCC_MIRROR := https://github.com/osdev0/libgcc-binaries/releases/download/$(STANDALONE_LIBGCC_DATE)/libgcc-$(ARC_OPT_ARCH).a

MESON_FLAGS := --reconfigure --cross-file $(ARC_BUILD_SUPPORT)/meson.cross --prefix=$(ARC_HOST_PREFIX) \
		--buildtype=debugoptimized -Ddefault_library=both -Dlibgcc_dependency=false -Duse_freestnd_hdrs=enabled \
		build

NINJA_FLAGS := -C build

MLIBC_ROOT := $(ARC_TOOLCHAIN_HOST)/mlibc-headers/$(ARC_SOURCE_DIR)

COMPLETE := $(shell realpath build.complete)

$(MLIBC_ROOT)/libgcc-$(ARC_OPT_ARCH).a:
	$(CURL) -Lo $(MLIBC_ROOT)/libgcc-$(ARC_OPT_ARCH).a $(STANDALONE_LIBGCC_MIRROR)

$(COMPLETE): $(MLIBC_ROOT)/libgcc-$(ARC_OPT_ARCH).a
	$(RM) -rf $(MLIBC_ROOT)/build
	$(MKDIR) -p $(MLIBC_ROOT)/build

	$(CD) $(MLIBC_ROOT) && $(ARC_SET_COMPILER_ENV_FLAGS) LDFLAGS="-Wl,$(MLIBC_ROOT)/libgcc-$(ARC_OPT_ARCH).a" \
			    meson setup $(MESON_FLAGS) -Dno_headers=true
	$(MESON) install -C $(MLIBC_ROOT)/build

	$(TOUCH) $(COMPLETE)
