ARC_VERSION := 1.16.2
ARC_NAME := automake-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/automake/$(ARC_TAR)

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	mkdir -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install
	
	mkdir -p $(ARC_DESTDIR)$(ARC_HOST_PREFIX)/share/automake-1.16
	cp -pv $(ARC_BUILD_PREFIX)/share/autoconf/build-aux/config.sub $(ARC_HOST_PREFIX)/share/automake-1.16
	cp -pv $(ARC_BUILD_PREFIX)/share/autoconf/build-aux/config.sub $(ARC_BUILD_PREFIX)/share/automake-1.16

	touch $(COMPLETE)