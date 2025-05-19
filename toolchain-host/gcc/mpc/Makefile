ARC_VERSION := 1.3.1
ARC_NAME := mpc-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/mpc/$(ARC_TAR)

COMPLETE := build.complete

$(COMPLETE):
	rm -rf build
	mkdir build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	make -C build
	make -C build install

	touch $(COMPLETE)

