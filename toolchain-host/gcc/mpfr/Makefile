ARC_VERSION := 4.2.1
ARC_NAME := mpfr-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/mpfr/$(ARC_TAR)

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	mkdir -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS) --enable-shared

	make -C build
	make -C build install

	touch $(COMPLETE)

