include $(ARC_BUILD_SUPPORT)/toolchain-flags

DEPS := 
VERSION := 1.16.2
NAME := toolchain/automake-$(VERSION)
URLS := https://ftp.gnu.org/gnu/automake/automake-$(VERSION).tar.gz

.PHONY: build
build:
	$(CD) $(SOURCE_DIR)/../              && \
		$(MKDIR) -p build            && \
		$(CD) build                  && \
		../src/configure $(AC_FLAGS) && \
		$(CD) ../                    && \
		$(MAKE) -C build             && \
                $(MAKE) -C build install

# NOTE: There used to be an $(ARC_DESTDIR) prefixing the command
#       below. Removed it as I don't think it is used
	$(MKDIR) -p $(ARC_HOST_PREFIX)/share/automake-1.16
	$(CP) -pv $(ARC_BUILD_PREFIX)/share/autoconf/build-aux/config.sub $(ARC_HOST_PREFIX)/share/automake-1.16
	$(CP) -pv $(ARC_BUILD_PREFIX)/share/autoconf/build-aux/config.sub $(ARC_BUILD_PREFIX)/share/automake-1.16

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
