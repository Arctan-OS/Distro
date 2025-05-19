ARC_VERSION := 5.2
ARC_NAME := bash-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/bash/$(ARC_TAR)
COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	mkdir -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && $(AC_CFLAGS) ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)
