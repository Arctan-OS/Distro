include $(ARC_BUILD_SUPPORT)/mlibc-flags

DEPS := host/mlibc-headers
USE_SRC_DIR_OF := host/mlibc-headers

STANDALONE_LIBGCC_DATE := 2025-12-08
STANDALONE_LIBGCC_NAME := libgcc-$(ARC_OPT_ARCH).a
STANDALONE_LIBGCC_MIRROR := https://github.com/osdev0/libgcc-binaries/releases/download/$(STANDALONE_LIBGCC_DATE)/$(STANDALONE_LIBGCC_NAME)

$(SOURCE_DIR)/$(STANDALONE_LIBGCC_NAME):
	$(CURL) -Lo $(SOURCE_DIR)/$(STANDALONE_LIBGCC_NAME) $(STANDALONE_LIBGCC_MIRROR)

.PHONY: build
build: $(SOURCE_DIR)/$(STANDALONE_LIBGCC_NAME)
	$(RM) -rf $(SOURCE_DIR)/build
	$(MKDIR) -p $(SOURCE_DIR)/build

	$(CD) $(SOURCE_DIR) && $(ARC_SET_COMPILER_ENV_FLAGS) LDFLAGS="-Wl,$(SOURCE_DIR)/$(STANDALONE_LIBGCC_NAME)" \
			    $(MESON) setup $(MESON_FLAGS) -Dno_headers=true -Duse_freestnd_hdrs=enabled -Dlibgcc_dependency=false
	$(MESON) install -C $(SOURCE_DIR)/build

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

.PHONY: get-basename
get-basename:
	@echo $(NAME)

#.PHONY: get-source-dir
#get-source-dir:
#	@echo ""

.PHONY: use-source-dir-of
use-source-dir-of:
	@echo $(USE_SRC_DIR_OF)
