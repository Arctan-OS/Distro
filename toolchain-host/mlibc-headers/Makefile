ARC_REPO := https://github.com/managarm/mlibc
ARC_VERSION := fae50a5e9ac246e3fc03bcc26090db6ae43b5b3f
ARC_NAME := mlibc-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := $(ARC_REPO)/archive/$(ARC_VERSION).tar.gz

MESON_FLAGS := --reconfigure --cross-file $(ARC_BUILD_SUPPORT)/meson.cross --prefix=$(ARC_HOST_PREFIX) \
		--buildtype=debugoptimized -Ddefault_library=both \
		build

NINJA_FLAGS := -C build

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	mkdir -p $(ARC_SOURCE_DIR)/build

	cd $(ARC_SOURCE_DIR) && $(ARC_SET_COMPILER_ENV_FLAGS) meson setup $(MESON_FLAGS) -Dheaders_only=true
	meson install -C $(ARC_SOURCE_DIR)/build

	touch $(COMPLETE)

