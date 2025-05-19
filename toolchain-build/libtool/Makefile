ARC_VERSION := 2.4.7
ARC_NAME := libtool-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://mirror.csclub.uwaterloo.ca/gnu/libtool/$(ARC_TAR)

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	mkdir -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	mkdir -p $(ARC_HOST_PREFIX)/share/libtool
	cp -pv $(ARC_BUILD_PREFIX)/share/autoconf/build-aux/config.sub $(ARC_HOST_PREFIX)/share/libtool

	touch $(COMPLETE)
