ARC_VERSION := 1.17
ARC_NAME := libiconv-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/libiconv/$(ARC_TAR)
COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	$(MKDIR) -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	$(CD) build && $(AC_CFLAGS) ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	$(TOUCH) $(COMPLETE)
