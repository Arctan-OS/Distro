# Don't forget to update this in mlibc-libraries
ARC_REPO := https://github.com/managarm/mlibc
ARC_VERSION := 0e63cc9b3d49f678bf330ee9d71d2eee6c1716e1
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_NAME := mlibc-$(ARC_VERSION)
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := $(ARC_REPO)/archive/$(ARC_VERSION).tar.gz

MESON_FLAGS := --reconfigure --cross-file $(ARC_BUILD_SUPPORT)/meson.cross --prefix=$(ARC_HOST_PREFIX) \
		-Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both \
		build

NINJA_FLAGS := -C build

COMPLETE := build.complete

$(COMPLETE): $(TAR)
	rm -rf $(ARC_SOURCE_DIR)/build
	mkdir $(ARC_SOURCE_DIR)/build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd $(ARC_SOURCE_DIR) && $(ARC_SET_COMPILER_ENV_FLAGS) meson setup $(MESON_FLAGS) -Dheaders_only=true
	meson install -C $(ARC_SOURCE_DIR)/build

	touch $(COMPLETE)

