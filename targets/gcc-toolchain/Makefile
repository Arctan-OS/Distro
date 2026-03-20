include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS := binutils-toolchain
VERSION := 15.2.0
NAME := gcc-$(VERSION)
URLS := https://ftp.gnu.org/gnu/gcc/$(NAME)/$(NAME).tar.gz

AC_EXTRA_FLAGS := \
		--enable-languages=c,c++,lto \
		--enable-shared \
		--enable-host-shared \
		--disable-multilib \
		--enable-initfini-array

# Originally configured so:
#  src-dir/
#  build-dir/
#  Makefile < you are here
# Now build-dir is in src-dir
.PHONY: build
build:
	$(MKDIR) -p build

	$(CP) -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} $(ARC_SOURCE_DIR)/libgcc
	$(CP) -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} $(ARC_SOURCE_DIR)/libiberty

	$(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh -I"$$(realpath $(ARC_SOURCE_DIR)/config)"

	$(CD) build && $(ARC_SET_COMPILER_ENV_FLAGS) $(ARC_SET_TARGET_COMPILER_ENV_FLAGS) $(ARC_SOURCE_DIR)/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	$(MAKE) -C build all-gcc
	$(MAKE) -C build install-gcc

.PHONY: clean
clean:
	rm -rf build

.PHONY: prepare-rebuild
prepare-rebuild: clean
	@echo "Definitely preparing rebuild"

.PHONY: get-deps
get-deps:
	@echo $(DEPS)

.PHONY: get-version
get-version:
	@echo $(VERSION)

.PHONY: get-urls
get-urls:
	@echo $(URLS)

#.PHONY: get-source-dir
#get-source-dir:
#	@echo ""

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""