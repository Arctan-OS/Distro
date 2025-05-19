ARC_REPO := https://github.com/managarm/mlibc
ARC_VERSION := 0e63cc9b3d49f678bf330ee9d71d2eee6c1716e1
ARC_NAME := mlibc-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := $(ARC_REPO)/archive/$(ARC_VERSION).tar.gz

MESON_FLAGS := --reconfigure --cross-file $(ARC_BUILD_SUPPORT)/meson.cross --prefix=$(ARC_HOST_PREFIX) \
		-Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both -Ddisable_libgcc_dependency=true \
		build


NINJA_FLAGS := -C build

MLIBC_ROOT := $(ARC_TOOLCHAIN_HOST)/mlibc-headers/$(ARC_SOURCE_DIR)

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	make -C freestanding-libgcc-libraries

	rm -rf $(MLIBC_ROOT)/build
	mkdir -p $(MLIBC_ROOT)/build

	cd $(MLIBC_ROOT) && $(ARC_SET_COMPILER_ENV_FLAGS) LDFLAGS="-Wl,$(ARC_TOOLCHAIN_HOST)/mlibc-libraries/freestanding-libgcc-libraries/libgcc-bin/libgcc-x86_64.a" \
			    meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	meson install -C $(MLIBC_ROOT)/build

	touch $(COMPLETE)
