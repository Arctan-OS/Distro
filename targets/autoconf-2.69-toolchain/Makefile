include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS := 
VERSION := 2.69
NAME := autoconf-$(VERSION)
URLS := https://ftp.gnu.org/gnu/autoconf/$(NAME).tar.gz

.PHONY: build
build:
	$(MKDIR) -p build

	$(ARC_BUILD_SUPPORT)/recursive_autoreconf.sh
	$(CD) build && $(AC_CONFIG_PATH) $(AC_FLAGS)

	$(MAKE) -C build
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

#.PHONY: get-source-dir
#get-source-dir:
#	@echo ""

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""
