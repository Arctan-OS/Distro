ARC_VERSION := 5.2
ARC_NAME := bash-$(VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/bash/$(TAR)
COMPLETE := build.complete

$(COMPLETE):
	rm -rf build
	mkdir build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	cd build && $(AC_CFLAGS) ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)

	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)
