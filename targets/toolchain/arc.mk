DEPS :=  \
	 host/mlibc-headers \
	 toolchain/autoconf \
	 toolchain/autoconf-2.69 \
	 toolchain/automake \
	 toolchain/libtool \
	 toolchain/gcc

VERSION := dummy
URLS := 

.PHONY: build
build:
	@echo "Definitely building"

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
	@echo "$(BOB_TARGETS)/toolchain/.src"

.PHONY: get-staging
get-staging:
	@echo "disabled"

#.PHONY: use-source-dir-of
#use-source-dir-of:
#	@echo ""

