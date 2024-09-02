AC_EXTRA_FLAGS := \
		--with-sysroot \
		--with-build-sysroot=$(ARC_BUILD) \
		--enable-languages=c,c++,lto \
		--enable-shared \
		--enable-host-shared \
		--disable-multilib \
		--enable-initfini-array

COMPLETE := build.complete



$(COMPLETE):
	$(MAKE) -C binutils

	$(MAKE) -C gmp
	$(MAKE) -C mpfr
	$(MAKE) -C mpc

	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) $(ARC_TOOLCHAIN_BUILD)/gcc/gcc-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	$(MAKE) -C build all-gcc all-target-libgcc
	$(MAKE) -C build install-gcc install-target-libgcc

	touch $(COMPLETE)
