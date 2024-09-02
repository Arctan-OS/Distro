COMPLETE := build.complete

AC_EXTRA_FLAGS := \
		--with-sysroot \
		--with-build-sysroot=$(ARC_BUILD)
$(COMPLETE):
	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) $(ARC_TOOLCHAIN_BUILD)/gcc/binutils/binutils-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)
	$(MAKE) -C build
	$(MAKE) -C build install

	touch $(COMPLETE)
