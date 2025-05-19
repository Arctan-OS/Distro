AC_EXTRA_FLAGS := \
		--enable-languages=c,c++,lto \
		--enable-shared \
		--enable-host-shared \
		--disable-multilib \
		--enable-initfini-array \
		--disable-nls

export AC_EXTRA_FLAGS

COMPLETE := build.complete

$(COMPLETE):
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)/gcc/build all-target-libstdc++-v3
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)/gcc/build install-target-libstdc++-v3

	$(MAKE) -C gmp
	$(MAKE) -C mpfr
	$(MAKE) -C mpc

	$(MAKE) -C binutils

	rm -rf build
	mkdir build

	cd build && $(AC_CFLAGS) $(ARC_TOOLCHAIN_BUILD)/gcc/gcc-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)

	$(MAKE) -C build all-gcc
	$(MAKE) -C build install-gcc

	touch $(COMPLETE)
