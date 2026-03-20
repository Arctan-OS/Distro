include $(ARC_BUILD_SUPPORT)/mlibc-flags

DEPS :=


.PHONY: build
build:
	$(MKDIR) -p $(ARC_SOURCE_DIR)/build

	$(CD) $(ARC_SOURCE_DIR) && $(MESON) subprojects download
	$(CD) $(ARC_SOURCE_DIR) && $(ARC_SET_COMPILER_ENV_FLAGS) $(MESON) setup $(MESON_FLAGS) -Dheaders_only=true
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

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""