COMPLETE := build.complete

$(COMPLETE):
	rm -rf build
	mkdir build

	cd build && $(ARC_TOOLCHAIN_BUILD)/gcc/binutils/binutils-src/configure $(AC_FLAGS)
	$(MAKE) -C build
	DESTDIR=$(ARC_DESTDIR) $(MAKE) -C build install

	touch $(COMPLETE)
