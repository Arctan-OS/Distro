include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS :=
VERSION := 2.43
NAME := toolchain/binutils-$(VERSION)
URLS := https://ftp.gnu.org/gnu/binutils/binutils-$(VERSION).tar.gz

.PHONY: build
build:
# TODO: Fix some directories returning libtoolize:   error: AC_CONFIG_MACRO_DIRS([../../config]) conflicts with ACLOCAL_AMFLAGS=-I ..
#	$(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh

	$(CD) $(SOURCE_DIR)/../              && \
		$(MKDIR) -p build            && \
		$(CD) build                  && \
		../src/configure $(AC_FLAGS) && \
		$(CD) ../                    && \
		$(MAKE) -C build             && \
                $(MAKE) -C build install

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

.PHONY: get-basename
get-basename:
	@echo $(NAME)

#.PHONY: get-source-dir
#get-source-dir:
#	@echo ""

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""
