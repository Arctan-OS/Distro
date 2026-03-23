DEPS := toolchain/gcc
VERSION := dummy
NAME := host/libgcc-$(VERSION)
URLS :=
USE_SRC_DIR_OF := toolchain/gcc

.PHONY: build
build:
	$(CD) $(SOURCE_DIR)/../build && \
		$(MAKE) all-target-libgcc
		$(MAKE) install-target-libgcc

.phony: clean
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

.PHONY: get-basename
get-basename:
	@echo $(NAME)

#.PHONY: get-source-dir
#get-source-dir:
#	@echo ""

.PHONY: use-source-dir-of
use-source-dir-of:
	@echo $(USR_SRC_DIR_OF)
