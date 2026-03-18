ARC_VERSION := 0.22.5
ARC_NAME := gettext-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/gettext/$(ARC_TAR)
COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	$(MKDIR) -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	$(CD) build && ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	$(RM) ../libiconv/build.complete
	$(MAKE) -C ../libiconv

	$(TOUCH) $(COMPLETE)
