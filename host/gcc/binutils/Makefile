include $(ARC_TOOLCHAIN_BUILD)/gcc/binutils/Makefile

COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	$(MKDIR) -p build

	$(CD) build && $(ARC_TOOLCHAIN_BUILD)/gcc/binutils/$(ARC_SOURCE_DIR)/configure $(AC_FLAGS)
	$(MAKE) -C build
	$(MAKE) -C build install

	$(TOUCH) $(COMPLETE)
