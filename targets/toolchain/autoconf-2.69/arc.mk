include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS := 
VERSION := 2.69
NAME := toolchain/autoconf-$(VERSION)
URLS := https://ftp.gnu.org/gnu/autoconf/autoconf-$(VERSION).tar.gz

.PHONY: build
build:
	$(CD) $(SOURCE_DIR)/../              && \
		$(MKDIR) -p build            && \
		$(CD) build                  && \
		../src/configure $(AC_FLAGS) && \
		$(CD) ../                    && \
		$(MAKE) -C build             && \
                $(MAKE) -C build install

.PHONY: clean
clean:
	$(RM) -rf $(SOURCE_DIR)/../build

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
