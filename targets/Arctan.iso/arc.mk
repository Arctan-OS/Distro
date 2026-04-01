DEPS := toolchain \
	host \
	Kernel Userspace bootstrapper
VERSION := dummy
URLS := 

.PHONY: build
build:
	touch $(ARC_ROOT)/Arctan.iso

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

.PHONY: get-source-dir
get-source-dir:
	@echo "$(BOB_TARGETS)/Arctan.iso/.src"

.PHONY: get-staging
get-staging:
	@echo "disabled"

.PHONY: will-complete
will-complete:
	@echo "no"

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""

