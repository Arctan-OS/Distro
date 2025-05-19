ARC_VERSION := 1.17
ARC_NAME := libiconv-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/libiconv/$(ARC_TAR)
COMPLETE := build.complete

$(COMPLETE):
	rm -rf build
	mkdir build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && $(AC_CFLAGS) ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)

