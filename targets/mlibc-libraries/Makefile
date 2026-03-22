include $(ARC_BUILD_SUPPORT)/mlibc-flags

DEPS := mlibc-headers
USE_SRC_DIR_OF := mlibc-headers

STANDALONE_LIBGCC_DATE := 2025-08-21
STANDALONE_LIBGCC_MIRROR := https://github.com/osdev0/libgcc-binaries/releases/download/$(STANDALONE_LIBGCC_DATE)/libgcc-$(ARC_OPT_ARCH).a

$(ARC_SOURCE_DIR)/libgcc-$(ARC_OPT_ARCH).a:
	$(CURL) -Lo $(ARC_SOURCE_DIR)/libgcc-$(ARC_OPT_ARCH).a $(STANDALONE_LIBGCC_MIRROR)

.PHONY: build
build: $(ARC_SOURCE_DIR)/libgcc-$(ARC_OPT_ARCH).a
	$(RM) -rf $(ARC_SOURCE_DIR)/build
	$(MKDIR) -p $(ARC_SOURCE_DIR)/build

	$(CD) $(ARC_SOURCE_DIR) && $(ARC_SET_COMPILER_ENV_FLAGS) LDFLAGS="-Wl,$(ARC_SOURCE_DIR)/libgcc-$(ARC_OPT_ARCH).a" \
			    $(MESON) setup $(MESON_FLAGS) -Dno_headers=true -Dlibgcc_dependency=false
	$(MESON) install -C $(ARC_SOURCE_DIR)/build


.PHONY: clean
clean:
	@echo "Definitely cleaning"

.PHONY: prepare-rebuild
prepare-rebuild:
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

.PHONY: use-source-dir-of
use-source-dir-of:
	@echo $(USE_SRC_DIR_OF)
