include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS := 
VERSION := 2.72
NAME := autoconf-$(VERSION)
URLS := https://ftp.gnu.org/gnu/autoconf/$(NAME).tar.gz

.PHONY: build
build:
	$(CD) $(ARC_SOURCE_DIR)/../          && \
		$(MKDIR) -p build            && \
		$(CD) build                  && \
		../src/configure $(AC_FLAGS) && \
		$(CD) ../                    && \
		$(MAKE) -C build             && \
                $(MAKE) -C build install

.PHONY: clean
clean:
	@echo "Definitely cleaning"

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
