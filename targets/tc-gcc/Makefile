include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS := tc-binutils
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
	$(CP) -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} $(ARC_SOURCE_DIR)/libgcc
	$(CP) -pv $(ARC_BUILD_PREFIX)/share/libtool/build-aux/{config.sub,config.guess,install-sh} $(ARC_SOURCE_DIR)/libiberty

	$(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh -I"$$(realpath $(ARC_SOURCE_DIR)/config)"

	$(CD) $(ARC_SOURCE_DIR)/../          && \
		$(MKDIR) -p build            && \
		$(CD) build                  && \
		../src/configure $(AC_FLAGS) && \
		$(CD) ../                    && \
		$(MAKE) -C build all-gcc     && \
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
