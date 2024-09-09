COMPLETE := build.complete

$(COMPLETE):
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)/gcc/build all-target-libgcc
	DESTDIR=$(ARC_DESTDIR) $(MAKE) -C $(ARC_TOOLCHAIN_BUILD)/gcc/build install-target-libgcc

	touch $(COMPLETE)
