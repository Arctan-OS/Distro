# Don't forget to update this in toolchain-host/gcc/binutils
ARC_VERSION := 2.43
ARC_NAME := binutils-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/binutils/$(ARC_TAR)

COMPLETE := build.complete

$(COMPLETE):
	rm -rf build
	mkdir build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh
	$(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh

	cd build && ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)
