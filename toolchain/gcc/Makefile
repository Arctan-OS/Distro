ARC_VERSION := 15.2.0
ARC_NAME := gcc-$(ARC_VERSION)
ARC_SOURCE_DIR := $(ARC_NAME)-src
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := https://ftp.gnu.org/gnu/gcc/$(ARC_NAME)/$(ARC_TAR)

AC_EXTRA_FLAGS := \
		--enable-languages=c,c++,lto \
		--enable-shared \
		--enable-host-shared \
		--disable-multilib \
		--enable-initfini-array

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	$(MAKE) -C binutils

	$(MKDIR) -p build

	$(ARC_BUILD_SUPPORT)/tar_helper.sh

	$(CP) -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} $(ARC_SOURCE_DIR)/libgcc
	$(CP) -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} $(ARC_SOURCE_DIR)/libiberty

	$(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh -I"$$(realpath $(ARC_SOURCE_DIR)/config)"

	$(CD) build && $(ARC_SET_COMPILER_ENV_FLAGS) $(ARC_SET_TARGET_COMPILER_ENV_FLAGS) ../$(ARC_SOURCE_DIR)/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	$(MAKE) -C build all-gcc
	$(MAKE) -C build install-gcc

	$(TOUCH) $(COMPLETE)
