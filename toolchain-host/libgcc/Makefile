COMPLETE := $(shell realpath build.complete)

$(COMPLETE):
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)/gcc/build all-target-libgcc
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)/gcc/build install-target-libgcc

	touch $(COMPLETE)
