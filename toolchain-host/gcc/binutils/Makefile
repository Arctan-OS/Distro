ARC_VERSION := 2.43
ARC_NAME := binutils-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/binutils/$(ARC_TAR)

COMPLETE := build.complete

$(COMPLETE):
	rm -rf build
	mkdir build

	cd build && $(ARC_TOOLCHAIN_BUILD)/gcc/binutils/$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)
	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)
