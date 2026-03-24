DEPS := Kernel
VERSION := dummy
NAME := Userspace
URLS :=
DEV_SRC_DIR := $(ARC_ROOT)/../$(NAME)
SRC_DIR := $(BOB_TARGETS)/$(NAME)/src

.PHONY: build
build:
	$(BEAR) --output $(SOURCE_DIR)/compile_commands.json -- $(MAKE) -C $(SOURCE_DIR) all

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
ifeq ($(wildcard $(DEV_SRC_DIR),)
	@echo $(DEV_SRC_DIR)
else
	$(GIT) clone $(REPO_BASE_LINK)/$(NAME) $(SRC_DIR) --depth 1
	$(GIT) --git-dir $(SRC_DIR) submodule update --init
	@echo $(SRC_DIR)
endif
