ARC_VERSION := 6.5
ARC_NAME := ncurses-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://invisible-mirror.net/archives/ncurses/$(ARC_TAR)

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	mkdir -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build &&  ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS) --enable-shared --enable-host-shared

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)
