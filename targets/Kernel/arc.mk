DEPS := host
VERSION := dummy
NAME := Kernel
URLS :=
DEV_SRC_DIR := $(ARC_ROOT)/../$(NAME)
SRC_DIR := $(BOB_TARGETS)/$(NAME)/src

.PHONY: build
build:
	$(BEAR) --output $(SOURCE_DIR)/compile_commands.json -- $(MAKE) -C $(SOURCE_DIR) all

.PHONY: clean
clean:
	$(RM) -f git.log

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
ifneq ($(wildcard $(DEV_SRC_DIR)),)
	@echo $(DEV_SRC_DIR)
else ifneq ($(wildcard $(SRC_DIR)),)
	@echo $(SRC_DIR)
else
	$(GIT) clone $(ARC_REPO_BASE_LINK)/$(NAME) $(SRC_DIR) --depth 1 &>> ../git.log
	$(CD) $(SRC_DIR) && $(GIT) submodule update --init &>> ../git.log
	@echo $(SRC_DIR)
endif

.PHONY: get-staging
get-staging:
	@echo "disabled"

.PHONY: will-complete
will-complete:
	@echo "no"
