DEPS :=
VERSION := dummy
NAME := libgcc-$(VERSION)
URLS :=

GCC_BUILD := $(ARC_TARGETS)/gcc-toolchain/build

.PHONY: build
build:
	$(MAKE) -C $(GCC_BUILD) all-target-libgcc
	$(MAKE) -C $(GCC_BUILD) install-target-libgcc

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

#.PHONY: get-source-dir
#get-source-dir:
#	@echo ""

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""